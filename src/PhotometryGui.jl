#module PhotometryGui

using InteractBulma, Plots, Blink, Observables, JLD2, DataFrames, JuliaDBMeta
using CSSUtil, DataStructures, WebIO, FileIO, ShiftedArrays, Query

include("createbuttons.jl");
include("plotsetting.jl");
include("selecteddata.jl");

filepath = filepicker();
filename = observe(filepath);
data = Observable{Any}(DataFrame())
on(t -> (data[] = carica(t)), filename);

subdata = Observable{Any}(DataFrame())
on(t -> (subdata[] = copy(data[])), filename)

traces = Observable{Any}(dropdown(OrderedDict("put"=>1,"something" =>2)))
trace_dict = OrderedDict()
on(t ->(traces[] = options_traces(t)),data);

allignments = Observable{Any}(dropdown(OrderedDict("put"=>1,"something" =>2)))
allignment_dict = OrderedDict()
on(t ->(allignments[] = options_allignments(t)),data);

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

genotypes = Observable{Any}(checkbox())#mice=Observable{Any}(button())
genotype_dict = OrderedDict()
on(t -> (genotypes[] = options_genotypes(t)), data);

daystart = Observable{Any}(dropdown(OrderedDict("start"=>1,"date" =>2)))
daystop =  Observable{Any}(dropdown(OrderedDict("stop"=>1,"date" =>2)))
days_dict = OrderedDict()
on(t -> (daystart[] = option_days(t)), data)
on(t -> (daystop[] = option_days(t)), data)


ui =(vbox(filepath, hbox(start, stop),hbox(traces, allignments),hbox(plotButton, plt, mice, protocols, genotypes,vbox(daystart,daystop))))
w = Window()
body!(w, ui)
#end #module
