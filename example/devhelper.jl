using EzXML
using Revise

includet("..\\src\\purecompbase.jl")
includet("..\\src\\propsbase.jl")
includet("..\\src\\readDB.jl")

fileName = String("data\\chemsep1.xml")

dbRoot = getDBRoot(fileName)

idx = 1
tmp = EzXML.findfirst("//compounds/compound[" * string(idx) *"]", dbRoot)
props = nodes(tmp)
