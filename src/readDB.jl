# functions for accessing db from chemsep .xml

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

    temp = EzXML.EzXML.attributes.(findall(
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
        (length(data) == lengthID) && (df[:, Symbol(name)] = data)
    end

    return df
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
