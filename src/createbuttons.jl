function carica(filename)
    file = FileIO.load(filename) #streak_table
    table = file[collect(keys(file))[1]]
    table
end

function options_traces(data)
    dict = OrderedDict()
    for name in names(data)
        if eltype(data[name])<:ShiftedArray
            #trace_dict[name] = button(string(name))
            dict[string(name)] = name
        end
    end
    dict
end

function options_allignments(data)
    dict = OrderedDict()
    for name in names(data)
        if (contains(string(name),"In_")||contains(string(name),"Out_"))
            dict[string(name)] = name
        end
    end
    dict
end


function options_checkboxes(data,column)
    dict = OrderedDict()
    for name in union(data[column])
        dict[string(name)] = string(name)
    end
    dict
end
# function options_mice(data)
#     dict = OrderedDict()
#     for name in union(data[:MouseID])
#         dict[name] = checkbox(label = string(name))
#         #on(t -> plt[] = histogram(data[name]), observe(button_dict[name]))
#     end
#     vbox(values(dict)...)
# end

function options_protocols(data)
    dict = OrderedDict()
    for name in union(data[:Protocol])
        dict[name] = checkbox(label = string(name))
        #on(t -> plt[] = histogram(data[name]), observe(button_dict[name]))
    end
    vbox(values(dict)...)
end

function options_genotypes(data)
    dict = OrderedDict()
    for name in union(data[:Gen])
        dict[name] = checkbox(label = string(name))
        #on(t -> plt[] = histogram(data[name]), observe(button_dict[name]))
    end
    vbox(values(dict)...)
end

function option_days(data)
    dict = OrderedDict()
    for day in sort(union(data[:Day]))
        dict[string(day)] = string(day)
    end
    dropdown(dict)
end
