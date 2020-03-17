#GroupContribution Struct.
#it statically stores the id and values.
struct GroupContribution{N}
    id::NTuple{N,Int}
    value::NTuple{N,Int}
end

#==
Property Struct:
it holds a value and its metadata.
for now, the metadata is the long name and the units.
the property is parametrically typed on the value, to recognize if is a 
string, Int, Float, VariableProperty, or GroupContribution. 
it can replace IntVal, StringVal, 
TODO:in the future, using Unitful to hold the value, something like:
Property{T,UNITS} where UNITS <: Unitful.Unit
==#

struct Property{T}
    name::String
    units::String
    value::T
end

value(prop::Property) = prop.value
name(prop::Property) = prop.name
units(prop::Property) = prop.units


#==
#those structs are no longer used in this branch.

struct ScalarProperty
    units::String
    value::Float64
end

struct RangeBoundary
    units::String
    value::Float64
end

struct VectorProperty
    units::String
    EqNo::Int
    A::Float64
    B::Float64
    C::Float64
    D::Float64
    E::Float64
    Tmin::RangeBoundary
    Tmax::RangeBoundary
end

struct PureComp
    LibraryIndex::Int
    CompoundID::String
    StructureFormula::String
    Family::Int
    CriticalTemperature::ScalarProperty
    CriticalPressure::ScalarProperty
    CriticalVolume::ScalarProperty
    CriticalComperssibility::ScalarProperty
    NormalBoilingPointTemperature::ScalarProperty
    NormalMeltingPointTemperature::ScalarProperty
    TripplePointTemperature::ScalarProperty
    TripplePointPressure::ScalarProperty
    MolecularWeight::ScalarProperty
    LiquidVolumeAtNormalBoilingPoint::ScalarProperty
    AcentricityFactor::ScalarProperty
    SolubilityParameter::ScalarProperty
    DipoleMoment::ScalarProperty
    HeatOfFormation::ScalarProperty
    GibbsEnergyOfFormation::ScalarProperty
    AbsEntropy::ScalarProperty
    HeatOfFusionAtMeltingPoint::ScalarProperty
    HeatOfCombustion::ScalarProperty
    LiquidDensity::VectorProperty
    VaporPressure::VectorProperty
    HeatOfVaporization::VectorProperty
    LiquidHeatCapacityCp::VectorProperty
    IdealHeatCapacityCp::VectorProperty
    SecondVirialCoefficient::VectorProperty
    LiquidViscosity::VectorProperty
    VaporViscosity::VectorProperty
    LiquidThermalConductivity::VectorProperty
    VaporThermalConductivity::VectorProperty
    RPPHeatCapacityCp::VectorProperty
    RelativeStaticPermittivity::VectorProperty
    AntoineVaporPressure::VectorProperty
    LiquidViscosityRPS::VectorProperty
    COSTALDVolume::ScalarProperty
    DiameterLJ::ScalarProperty
    EnergyLJ::ScalarProperty
    RacketParameter::ScalarProperty
    FullerVolume::ScalarProperty
    Parachor::ScalarProperty
    SpecificGravity::ScalarProperty
    Charge::ScalarProperty
    CostaldAcentricFactor::ScalarProperty
    WilsonVolume::ScalarProperty
    ChaoSeaderAcentricFactor::ScalarProperty
    ChaoSeaderSolubilityParameter::ScalarProperty
    ChaoSeaderLiquidVolume::ScalarProperty
    CAS::String
end
==#

