
# Add to the base functions
Base.:+(w::Walker1D, s::Step1D) = Walker1D(w.x+s.x)
Base.:+(w1::Walker1D, w2::Walker1D) = Walker1D(w1.x+w2.x)
Base.:+(s₁::Step1D,s₂::Step1D) = Step1D(s₁.x+s₂.x)
Base.:+(w::Walker2D, s::Step2D) = Walker2D(w.x+s.x,w.y+s.y)
Base.:+(w1::Walker2D, w2::Walker2D) = Walker2D(w1.x+w2.x,w1.y+w2.y)
Base.:+(s₁::Step2D,s₂::Step2D) = Step2D(s₁.x+s₂.x,s₁.y+s₂.y)

# Update position with Mulitnomial Distribution
# Each step is taken with a hopping rate r
# Probability of hopping
# Mulitnomial steps
# Hopping rate
hopping_rate(r::Float64) = r

# Probability
prob(hopping_rate) = [hopping_rate,hopping_rate, 1-4*hopping_rate, hopping_rate,hopping_rate]
prob_no_flux(hopping_rate) = [hopping_rate,hopping_rate, 1-3*hopping_rate, hopping_rate]


# Multinomial
multidist(rate::Float64) = Multinomial(1,prob(hopping_rate(rate)))
multidist_no_flux(rate::Float64) = Multinomial(1,prob_no_flux(hopping_rate(rate)))


# Stepping functions
function stepping(rate::Float64)
    steps = [(-1, 0),(1, 0),(0, 0),(0, -1),(0, 1)]
    s = steps[findall(!iszero,rand(multidist(rate),1))]
    return Step2D(s[1][1],s[1][2])
end

function stepping_no_north(rate::Float64)
    steps = [(-1, 0),(1, 0),(0, 0),(0, -1)]
    s = steps[findall(!iszero,rand(multidist_no_flux(rate),1))]
    return Step2D(s[1][1],s[1][2])
end

function stepping_no_south(rate::Float64)
    steps = [(-1, 0),(1, 0),(0, 0),(0, 1)]
    s = steps[findall(!iszero,rand(multidist_no_flux(rate),1))]
    return Step2D(s[1][1],s[1][2])
end


function stepper(state::Int,rate::Float64) 
    return stepping(!Bool(state)*rate)
end


function stepper(state::Int,step::Function,rate::Float64) 
    nrate = !Bool(state)*rate
        return step(nrate)
end
                                        
function step(r::Float64;Δx = 1::Real)
    u = rand()
    if u < r
        s = 1
    elseif u < 2*r
        s = -1
    else
        s = 0
    end
    return Step1D(s*Δx)
end



