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
        (length(data) == lengthID) && (df[:, Symbol(name)] = data)
    end

    return df
end
