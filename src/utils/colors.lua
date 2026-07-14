-- Colors
colors = {
    TOUHOU_FAIRY_PINK = "fca4d9",
    TOUHOU_CHERRY = "ffbce4",
    TOUHOU_MYSTIC_HUMAN = "5959cc",
    TOUHOU_MYSTIC_NEUTRAL = "ffffff",
    TOUHOU_MYSTIC_YOUKAI = "c85858",
    TOUHOU_MYSTIC = "ffffff",
    TOUHOU_BLIND_MANIPULATE = "3f4f52",
} 
if G.C then
    for k, v in pairs(colors) do
        G.C[k] = HEX(v)
    end
end
if G.ARGS then
    local prev_loc_colours = G.ARGS.LOC_COLOURS or {}
    loc_colour('')
    for k, v in pairs(prev_loc_colours) do
        G.ARGS.LOC_COLOURS[k:lower()] = HEX(v)
    end
    for k, v in pairs(colors) do
        G.ARGS.LOC_COLOURS[k:lower()] = HEX(v)
    end
end

SMODS.Gradient{
    key = "touhou_chips_mult",
    colours = {
        G.C.CHIPS,
        G.C.MULT,
    },
    cycle = 4
}