function makeplot()
    seld = apply_selection()
    INDS = parse(Int64,observe(start)[]):parse(Int64,observe(stop)[])
    signal = Symbol(observe(traces[])[])
    t = select(seld, signal)
    result = plot(INDS,reduce_vec(mean,t,INDS,default = NaN))
    return result
end
# ##
# gr(fmt = :svg)
# seld = apply_selection()
# INDS = parse(Int64,observe(start)[]):parse(Int64,observe(stop)[])
# signal = Symbol(observe(traces[])[])
# t = select(seld, signal)
# result = plot()
# JuliaDBMeta.groupby(seld,:Gen, usekey=true, select=signal) do key, dd
#     plot!(INDS, reduce_vec(mean,dd,INDS,default = NaN),label = key.Gen)
# end
#
# display(result)
