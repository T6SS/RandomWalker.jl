
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

struct Step1D{T} <: AbstractWalker
    x::T
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
