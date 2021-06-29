module RandomWalker

using Reexport

@Reexport using DataFrames
@Reexport using Random
@Reexport using Distributions
@Reexport using Pipe

export 
    position,
    hopping_rate,
    prob,
    multidist,
    step,
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
    period_path_df



include("position.jl")
include("step.jl")
include("update.jl")
include("path.jl")
include("meta_walker.jl")

# Define abstract walker type

abstract type AbstractWalker end

# Make walker structs
struct Walker1D{T} <: AbstractWalker
    pos::T
end

struct Walker2D{T} <: AbstractWalker
    x::T
    y::T
end

struct Step2D{T} <: AbstractWalker
    x::T
    y::T
end 

struct walker_end_point_meta <: AbstractWalker
    time::Float64
    rate::Float64
    xₜ::Int64
    yₜ::Int64
end

struct WalkersData <:AbstractWalker
    nwalks::Int
    timesteps::Int
    rate::Float64
    width::Int
    length::Int
    x::Int
    y::Int
end




end
