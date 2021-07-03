

# Update position with Mulitnomial Distribution
# Each step is taken with a hopping rate r
# Probability of hopping
# Mulitnomial steps
hopping_rate(r::Float64) = r
prob(hopping_rate) = [hopping_rate,hopping_rate, 1-4*hopping_rate, hopping_rate,hopping_rate]
multidist(rate) = Multinomial(1,prob(hopping_rate(rate)))
function stepping(rate)
    steps = [(-1, 0),(1, 0),(0, 0),(0, -1),(0, 1)]
    s = steps[findall(!iszero,rand(multidist(rate),1))]
    return Step2D(s[1][1],s[1][2])
end

Base.:+(w::Walker2D, s::Step2D) = Walker2D(w.x+s.x,w.y+s.y)

Base.:+(s₁::Step2D,s₂::Step2D) = Walker2D(s₁.x+s₂.x,s₁.y+s₂.y)