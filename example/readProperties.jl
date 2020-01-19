# example of reading properties from chemsep .xml database with PhysProps

using PhysProps
using CSV # for writing out the data frame

fileName = String("data\\chemsep1.xml")

dbRoot = getDBRoot(fileName)

# example of extracting first level properties
ID = extractColumn(dbRoot, "CompoundID")

# example of extracting end level properties
eqnNo = extractColumn(dbRoot, "LiquidDensity/eqno")
A = extractColumn(dbRoot, "LiquidDensity/A")

# example of extracing property that is not the last attribute in the xml node (e.g. 1st attribute)
nameZ = extractColumn(dbRoot, "LiquidDensity", 1)

# get a dataframe with component properties, note this is still in progress, needs to be error checked and corrected for deeper structure hierarchies
df = getPropertyDataFrame(fileName)
# write out to CSV
CSV.write("example\\output.csv", df)
