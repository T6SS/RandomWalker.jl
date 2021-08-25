module RandomWalker

using Reexport

@reexport using Revise
@reexport using DataFrames
@reexport using Random
@reexport using Distributions


export 
    position,
    hopping_rate,
    prob,
    multidist,
    stepping,
    stepper,
    update,
    updateperiod,
    updatecell,
    path,
    paths,
    paths_df,
    endpoint,
    meta_walk,
    meta_path,
    period_path,
    period_path_df,
    Walker1D,
    Walker2D,
    Step2D,
    walker_end_point_meta,
    WalkersData,
    AbstractWalker


include("type_struct.jl")
include("position.jl")
#updating
include("step.jl")
include("update.jl")
include("path.jl")
include("meta_walker.jl")

# Define abstract walker type




end
