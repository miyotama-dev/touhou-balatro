SMODS.Enhancement {
    key = 'hihiirokane',
    atlas = "atlas_enhancements",
    pos = { x = 0, y = 0 },
    config = { h_x_mult = 1.25, h_dollars = 1, Xmult = 1.25 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_mult, card.ability.h_dollars } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                dollars = card.ability.h_dollars
            }
        end
    end,
}