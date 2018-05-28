function selected_mice()
    [key for (key, val) in mice_dict if observe(val)[]]
end

function makeplot(subdata)
    INDS = parse(Int64,observe(start)[]):parse(Int64,observe(stop)[])
    WHAT = Symbol(observe(traces[])[])
    selmice = selected_mice()
    selinds = find(t -> t in selmice, subdata[:MouseID])
    result = plot(INDS,reduce_vec(mean,subdata[selinds, WHAT],INDS,default = NaN))
    return result
end
function shiftdata(predata)
    WHAT = Symbol(observe(allignments[])[])
    dataset = predata[.!ismissing.(predata[WHAT]),:]
    for i = 1:size(dataset,1)
        for x in values(trace_dict)
            if x == :Baseline
                continue
            end
            dataset[i,x] = lag(parent(dataset[i,x]),-dataset[i,WHAT])
        end
    end
    return dataset
end
