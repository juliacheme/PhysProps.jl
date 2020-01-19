module PhysProps

using EzXML
using DataFrames

export
    # read from database, could decide to not export these at later point
      getDBRoot,
      extractColumn,
      getPropertyDataFrame

include("readDB.jl")
include("purecompbase.jl")
include("propsbase.jl")
include("properties.jl")

end # module
