#the strategy is the following:
#== UnivariateFunction is a type hierarchy do dispatch on functions with ranges.
it's tighly coupled with the VariableProperty struct.
Calling a variable property will return a result depending on the type of UnivariateFunction
This gives the advantage to decouple the use of a dict in each call of a property.
==#
abstract type UnivariateFunction end
struct ConstantEq <: UnivariateFunction end
struct LinearEq <: UnivariateFunction end
struct CuadraticEq <: UnivariateFunction end
struct CubicPolyEq <: UnivariateFunction end
struct EqNo5 <: UnivariateFunction end
struct EqNo6 <: UnivariateFunction end
struct AntoineEq <: UnivariateFunction end
struct Poly4Eq <: UnivariateFunction end
struct DIPPREq <: UnivariateFunction end
struct EqNo102 <: UnivariateFunction end
struct EqNo103 <: UnivariateFunction end
struct EqNo104 <: UnivariateFunction end
struct EqNo105 <: UnivariateFunction end
struct EqNo106 <: UnivariateFunction end
struct EqNo107 <: UnivariateFunction end
struct EqNo114 <: UnivariateFunction end
struct EqNo117 <: UnivariateFunction end

struct EqNo11 <: UnivariateFunction end
struct EqNo12 <: UnivariateFunction end
struct EqNo13 <: UnivariateFunction end
struct EqNo14 <: UnivariateFunction end
struct EqNo15 <: UnivariateFunction end
struct EqNo16 <: UnivariateFunction end
struct EqNo17 <: UnivariateFunction end
struct EqNo18 <: UnivariateFunction end
struct EqNo19 <: UnivariateFunction end
struct EqNo45 <: UnivariateFunction end
struct EqNo75 <: UnivariateFunction end
struct EqNo118 <: UnivariateFunction end
struct EqNo120 <: UnivariateFunction end
struct EqNo121 <: UnivariateFunction end
struct EqNo122 <: UnivariateFunction end
struct EqNo123 <: UnivariateFunction end
struct EqNo124 <: UnivariateFunction end
struct EqNo125 <: UnivariateFunction end
struct EqNo130 <: UnivariateFunction end
struct EqNo131 <: UnivariateFunction end
struct EqNo150 <: UnivariateFunction end
struct EqNo200 <: UnivariateFunction end
struct EqNo201 <: UnivariateFunction end
struct EqNo206 <: UnivariateFunction end
struct EqNo207 <: UnivariateFunction end
struct EqNo208 <: UnivariateFunction end
struct EqNo209 <: UnivariateFunction end
struct EqNo210 <: UnivariateFunction end
struct EqNo211 <: UnivariateFunction end
struct EqNo212 <: UnivariateFunction end
struct EqNo213 <: UnivariateFunction end
struct EqNo221 <: UnivariateFunction end
struct EqNo230 <: UnivariateFunction end
struct EqNo231 <: UnivariateFunction end
#== 
_EqNo transforms a number to the appropiate UnivariateFunction Type
This is basically the Dict, but at compile time.
Some names are used, to make the VariableProperty Struct more readable.
==#
_EqNo(x::Int) = _EqNo(Val(x))
_EqNo(x::Val{1}) =  ConstantEq() #there was a value 1, that i can interpret as a constant.
_EqNo(x::Val{2}) =  LinearEq()
_EqNo(x::Val{3}) =  CuadraticEq()
_EqNo(x::Val{4}) =  CubicPolyEq()
_EqNo(x::Val{5}) =  EqNo5()
_EqNo(x::Val{6}) =  EqNo6()
_EqNo(x::Val{10}) = AntoineEq()
_EqNo(x::Val{100}) = Poly4Eq()
_EqNo(x::Val{101}) = DIPPREq()
_EqNo(x::Val{102}) = EqNo102()
_EqNo(x::Val{103}) = EqNo103()
_EqNo(x::Val{104}) = EqNo104()
_EqNo(x::Val{105}) = EqNo105()
_EqNo(x::Val{106}) = EqNo106()
_EqNo(x::Val{107}) = EqNo107()
_EqNo(x::Val{114}) = EqNo114()
_EqNo(x::Val{117}) = EqNo117()

_EqNo(x::Val{11}) = EqNo11()
_EqNo(x::Val{12}) = EqNo12()
_EqNo(x::Val{13}) = EqNo13()
_EqNo(x::Val{14}) = EqNo14()
_EqNo(x::Val{15}) = EqNo15()
_EqNo(x::Val{16}) = EqNo16()
_EqNo(x::Val{17}) = EqNo17()
_EqNo(x::Val{18}) = EqNo18()
_EqNo(x::Val{19}) = EqNo19()
_EqNo(x::Val{45}) = EqNo45()
_EqNo(x::Val{75}) = EqNo75()
_EqNo(x::Val{118}) = EqNo118()
_EqNo(x::Val{120}) = EqNo120()
_EqNo(x::Val{121}) = EqNo121()
_EqNo(x::Val{122}) = EqNo122()
_EqNo(x::Val{123}) = EqNo123()
_EqNo(x::Val{124}) = EqNo124()
_EqNo(x::Val{125}) = EqNo125()
_EqNo(x::Val{130}) = EqNo130()
_EqNo(x::Val{131}) = EqNo131()
_EqNo(x::Val{150}) = EqNo150()
_EqNo(x::Val{200}) = EqNo200()
_EqNo(x::Val{201}) = EqNo201()
_EqNo(x::Val{206}) = EqNo206()
_EqNo(x::Val{207}) = EqNo207()
_EqNo(x::Val{208}) = EqNo208()
_EqNo(x::Val{209}) = EqNo209()
_EqNo(x::Val{210}) = EqNo210()
_EqNo(x::Val{211}) = EqNo211()
_EqNo(x::Val{212}) = EqNo212()
_EqNo(x::Val{213}) = EqNo213()
_EqNo(x::Val{221}) = EqNo221()
_EqNo(x::Val{230}) = EqNo230()
_EqNo(x::Val{231}) = EqNo231()
#max_length is used to check if some function hasn't enough parameters.
max_length(x :: T) where T<:UnivariateFunction= 0
max_length(x::ConstantEq) = 1
max_length(x::LinearEq) = 2
max_length(x::CuadraticEq) = 3
max_length(x::CubicPolyEq) = 4
max_length(x::AntoineEq) = 3
max_length(x::Poly4Eq) = 5
max_length(x::DIPPREq) = 5
max_length(x::EqNo102) = 4
max_length(x::EqNo103) = 4
max_length(x::EqNo104) = 5
max_length(x::EqNo105) = 4
max_length(x::EqNo106) = 5
max_length(x::EqNo107) = 5
max_length(x::EqNo114) = 4
max_length(x::EqNo117) = 5


#struct to hold the variable property,can hold parameters, or Tc where necessary.
#with those types, its is fully stack-allocated. if passed to a thermodynamic routine,
#the evaluation will be fast.
struct VariableProperty{F <: UnivariateFunction ,T <: Real,N}
    f::F
    p::NTuple{N,T}
    valid_range::NTuple{2,T}
end 

#Variable property constructor.
#it does some analisis in some cases, where a function is used, but all parameters are zero,
#efectively making that function constant.
function VariableProperty(eqno::Int,p,valid_range) where _FF <: UnivariateFunction
    _T = promote_type(eltype(p),eltype(valid_range))
    p0 = first(p)
    p_nonzero = filter(!iszero,[i for i in p])
    _F = ConstantEq()
    _N = 0
    #check if property is just a constant,then apply constant function (f1)
    if (length(p_nonzero) == 1) && p0 == first(p_nonzero) && (eqno != 1) && (eqno in (2,3,4,100,103,104,107))
        _F = ConstantEq()
        _N = 1
    else
        _F = _EqNo(eqno)
        _N = length(p)
    end

    #check if length of respective type is correct
    if max_length(_F) > length(p)
        throw(ArgumentError("not enough parameters for $eqno property"))
    end
    P = NTuple{_N,_T}(convert(_T,i) for i in p)
    R = NTuple{2,_T}(convert(_T,i) for i in valid_range)
return VariableProperty{typeof(_F),_T,_N}(_F,P,R)
end

#@inline f11(T,p) = p[1] p[2] p[3] p[4] p[5]
@inline (prop::EqNo11)(T,p) = exp(p[1])
@inline (prop::EqNo12)(T,p) = exp(p[1]+p[2]*T)
@inline (prop::EqNo13)(T,p) = exp(p[1]+p[2]*T+p[3]*T^2)
@inline (prop::EqNo14)(T,p) = exp(p[1]+p[2]*T+p[3]*T^2+p[4]*T^3)
@inline (prop::EqNo15)(T,p) = exp(p[1]+p[2]*T+p[3]*T^2+p[4]*T^3+p[5]*T^4)
@inline (prop::EqNo16)(T,p) = p[1] + exp(p[2]/T + p[3] + p[4]*T +p[5]*T^2)
@inline (prop::EqNo17)(T,p) = p[1] + exp(p[2] + p[3]*T + p[4]*T^2 +p[5]*T^3)
@inline (prop::EqNo18)(T,p) = p[1] + p[2]*(1+log(T)*(1+p[3]/T))*exp(-p[3]/T)
@inline (prop::EqNo19)(T,p) = p[1] + p[2]*T*log(T)*exp(-p[3]/T)
@inline (prop::EqNo45)(T,p) = p[1]*T + (p[2]*T^2)/2 + (p[3]*T^3)/3 + (p[4]*T^4)/4 + (p[5]*T^5)/5
@inline (prop::EqNo75)(T,p) = p[2]*(2*p[3]*T + 3*p[4]*T^2 + 4*p[5]*T^3) #weird too, check
@inline (prop::EqNo118)(T,p) = exp(p[1] + p[2]/(T^p[5]) + p[3]*log(T) + p[4]*T^2) #weird too check
@inline (prop::EqNo120)(T,p) = p[1] - p[2]/(p[3] + T) #LogAntoine
@inline (prop::EqNo121)(T,p) =  p[1] + p[2]/T + p[3]*log(T) + p[4]*T^p[5]
@inline (prop::EqNo122)(T,p) =  p[1] + p[2]/T + p[3]*log(T) + p[4]*T^2 + p[5]/(T^2)
@inline (prop::EqNo123)(T,p) =  p[1] + p[2]/T + p[3]*T + p[4]*T^2 + p[5]*(T^3)
@inline (prop::EqNo124)(T,p) =  p[1] + p[2]/T + p[3]/(T^2) + p[4]*T + p[5]*(T^2)
@inline (prop::EqNo125)(T,p) =  exp(p[1] + p[2]/T + p[3]/(T^2) + p[4]*T + p[5]*(T^2))
@inline (prop::EqNo130)(T,p) =  exp(p[1] + p[2]/T + p[3]*log(T) + p[4]*T + p[5]/(T^2))
@inline (prop::EqNo131)(T,p) =  p[1] + p[2]*T + p[3]/(T-p[4])
@inline (prop::EqNo150)(T,p) = p[1]+p[2]*T+p[3]*T^2+p[4]*T^3 + p[5]/(T^2)

@inline function (prop::EqNo200)(Tr,p) 
    t = 1-Tr
    return p[5]*exp((p[1]*t + p[2]*t^1.5 + p[3]*t^2.5 + p[4]*t^5)/Tr)
end

@inline function (prop::EqNo201)(Tr,p) 
    t = 1-Tr
    return p[5]+ exp((p[1]*t + p[2]*t^1.5 + p[3]*t^2.5 + p[4]*t^5)/Tr)
end

@inline function (prop::EqNo206)(Tr,p) 
    t =Tr
    return p[5]+ exp(p[1]+p[2]/(p[3]+t+p[4]*t^2 + p[5]*t^3))
end
@inline (prop::EqNo207)(T,p) = exp(p[1] - p[2]/(p[3] + T))
@inline (prop::EqNo208)(T,p) = exp10(p[1] - p[2]/(p[3] + T))
@inline (prop::EqNo209)(T,p) = exp10(p[1]*(1/T - 1/p[2]))
@inline (prop::EqNo210)(T,p) = exp10(p[1] + p[2]/T + p[3]*T + p[4]*T^2)
@inline (prop::EqNo211)(T,p) = p[1]*((p[2]-T)/(p[2]-p[3]))^p[4]
@inline function (prop::EqNo212)(T,p) 
    a = (1-T/p[5])
    pol = p[1]*a + p[2]*a^1.5 + p[3]*a^3 + p[4]^6
    return exp((p[5]*T)*pol)
end

@inline function (prop::EqNo213)(T,p) 
    t = T - 1
    pol = 1 + p[3]*t + p[4]*t^2 + p[5]*t^3
    return (p[1]-p[2])/pol
end
@inline (prop::EqNo221)(T,p) = -p[2]/(T^2) + p[3]/T + p[4]*p[5]*T^(p[5]-1) 
@inline (prop::EqNo230)(T,p) = -p[2]/(T^2) + p[3]/T + p[4] - 2*p[5]/T^3 
@inline (prop::EqNo231)(T,p) = p[2] - p[3]/(T-p[4])^2
#functor,calling the property like a function.
#==as these function calls are cheap,
the function returns for now the value and a bool indicating if thats a valid range.
an alternative would be adding a keyword to allow the evaluation of the property outside the range 
==#
@inline function (prop::VariableProperty)(T)
    low,high = prop.valid_range
    if low <= T <= high
        return prop.f(T,prop.p),true
    else
        return prop.f(T,prop.p),false
    end
end

#dispatch to call the f functions from UnivariateFunction.
#technically you can write the implementation right here
@inline (prop::ConstantEq)(T,p) = p[1]
@inline (prop::LinearEq)(T,p) = p[1] + p[2]*T
@inline (prop::CuadraticEq)(T,p) = p[1] + p[2]*T + p[3]*T^2
@inline (prop::CubicPolyEq)(T,p) =  p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3
@inline (prop::EqNo5)(T,p) = p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3 + p[5]*T^4
@inline (prop::EqNo6)(T,p) =  p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3 + p[5]/T^2
@inline (prop::AntoineEq)(T,p) =  exp(p[1] - p[2]/(p[3] + T))
@inline (prop::Poly4Eq)(T,p)  =  p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3 + p[5]*T^4
@inline (prop::DIPPREq)(T,p) =  exp(p[1] + p[2]/T + p[3]*log(T) + p[4]*T^p[5])
@inline (prop::EqNo102)(T,p) =  p[1]*T^p[2]/(1 + p[3]/T + p[4]/T^2)
@inline (prop::EqNo103)(T,p) =  p[1] + p[2]*exp(-p[3]/(T^p[4]))
@inline (prop::EqNo104)(T,p) =   p[1] + p[2]/T + 1E6*p[3]/T^3 + 1E16*p[4]/T^8 + 1E18*p[5]/T^9
@inline (prop::EqNo105)(T,p) =  p[1]/(p[2]^(1 + (1 - T/p[3])^p[4]))
@inline (prop::EqNo106)(Tr,p) = p[1]*(1-Tr)^(p[2]+p[3]*Tr+p[4]*Tr^2+p[5]*Tr^3)
@inline (prop::EqNo107)(T,p) =  p[1] + p[2]*((p[3]/T)/sinh(p[3]/T))^2 + p[5]*((p[4]/T)*cosh(p[4]/T))^2
@inline (prop::EqNo114)(T,p) =  p[1]*T + p[2]*T^2/2 + p[3]*T^3/3 + p[4]*T^4/4
@inline (prop::EqNo117)(T,p) =  p[1]*T + p[2]*(p[3]/T)/tanh(p[3]/T) - p[4]*(p[5]/T)/tanh(p[5]/T)

# Generic function to call the right temperature dependency
#function calcvectorproperty(T, prop::VectorProperty)
#    tfunc = tfuncs[prop.EqNo]
#    tfunc(T, prop.A, prop.B, prop.C, prop.D, prop.E)
#end


