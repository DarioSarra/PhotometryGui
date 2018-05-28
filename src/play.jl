selmice = selected_mice()

##
gr()
ui = @manipulate for i= 1:100, shape = [:diamond, :circle]
    scatter(rand(i),markershape = shape, size = (400, 300))
end;
##
observe(allignments[])[]
observe(traces[])[]
##
pse = (button("pse"))
printa = observe(pse)
display(vbox(pse))
on(t->println("ciao"),printa)
data[]
subdata[] = copy(data[]);
subdata[]
##

for x in values(trace_dict)
    if x == :Baseline
        continue
    end
    println(x)
end
subdata[]

##
width, height = 700, 300
colors = ["black", "gray", "silver", "maroon", "red", "olive", "yellow", "green", "lime", "teal", "aqua", "navy", "blue", "purple", "fuchsia"]
color(i) = colors[i%length(colors)+1]
ui = @manipulate for nsamples in 1:200,
        sample_step in slider(0.01:0.01:1.0, value=0.1, label="sample step"),
        phase in slider(0:0.1:2pi, value=0.0, label="phase"),
        radii in 0.1:0.1:60
    cxs_unscaled = [i*sample_step + phase for i in 1:nsamples]
    cys = sin.(cxs_unscaled) .* height/3 .+ height/2
    cxs = cxs_unscaled .* width/4pi
    dom"svg:svg[width=$width, height=$height]"(
        (dom"svg:circle[cx=$(cxs[i]), cy=$(cys[i]), r=$radii, fill=$(color(i))]"()
            for i in 1:nsamples)...
    )
end
##
using Plots, DataStructures

x = y = 0:0.1:30

freqs = OrderedDict(zip(["pi/4", "π/2", "3π/4", "π"], [π/4, π/2, 3π/4, π]))

mp = @manipulate for freq1 in freqs, freq2 in slider(0.01:0.1:4π; label="freq2")
    y = @. sin(freq1*x) * sin(freq2*x)
    plot(x, y)
end
##

function options_mice(subdata)
    empty!(mice_dict)
    for name in union(subdata[:MouseID])
        mice_dict[name] = checkbox(label = string(name))
        #on(t -> plt[] = histogram(subdata[name]), observe(button_dict[name]))
    end
    vbox(values(mice_dict)...)
end

##
filepath = filepicker();
filename = observe(filepath)
on(t -> (data[] = carica(t)), filename)
mice=Observable{Any}(button())
mice_dict = OrderedDict()
star = toggle()
on(t -> (mice[] = options_mice(t)), data);
display(vbox(filepath,mice))
##
using Sputnik
Sputnik.launch()
##
data[][:GLM]
using JuliaDB, IterableTables, Sputnik
JuliaDB.save(table(data[]), joinpath(Sputnik.tablefolder, "photometry"))
##
