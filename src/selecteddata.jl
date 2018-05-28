function selected_mice()
    [key for (key, val) in mice_dict if observe(val)[]]
end
selected_mice()

function selected_protocols()
    [key for (key, val) in protocol_dict if observe(val)[]]
end
selected_mice()
