module RandomWalker

using Reexport

@reexport using Revise
@reexport using Random
@reexport using Distributions


export 
    AbstractWalker,
    Walker1D,
    Walker2D,
    Step2D,
    Step1D,
    position,
    hopping_rate,
    prob,
    prob_no_flux,
    multidist,
    multidist_no_flux,
    stepping,
    stepping_no_north,
    stepping_no_south,
    stepper,
    step,
    update,
    updateperiod,
    updatenoflux,
    updatecell

include("type_struct.jl")
include("position.jl")
include("step.jl")
include("update.jl")
end
