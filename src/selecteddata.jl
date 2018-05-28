function selected_mice()
    [key for (key, val) in mice_dict if observe(val)[]]
end
selected_mice()

function selected_protocols()
    [key for (key, val) in protocol_dict if observe(val)[]]
end

function selected_genotypes()
    [key for (key, val) in genotype_dict if observe(val)[]]
end


function apply_selection()
    sel_data = JuliaDB.table(data[])
    signal = Symbol(observe(traces[])[])
    event = Symbol(observe(allignments[])[])
    daybegin = days_dict[observe(daystart[])[]]
    dayend = days_dict[observe(daystop[])[]]
    sel_data = Lazy.@as x sel_data begin
        select(x, (signal,event,:MouseID, :Protocol, :Gen, :Day))
        filter(i -> ((i.MouseID in collect(selected_mice())) &&
        (i.Protocol in collect(selected_protocols())) &&
        (i.Gen in collect(selected_genotypes())) &&
        (daybegin<=i.Day<=dayend)), x)
    end
    @byrow! sel_data begin
           cols(signal) = lag(parent(cols(signal)),-cols(event))
       end
    return sel_data
end
