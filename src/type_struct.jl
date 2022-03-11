
abstract type AbstractWalker end

# Make walker structs
struct Walker1D{T} <: AbstractWalker
    x::T
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

