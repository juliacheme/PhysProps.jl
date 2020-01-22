"""
    getDBRoot(fileName)
Get root node of .xml database
"""
function getDBRoot(fileName::String)::EzXML.Node
    xdoc = EzXML.readxml(fileName)
    dbRoot = EzXML.root(xdoc)
    return dbRoot
end

"""
    extractColumn(dbRoot, propName, n=0)
Extract a column of data providing the root node, and the property name as described in the .xml file. To access deeper levels use '/' e.g. "LiquidDensity/eqno"
This function corrects the type from String to Int64 or Float64.
"""
function extractColumn(dbRoot::EzXML.Node, propName::String, n::Int64 = 0)

    temp = EzXML.attributes.(findall(
        "//compounds/compound/" * propName,
        dbRoot,
    ))::Array{Array{EzXML.Node,1},1}

    if (n == 0)
        data = EzXML.nodecontent.(hcat(temp...)[end, :])
    else
        data = EzXML.nodecontent.(hcat(temp...)[n, :])
    end

    # type correction if possible, all values need to be of Int64/Float64 for conversion to take place
    if (sum(isnothing.(tryparse.(Int64, data))) == 0)
        data = parse.(Int64, data)
    elseif (sum(isnothing.(tryparse.(Float64, data))) == 0)
        data = parse.(Float64, data)
    end

    return data
end

"""
    getPropertyDataFrame(fileName)
Return a DataFrame containing component properties for a given filename
"""
function getPropertyDataFrame(fileName::String)::DataFrame # this function is not complete, still in progress
    dbRoot = getDBRoot(fileName)

    # some columns have a deeper structure, need to update column selected based on node depth
    columnNames = EzXML.nodename.(findall("//compounds/compound[1]/*", dbRoot))

    ID = extractColumn(dbRoot, "CompoundID")
    lengthID = length(ID)

    df = DataFrame(ID = ID)

    for name in columnNames
        data = extractColumn(dbRoot, name)
        (length(data) == lengthID) && (df[!, Symbol(name)] = data)
    end

    return df
end

@inline getScalar(props, propnum) = ScalarProperty(props[propnum]["units"], parse(Float64, props[propnum]["value"]))

function getVector(props, propnum)
    units = props[propnum]["units"]
    eqno =  parse(Int, EzXML.elements(props[propnum])[1]["value"])

    A_ = EzXML.findfirst("A", props[propnum])
    A = isnothing(A_) ? 0.0 : parse(Float64, A_["value"])
    B_ = EzXML.findfirst("B", props[propnum])
    B = isnothing(B_) ? 0.0 : parse(Float64, B_["value"])
    C_ = EzXML.findfirst("C", props[propnum])
    C = isnothing(C_) ? 0.0 : parse(Float64, C_["value"])
    D_ = EzXML.findfirst("D", props[propnum])
    D = isnothing(D_) ? 0.0 : parse(Float64, D_["value"])
    E_ = EzXML.findfirst("E", props[propnum])
    E = isnothing(E_) ? 0.0 : parse(Float64, E_["value"])

    Tmin_ = EzXML.findfirst("Tmin", props[propnum])
    Tmin = RangeBoundary(Tmin_["units"], parse(Float64, Tmin_["value"]))
    Tmax_ = EzXML.findfirst("Tmax", props[propnum])
    Tmax = RangeBoundary(Tmax_["units"], parse(Float64, Tmax_["value"]))

    return VectorProperty(units, eqno, A, B, C, D, E, Tmin, Tmax)
end

function extractComp(dbRoot, idx)
    tmp = EzXML.findfirst("//compounds/compound[" * string(idx) *"]", dbRoot)
    props = nodes(tmp)

    # LibraryIndex::Int
    libidx = parse(Int, props[2]["value"])
    # CompoundID::String
    cmpid = props[4]["value"]
    # StructureFormula::String
    struture = props[6]["value"]
    # Family::Int
    family = parse(Int, props[8]["value"])
    # CriticalTemperature::ScalarProperty
    Tc = getScalar(props, 10)
    # CriticalPressure::ScalarProperty
    Pc = getScalar(props, 12)
    # CriticalVolume::ScalarProperty
    Vc = getScalar(props, 14)
    # CriticalComperssibility::ScalarProperty
    Zc = getScalar(props, 16)
    # NormalBoilingPointTemperature::ScalarProperty
    Tb = getScalar(props, 18)
    # NormalMeltingPointTemperature::ScalarProperty
    Tf = getScalar(props, 20)
    # TripplePointTemperature::ScalarProperty
    T3 = getScalar(props, 22)
    # TripplePointPressure::ScalarProperty
    P3 = getScalar(props, 24)
    # MolecularWeight::ScalarProperty
    MW = getScalar(props, 26)
    # LiquidVolumeAtNormalBoilingPoint::ScalarProperty
    Vb = getScalar(props, 28)
    # AcentricityFactor::ScalarProperty
    omega = getScalar(props, 30)
    # SolubilityParameter::ScalarProperty
    lambda = getScalar(props, 32)
    # DipoleMoment::ScalarProperty
    mu = getScalar(props, 34)
    # HeatOfFormation::ScalarProperty
    hf = getScalar(props, 36)
    # GibbsEnergyOfFormation::ScalarProperty
    gf = getScalar(props, 38)
    # AbsEntropy::ScalarProperty
    sabs = getScalar(props, 40)
    # HeatOfFusionAtMeltingPoint::ScalarProperty
    hff = getScalar(props, 42)
    # HeatOfCombustion::ScalarProperty
    hc = getScalar(props, 44)
    # LiquidDensity::VectorProperty
    rhol = getVector(props, 46)
    # VaporPressure::VectorProperty
    Psat = getVector(props, 48)
    # HeatOfVaporization::VectorProperty
    hvap = getVector(props, 50)
    # LiquidHeatCapacityCp::VectorProperty
    cpliq = getVector(props, 52)
    # IdealHeatCapacityCp::VectorProperty
    cpig = getVector(props, 54)
    # SecondVirialCoefficient::VectorProperty
    virB = getVector(props, 56)
    # LiquidViscosity::VectorProperty
    muL = getVector(props, 58)
    # VaporViscosity::VectorProperty
    muV = getVector(props, 60)
    # LiquidThermalConductivity::VectorProperty
    kL = getVector(props, 62)
    # VaporThermalConductivity::VectorProperty
    kV = getVector(props, 64)
    # RPPHeatCapacityCp::VectorProperty
    cpRPP = getVector(props, 66)
    # RelativeStaticPermittivity::VectorProperty
    epsRel = getVector(props, 68)
    # AntoineVaporPressure::VectorProperty
    PAnt = getVector(props, 70)
    # LiquidViscosityRPS::VectorProperty
    muRPS = getVector(props, 72)
    # COSTALDVolume::ScalarProperty
    VCost = getScalar(props, 74)
    # DiameterLJ::ScalarProperty
    sigLJ = getScalar(props, 76)
    # EnergyLJ::ScalarProperty
    eLJ = getScalar(props, 78)
    # RacketParameter::ScalarProperty
    ZRa = getScalar(props, 80)
    # FullerVolume::ScalarProperty
    VFuller = getScalar(props, 82)
    # Parachor::ScalarProperty
    par = getScalar(props, 84)
    # SpecificGravity::ScalarProperty
    SG = getScalar(props, 86)
    # Charge::ScalarProperty
    charge = getScalar(props, 88)
    # CostaldAcentricFactor::ScalarProperty
    omegaCost = getScalar(props, 90)
    # WilsonVolume::ScalarProperty
    VWils = getScalar(props, 92)
    # ChaoSeaderAcentricFactor::ScalarProperty
    OmegaCS = getScalar(props, 94)
    # ChaoSeaderSolubilityParameter::ScalarProperty
    lambdaCS = getScalar(props, 96)
    # ChaoSeaderLiquidVolume::ScalarProperty
    VCS = getScalar(props, 98)
    # CAS::StringVal
    CAS = props[100]["value"]

    return PureComp(
        libidx,
        cmpid,
        struture,
        family,
        Tc,
        Pc,
        Vc,
        Zc,
        Tb,
        Tf,
        T3,
        P3,
        MW,
        Vb,
        omega,
        lambda,
        mu,
        hf,
        gf,
        sabs,
        hff,
        hc,
        rhol,
        Psat,
        hvap,
        cpliq,
        cpig,
        virB,
        muL,
        muV,
        kL,
        kV,
        cpRPP,
        epsRel,
        PAnt,
        muRPS,
        VCost,
        sigLJ,
        eLJ,
        ZRa,
        VFuller,
        par,
        SG,
        charge,
        omegaCost,
        VWils,
        OmegaCS,
        lambdaCS,
        VCS,
        CAS
    )
end

"""
_parse_property(compound_node)

parse a property and returns the proper struct from the ChemSep XML
"""
function parse_property(property)
    identifier = Symbol(property.name) #Symbol of the property name
    elems = length(EzXML.elements(property))
    if iszero(elems) #is value, float, int or String
        data = EzXML.attributes(property)
        name = data[1].content
        raw_value = data[end].content
        if length(data) == 3 #property is a float number
            units =  data[2].content
            value = parse(Float64,raw_value)
            return identifier,Property(name,units,value)
        elseif length(data) == 2 #value is String or Int
            if name in ("Index","Family") #only ints 
                value = parse(Int,raw_value)
                return identifier,Property(name,"_",value)
            else 
                return identifier,Property(name,"_",raw_value)
            end
        end
    elseif EzXML.firstelement(property).name == "eqno" #Variable Property
        data = EzXML.attributes(property)
        valuedata = EzXML.elements(property)
        len = length(valuedata)
        name = data[1].content
        units = data[2].content
        eqno = parse(Int,attributes(valuedata[1])[1].content)
        parameters = [parse(Float64,attributes(valuedata[i])[1].content) for i in 2:(len-2)]
        valid_range = [parse(Float64,attributes(valuedata[i])[2].content) for i in (len-1):len]
        value = VariableProperty(eqno,parameters,valid_range)
        return identifier,Property(name,units,value)
    elseif EzXML.firstelement(property).name == "group" #GroupContribution
        data = EzXML.attributes(property)
        name = data[1].content
        groups = EzXML.elements(property)
        len = length(groups)
        id_vector = Int[]
        value_vector = Int[]
        for group in groups
            raw_id,raw_value = EzXML.attributes(group)
            push!(id_vector,parse(Int,raw_id))
            push!(value_vector,parse(Int,raw_value))
        end
        _id = NTuple{len,Int}(id_vector)
        _value = NTuple{len,Int}(value_vector)
        value = GroupContribution{len}(_id,_value)
        return identifier,Property(name,"_",value)
    end
end


    """
    parse_compound(compound_node)
    
    parses the XML of a compound node. returns a Dict{Symbol,Property}
    
    """
function parse_compound(compound)
    symbols = Symbol[]
    properties = Property[]
    for property in EzXML.eachelement(compound)
        name, prop = parse_property(property)
        push!(symbols,name)
        push!(properties,prop)
    end 
    return comp = Dict{Symbol,Property}((i,j) for (i,j) in zip(symbols,properties))   
end
