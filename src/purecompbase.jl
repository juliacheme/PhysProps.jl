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
