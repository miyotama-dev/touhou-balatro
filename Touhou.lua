-- Sorry, it's a complete mess~

TOUHOU = TOUHOU or {}

to_big = to_big or function(x) return x end

SMODS.current_mod.optional_features = {
	retrigger_joker = true,
	post_trigger = true,
}

assert(SMODS.load_file("./src/misc/atlases.lua"))()

assert(SMODS.load_file("./src/utils/variables.lua"))()
assert(SMODS.load_file("./src/utils/functions.lua"))()
assert(SMODS.load_file("./src/utils/colors.lua"))()

assert(SMODS.load_file("./src/content/decks.lua"))()
assert(SMODS.load_file("./src/content/enhancements.lua"))()
assert(SMODS.load_file("./src/content/jokers_characters.lua"))()
assert(SMODS.load_file("./src/content/jokers_objects.lua"))()
assert(SMODS.load_file("./src/content/blinds.lua"))()

assert(SMODS.load_file("./src/misc/startup.lua"))()

assert(SMODS.load_file("./compat/Cryptid.lua"))()