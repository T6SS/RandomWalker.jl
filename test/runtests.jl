using RandomWalker
using Test

@testset "RandomWalker.jl" begin
    

    # Unit parameters
    N = 10^5
    width,length = 2,2
    x = 1
    y = 1
    x₊₁ = 1
    y₊₁ = 1
    nx = x + x₊₁
    ny = y + y₊₁
    state₀ = 0
    state₁ = 1
    steps = [(-1, 0),(1, 0),(0, 0),(0, -1),(0, 1)]
    Set_steps = Set([Step2D(i[1],i[2]) for i in steps])
    steps_no_north = [(-1, 0),(1, 0),(0, 0),(0, -1)]
    Set_steps_no_north = Set([Step2D(i[1],i[2]) for i in steps_no_north])
    steps_no_south = [(-1, 0),(1, 0),(0, 0),(0, 1)]
    Set_steps_no_south = Set([Step2D(i[1],i[2]) for i in steps_no_south])
    r = 0.25
    rₚ = [r,r,1-4*r,r,r]
    rₚ₁ = [r,r,1-3*r,r]
    w₁ = Walker1D(1)
    w₂ = Walker2D(1,1)
    s₁ = Step1D(x₊₁)
    s₂ = Step2D(x₊₁,y₊₁)
    x̂₁ = RandomWalker.position(w₁)
    x̂₂,ŷ₂ = RandomWalker.position(w₂)
    r̂ = hopping_rate(r)
    r̂ₚ = prob(hopping_rate(r))
    r̂ₚ₁ = prob_no_flux(hopping_rate(r))
    mr̂ₚ = multidist(r)
    mr̂ₚ₁ = multidist_no_flux(r)

    # Test the ability to extract position
    @test x̂₁ == x 
    @test (x̂₂,ŷ₂) ==  (x,y)


    # Test step function and bast addition
    @test Walker1D(nx) == w₁ + s₁
    @test Walker2D(nx, ny) == w₂ + s₂
    @test all([Step2D(0,0) == stepper(0,0.0) for i in 1:N]) #test 
    @test w₁ + s₁ isa Walker1D
    @test w₂ + s₂ isa Walker2D
    @test s₂ + s₂ isa Step2D




    # Test hopping rate functionality
    @test r̂ == r
    @test r̂ₚ == rₚ
    @test r̂ₚ₁ == rₚ₁

    # Test Multinomial
    @test mr̂ₚ.p == rₚ
    @test mr̂ₚ₁.p == r̂ₚ₁

    # Test Multinomial step
    @test all([stepping(r) ∈ Set_steps for i in 1:N])
    @test all([stepping_no_north(r) ∈ Set_steps_no_north for i in 1:N])
    @test all([stepping_no_south(r) ∈ Set_steps_no_south for i in 1:N])
    @test all([Step2D(0,0) == stepper(state₀ ,stepping,r) for i in 1:N])
    @test all([Step2D(0,0) == stepper(state₀ ,stepping_no_north,r) for i in 1:N])
    @test all([Step2D(0,0) == stepper(state₀,stepping_no_south,r) for i in 1:N])
    @test all([stepper(state₁ ,stepping,r) ∈ Set_steps for i in 1:N])
    @test all([stepper(state₁ ,stepping_no_north,r) ∈ Set_steps_no_north for i in 1:N])
    @test all([stepper(state₁,stepping_no_south,r) ∈ Set_steps_no_south for i in 1:N])


    # Test update function
    @test update(w₁, s₁) isa Walker1D
    @test update(w₂, s₂) isa Walker2D
    @test update(w₁, s₁) == w₁ + s₁
    @test update(w₂, s₂) == w₂ + s₂

    # (width,length) = (2,2)
    # ±1/2(width,length) = -1 ≤ x ≤ 1 ∩ -1 ≤ y ≤ 1
    #@test Walker2D(-1,0) == updateperiod(Walker2D(1,0),Step2D(1,0),width,length)
    #@test Walker2D(1,0) == updateperiod(Walker2D(-1,0),Step2D(-1,0),width,length)
    #@test Walker2D(0,-1) == updateperiod(Walker2D(0,1),Step2D(0,1),width,length)
    #@test Walker2D(0,1) == updateperiod(Walker2D(0,-1),Step2D(0,-1),width,length)

    # width,length = 2,4
    # -1 ≤ x ≤ 1 ∩ -5 ≤ y ≤ 5
    # test length updates
    #@test all([Walker2D(0,2) == updateperiod(Walker2D(0,1),Step2D(0,1),2,4) for i in 1:N])
    #@test all([Walker2D(0,-2) == updateperiod(Walker2D(0,-1),Step2D(0,-1),2,4) for i in 1:N])
    #@test all([Walker2D(0,1) == updatenoflux(Walker2D(0,1),state₀,r,width,length) for i in 1:N])

    #ywalks = [k[2] for k in [RandomWalker.position(j) for j in [updatenoflux(state₁,Walker2D(0,10),r,width,length*10) for i in 1:N]]]
    #@test maximum(ywalks) == 10
    #@test minimum(ywalks) == 9







end
