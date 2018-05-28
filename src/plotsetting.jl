function makeplot()
    seld = apply_selection()
    INDS = parse(Int64,observe(start)[]):parse(Int64,observe(stop)[])
    signal = Symbol(observe(traces[])[])
    t = select(seld, signal)
    result = plot(INDS,reduce_vec(mean,t,INDS,default = NaN))
    return result
end
