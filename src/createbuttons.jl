function carica(filename)
    file = load(filename) #streak_table
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
    # hbox(values(trace_dict)...)
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
    #hbox(values(allignment_dict)...)
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
