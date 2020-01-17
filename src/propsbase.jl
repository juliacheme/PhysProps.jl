# Non-exposed functions that will be used by the wrapper functions
# TODO: Check these for typos!

function f2(T, p...)
    return p[1] + p[2]*T
end

function f3(T, p...)
    return p[1] + p[2]*T + p[3]*T^2
end

function f4(T, p...)
    return p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3
end

function f5(T, p...)
    return p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3 + p[5]*T^4
end

function f6(T, p...)
    return p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3 + p[5]/T^2
end

function f10(T, p...)
    return exp(p[1] - p[2]/(p[3] + T))
end

function f100(T, p...)
    return p[1] + p[2]*T + p[3]*T^2 + p[4]*T^3 + p[5]*T^4
end

function f101(T, p...)
    return exp(p[1] + p[2]/T + p[3]*ln(T) + p[4]*T^p[5])
end

function f102(T, p...)
    return p[1]*T^p[2]/(1 + p[3]/T + p[4]/T^2)
end

function f103(T, p...)
    return p[1] + p[2]*exp(-p[3]/(T^p[4]))
end

function f104(T, p...)
    return p[1] + p[2]/T + 1E6*p[3]/T^3 + 1E16*p[4]/T^8 + 1E18*p[5]/T^9
end

function f105(T, p...)
    return p[1]/(p[2]^(1 + (1 - T/p[3])^p[4]))
end

# Note that Tr is passed, rather than T
# Sticking to passing the value directly, rather than passing
# both T and Tc allows a more general calculation.
# This needs to be handled somewhere...
# TODO: Make a list of properties using eq 106! Handle in wrapper functions
function f106(Tr, p...)
    return p[1]*(1-Tr)^(p[2]+p[3]*Tr+p[4]*Tr^2+p[5]*Tr^3)
end

function f107(T, p...)
    return p[1] + p[2]*((p[3]/T)/sinh(p[3]/T))^2 + p[5]*((p[4]/T)*cosh(p[4]/t))^2
end

function f114(T, p...)
    return p[1]*T + p[2]*T^2/2 + p[3]*T^3/3 + p[4]*T^4/4
end

function f117(T, p...)
    return p[1]*T + p[2]*(p[3]/T)/tanh(p[3]/T) - p[4]*(p[5]/T)/tanh(p[5]/T)
end

# Look-up dictionary to call the right function from a stored EqNo property
tfuncs = Dict(
    2   => f2,
    3   => f3,
    4   => f4,
    5   => f5,
    6   => f6,
    10  => f10,
    100 => f100,
    101 => f101,
    102 => f102,
    103 => f103,
    104 => f104,
    105 => f105,
    106 => f106,
    107 => f107,
    114 => f114,
    117 => f117
)

# Generic function to call the right temperature dependency
function calcvectorproperty(T, prop::VectorProperty)
    tfunc = tfuncs[prop.EqNo]
    tfunc(T, prop.A, prop.B, prop.C, prop.D, prop.E)
end
