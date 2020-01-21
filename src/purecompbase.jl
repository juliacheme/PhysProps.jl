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
