# Update position of walker	
function update(w::Walker1D, s::Step1D;width::Int=1,length::Int=1)
    w+s
end



function update(w::Walker2D, s::Step2D,width::Int=1,length::Int=1)
    w+s
end


# Update position of walker on periodic XY domain discretised such that 
# width and length are integers indices 

function updateperiod(walker::Walker2D,state::Int64,rate::Float64,width::Int,length::Int)
    state == 1 && return walker
    pos = update(walker, stepper(state,stepping,rate))
    w₊ = (1/2)*width
    w₋ = -(1/2)*width
    l₊ = (1/2)*length
    l₋ = -(1/2)*length
    
    # Check x boundary
    if pos.x > w₊
        x = w₋
    elseif pos.x < w₋ 
        x = w₊
    else
        x = pos.x
    end
    
    # Check y boundary
    if pos.y > l₊
        y = l₋
    elseif pos.y < l₋ 
        y =  l₊
    else
        y = pos.y
    end
    
    return Walker2D(Int(x),Int(y))    
end


function updatenoflux(walker::Walker2D,state::Int64,rate::Float64,width::Int,length::Int)
    state == 1 && return walker
    pos = update(walker, stepper(state,stepping,rate))
    w₊ = (1/2)*width
    w₋ = -(1/2)*width
    l₊ = (1/2)*length
    l₋ = -(1/2)*length
    
    # Check x boundary
    if pos.x > w₊
        x = w₋
    elseif pos.x < w₋ 
        x = w₊
    else
        x = pos.x
    end
    
    # Check y boundary
    if pos.y > l₊ # north
        y = update(walker, stepper(state,stepping_no_north,rate)).y
    elseif pos.y < l₋ # 
        y = update(walker, stepper(state,stepping_no_south,rate)).y
    else
        y = pos.y
    end
    
    return Walker2D(Int(x),Int(y))    
end




# Update function for cell bonudary
# not done
# meant to be randomly chosen
function updatecell(walker::Walker2D,state::Int64,rate::Float64,width::Int,length::Int)
    state == 1 && return walker
    pos = update(walker, stepper(state,stepping,rate))
    w₊ = (1/2)*width
    w₋ = -(1/2)*width
    l₊ = (1/2)*length
    l₋ = -(1/2)*length
    
    # Check x boundary
    if pos.x > w₊
        x = w₋
    elseif pos.x < w₋ 
        x = w₊
    else
        x = pos.x
    end
    
    # Check y boundary
    if pos.y > l₊ # north
        y = update(walker, stepper(state,stepping_no_north,rate)).y
    elseif pos.y < l₋ # 
        y = update(walker, stepper(state,stepping_no_south,rate)).y
    else
        y = pos.y
    end
    
    return Walker2D(Int(x),Int(y)) 
end




