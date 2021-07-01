# Update position of walker	
function update(w::Walker2D, s::Step2D,width::Int=1,length::Int=1)
    w+s
end


# Update position of walker on periodic XY domain discretised such that 
# width and length are integers indices 
function updateperiod(w::Walker2D, s::Step2D,width::Int,length::Int)
    pos = update(w, s)
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


# Update where domain is periodic in one direction and 
# midline reflective in the other direction
# Rectangle version of a capsule
# Not ready

function updatecell(w::Walker2D, s::Step2D,width::Int,length::Int)
    # x width say 0 to 100
    pos = update(w, s)
    xstep = pos.x
    ystep = pos.y
    
    if xstep == width + 1
        xstep = 0
    elseif xstep == -1
        xstep = length
    elseif ystep == length + 1
        ystep = length
        xstep = width - xstep
    elseif ystep == -1
        ystep = 0
        xstep = width - xstep
    end
    
    Walker2D(xstep, ystep)
end
