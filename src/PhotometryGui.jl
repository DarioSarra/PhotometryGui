#module PhotometryGui

using InteractBulma, Plots, Blink, Observables, JLD2, DataFrames, JuliaDBMeta
using CSSUtil, DataStructures, WebIO, FileIO, ShiftedArrays, Query

# Global variables:
# mice_dict
# data
# subdata
# ...

include("createbuttons.jl");
include("plotsetting.jl");
include("selecteddata.jl");

# function launch
filepath = filepicker();
filename = observe(filepath);
data = Observable{Any}(DataFrame(x = rand(10)))
map!(carica, data, filename)
# on(t -> (data[] = carica(t)), filename);
# map!(carica,data, filename, options...)

subdata = Observable{Any}(DataFrame())
on(t -> (subdata[] = copy(data[])), filename)

trace_dict = Observable{Any}(OrderedDict("put"=>1,"something" =>2))
map!(options_traces, trace_dict, data)
traces = map(dropdown, trace_dict)

allignment_dict = Observable{Any}(OrderedDict("put"=>1,"something" =>2))
map!(options_allignments,allignment_dict, data)
allignments = map(dropdown, allignment_dict)

# allignments = Observable{Any}(dropdown(OrderedDict("put"=>1,"something" =>2)))
# allignment_dict = OrderedDict()
# on(t ->(allignments[] = options_allignments(t)),data);

start = InteractBase.input()
stop = InteractBase.input()

plt = Observable{Any}(plot(rand(10)))
plotButton = (button("Plot"));
plotter = observe(plotButton);
on(t -> plt[] = makeplot(),plotter);

mice_dict  = Observable{Any}(OrderedDict("Mickey"=>1,"Mouse" =>2))
map!(options_checkboxes,mice_dict,data,:MouseID)
mice = map(checkboxes,mice_dict)

protocol_dict = Observable{Any}(OrderedDict("Mendoku"=>1,"Sai" =>2))
map!(options_checkboxes,protocol_dict,data,:Protocol)
protocols = map(checkboxes, protocol_dict)

gen_dict = Observable{Any}(OrderedDict("X"=>1,"Man" =>2))
map!(options_checkboxes,gen_dict,data,:Gen)
genotypes = map(checkboxes, gen_dict)

daystart = Observable{Any}(dropdown(OrderedDict("start"=>1,"date" =>2)))
daystop =  Observable{Any}(dropdown(OrderedDict("stop"=>1,"date" =>2)))
days_dict = OrderedDict()
on(t -> (daystart[] = option_days(t)), data)
on(t -> (daystop[] = option_days(t)), data)

file_layout = filepath
plotvar_layout = hbox(start, stop),hbox(traces, allignments)
plot_layout = hbox(plotButton, plt)
select_layout = hbox(mice, protocols, genotypes,vbox(daystart,daystop))
ui =(vbox(file_layout, plotvar_layout,hbox(plot_layout,select_layout)))
# ui_obs = Observable{Any}(ui)
# body!(Window(), dom"div"(ui_obs))
w = Window()
body!(w, ui)
#end #module

##
## Pietro's ramblings
s = dropdown(["Mickey","Mouse", "dasdad", "asdadasd", "asdadsa"], label = "MouseID", multiple = true)
display(s)
using Blink
body!(Window(), s)
observe(s)
##
