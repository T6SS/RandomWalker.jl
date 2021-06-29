function meta_walk(metapairs)
    return walker_end_point_meta(
            metapairs[1],
            metapairs[2],
            metapairs[3],
            metapairs[4])
end



# Generate a dataframe from several walks
function meta_path(wd::Vector{Any})
    totallength = size(wd,1)
    Nwalks = size(wd[1],1)
    NN = totallength*Nwalks

    completeSet = [wd[i][j] for i in 1:totallength for j in 1:Nwalks]

    arrayData = [[completeSet[i].nwalks completeSet[i].timesteps completeSet[i].rate completeSet[i].width completeSet[i].length completeSet[i].x completeSet[i].y] for i in 1:NN]

    arrDF = reduce(vcat,arrayData)

    return DataFrame(arrDF,[:nwalks, :timesteps, :rate, :width, :length, :x, :y])
end