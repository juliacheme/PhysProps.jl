# example of reading properties from chemsep .xml database with PhysProps

using PhysProps
using CSV # for writing out the data frame

fileName = String("data\\chemsep1.xml")

dbRoot = getDBRoot(fileName)

compound = PhysProps.parse_compound(firstelement(dbRoot)) #returns a Dict
