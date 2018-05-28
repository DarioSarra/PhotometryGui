function carica(filename)
    file = FileIO.load(filename) #streak_table
    table = file[collect(keys(file))[1]]
    table
end

function options_traces(subdata)
    empty!(trace_dict)
    for name in names(subdata)
        if eltype(subdata[name])<:ShiftedArray
            #trace_dict[name] = button(string(name))
            trace_dict[string(name)] = name
        end
    end
    dropdown(trace_dict)
end

function options_allignments(subdata)
    empty!(allignment_dict)
    for name in names(subdata)
        if (contains(string(name),"In_")||contains(string(name),"Out_"))
            allignment_dict[string(name)] = name
        end
    end
    dropdown(allignment_dict)
end

function options_mice(subdata)
    empty!(mice_dict)
    for name in union(subdata[:MouseID])
        mice_dict[name] = checkbox(label = string(name))
        #on(t -> plt[] = histogram(subdata[name]), observe(button_dict[name]))
    end
    vbox(values(mice_dict)...)
end

function options_protocols(subdata)
    empty!(protocol_dict)
    for name in union(subdata[:Protocol])
        protocol_dict[name] = checkbox(label = string(name))
        #on(t -> plt[] = histogram(subdata[name]), observe(button_dict[name]))
    end
    vbox(values(protocol_dict)...)
end

function options_genotypes(subdata)
    empty!(genotype_dict)
    for name in union(subdata[:Gen])
        genotype_dict[name] = checkbox(label = string(name))
        #on(t -> plt[] = histogram(subdata[name]), observe(button_dict[name]))
    end
    vbox(values(genotype_dict)...)
end

function option_days(subdata)
    empty!(days_dict)
    for day in sort(union(subdata[:Day]))
        days_dict[string(day)] = day
    end
    dropdown(days_dict)
end
