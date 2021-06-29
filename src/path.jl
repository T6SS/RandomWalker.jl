
# Path that the walk takes
function path(
    u,
    w::Walker2D, 
    timesteps::Int64,
    rate::Float64,
    width::Int=1,
    length::Int=1)
# W is a type parameter
ws = [position(w)]

for i in 1:timesteps
    w = u(w, step(rate),width,length)
    push!(ws, position(w))
end
return ws
end


# Create local functions
function period_path(t,r,l,w)
    path(
        updateperiod,
        Walker2D(0,0),
        Int(round(t,digits=0)),
        r,w,l)
end

function period_path_df(t,r,l,w)
    DataFrame(
        reduce(
            vcat,
            [[i[1] i[2]] for i in period_path(t,r,l,w)]),
        [:x, :y])
end

# Taking more than one path
function paths(
Nwalks::Int,
u,
w::Walker2D, 
timesteps::Int64,
rate::Float64,
width::Int=1,
length::Int=1)
displace = []

for k in 1:Nwalks
    t = path(
                u,w,timesteps,rate,width,length)
    tup = endpoint(t)
    data = WalkersData(
        Nwalks,
        timesteps,
        rate,
        width,
        length,
        tup.x,
        tup.y)
    
    push!(displace,data)
end
return displace
end

# Last point in a path
function endpoint(t)
    return Walker2D(t[end][1],t[end][2])
end



   
function paths_df(
    paramRange::Int,
    largestTime::Int,
    Nwalks::Int,
    updateRule,
    w::Walker2D,
    width::Int=1,
    length::Int=1
    )
timesteps = range(1,largestTime,length=paramRange)
rate = range(0.001, 0.25, length=paramRange)
dis_vec = []
for i in 1:paramRange,j in 1:paramRange
Walks = paths(
    Nwalks,
    updateRule,
    w, 
    Int(round(timesteps[i],digits=0)),
    rate[j],
    width,
    length)
push!(dis_vec,Walks)
end
df = WalkersData2DataFram(dis_vec)


df.taxcabdisplacement = abs.(df.x) .+ abs.(df.y)
df.taxcabdisplacement² = abs.(df.x).^2 .+ abs.(df.y).^2
df.sqrttaxcabdisplacement² = sqrt.(df.taxcabdisplacement²)

return df
end
