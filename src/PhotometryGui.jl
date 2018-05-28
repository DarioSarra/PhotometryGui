#module PhotometryGui

using InteractBulma, Plots, Blink, Observables, DataFrames, JuliaDBMeta
using CSSUtil, DataStructures, WebIO,FileIO, ShiftedArrays, Query

include("createbuttons.jl");
include("plotsetting.jl");

filepath = filepicker();
filename = observe(filepath)
data = Observable{Any}(DataFrame())
on(t -> (data[] = carica(t)), filename)

subdata = Observable{Any}(DataFrame())
on(t -> (subdata[] = copy(data[])), filename)

traces = Observable{Any}(dropdown(OrderedDict("put"=>1,"something" =>2)))
trace_dict = OrderedDict()
on(t ->(traces[] = options_traces(t)),data);

allignments = Observable{Any}(dropdown(OrderedDict("put"=>1,"something" =>2)))
allignment_dict = OrderedDict()
on(t ->(allignments[] = options_allignments(t)),data);

shiftButton = (button("Shift"));
shifter = observe(shiftButton);
on(t -> (subdata[] = shiftdata(data[])),shifter);

start = InteractBase.input()
stop = InteractBase.input()

plt = Observable{Any}(plot(rand(10)))
plotButton = (button("Plot"));
plotter = observe(plotButton);
on(t -> plt[] = makeplot(),plotter);

mice = Observable{Any}(checkbox)#mice=Observable{Any}(button())
mice_dict = OrderedDict()
on(t -> (mice[] = options_mice(t)), data);

protocols = Observable{Any}(checkbox())#mice=Observable{Any}(button())
protocol_dict = OrderedDict()
on(t -> (protocols[] = options_protocols(t)), data);

ui =(vbox(filepath, hbox(start, stop),hbox(traces, allignments,shiftButton),hbox(plotButton, plt, mice, protocols)))
w = Window()
body!(w, ui)
#end #module
##

##
buttons = Observable{Any}(button())
button_dict = OrderedDict()
on(t -> (buttons[] = makebuttons(t)), data);
function makebuttons(subdata)
    empty!(button_dict)
    for name in names(subdata)
        button_dict[name] = button(string(name))
        on(t -> plt[] = histogram(subdata[name]), observe(button_dict[name]))
    end
    vbox(values(button_dict)...)
end
#INDS = parse(Int64,observe(start)[]):parse(Int64,observe(stop)[])
