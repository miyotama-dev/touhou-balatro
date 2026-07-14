-- The Mansion
SMODS.Blind {
    key = "mansion",
    dollars = 5,
    mult = 2,
    atlas = "atlas_blinds",
    pos = { x = 0, y = 0 },
    boss = { min = 2 },
    boss_colour = HEX("b80000"),
    config = { extra = { hands = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.hands } }
    end,
    drawn_to_hand = function(self)
        if not G.GAME.blind.disabled then
            if to_big(G.GAME.current_round.hands_left) > to_big(self.config.extra.hands) then
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i]:set_debuff(true)
                end
            else
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i]:set_debuff(false)
                end
            end
        end
    end,
    disable = function(self)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
        end 
    end,
    defeat = function(self)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
        end
    end
}

-- The Bloom -- fix later
SMODS.Blind {
    key = "bloom",
    dollars = 5,
    mult = 2,
    atlas = "atlas_blinds",
    pos = { x = 0, y = 1 },
    boss = { min = 4 },
    boss_colour = HEX("b9119b"),
    config = { extra = { multiplier = 1.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.multiplier } }
    end,
    calculate = function(self, blind, context)
        if not G.GAME.blind.disabled then
            if context.final_scoring_step then
                G.GAME.blind.chips = G.GAME.blind.chips * self.config.extra.multiplier
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            end
        end
    end
}

-- The Mist
SMODS.Blind {
    key = "mist",
    dollars = 5,
    mult = 2,
    atlas = "atlas_blinds",
    pos = { x = 0, y = 2 },
    boss = { min = 2 },
    boss_colour = HEX("c83f31"),
    config = { extra = { xmult = 0.9 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.xmult } }
    end,
    calculate = function(self, blind, context)
        if not G.GAME.blind.disabled then
            if context.individual and context.cardarea == G.play then
                return {
                    xmult = self.config.extra.xmult
                }
            end
        end
    end
}

-- The Fake
SMODS.Blind {
    key = "fake",
    dollars = 5,
    mult = 2,
    atlas = "atlas_blinds",
    pos = { x = 0, y = 3 },
    boss = { min = 6 },
    boss_colour = HEX("291e92"),
    config = { extra = { numerator = 1, denominator = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { SMODS.get_probability_vars(self, self.config.extra.numerator, self.config.extra.denominator) } }
    end,
    set_blind = function(self)
        G.GAME.touhou_illusion_draw = true
        G.GAME.touhou_illusion_draw_numerator = self.config.extra.numerator
        G.GAME.touhou_illusion_draw_demoninator = self.config.extra.denominator
		G.GAME.touhou_illusion_draw_probability = G.GAME.touhou_illusion_draw_numerator / G.GAME.touhou_illusion_draw_demoninator
    end,
    disable = function(self)
        G.GAME.touhou_illusion_draw = nil
        G.GAME.touhou_illusion_draw_numerator = nil
        G.GAME.touhou_illusion_draw_demoninator = nil
        G.GAME.touhou_illusion_draw_probability = nil
    end,
    defeat = function(self)
        G.GAME.touhou_illusion_draw = nil
        G.GAME.touhou_illusion_draw_numerator = nil
        G.GAME.touhou_illusion_draw_demoninator = nil
        G.GAME.touhou_illusion_draw_probability = nil
    end
}

-- The Flower
SMODS.Blind {
    key = "flower",
    dollars = 5,
    mult = 2,
    atlas = "atlas_blinds",
    pos = { x = 0, y = 4 },
    boss = { min = 1 },
    boss_colour = HEX("93a3aa"),
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    press_play = function(self)
        if not G.GAME.blind.disabled then
            local debuffed_suits = {}
            for k, v in ipairs(G.hand.highlighted) do
                if not SMODS.has_no_suit(v) and not debuffed_suits[v.base.suit] then
                    debuffed_suits[v.base.suit] = true
                    v:set_debuff(true)
                end
            end
        end
    end
}

-- The Shot
SMODS.Blind {
    key = "shot",
    dollars = 5,
    mult = 2,
    atlas = "atlas_blinds",
    pos = { x = 0, y = 5 },
    boss = { min = 3 },
    boss_colour = HEX("ac080d"),
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    set_blind = function(self)
		G.GAME.touhou_max_played_hand_size = nil
        G.GAME.touhou_override_debuff = nil
    end,
    debuff_hand = function (self, cards, hand, handname, check)
        if not G.GAME.blind.disabled then
            if not G.GAME.touhou_override_debuff and (G.GAME.touhou_max_played_hand_size and #cards <= G.GAME.touhou_max_played_hand_size) then
                return true
            end
        end
        G.GAME.touhou_override_debuff = nil
        return false
    end,
    press_play = function(self)
        if not G.GAME.blind.disabled and not G.GAME.touhou_max_played_hand_size or #G.hand.highlighted > G.GAME.touhou_max_played_hand_size then
            G.GAME.touhou_max_played_hand_size = #G.hand.highlighted
            G.GAME.touhou_override_debuff = true
        else
            G.GAME.touhou_override_debuff = nil
        end
    end,
    disable = function(self)
        G.GAME.touhou_max_played_hand_size = nil
        G.GAME.touhou_override_debuff = nil
    end,
    defeat = function(self)
        G.GAME.touhou_max_played_hand_size = nil
        G.GAME.touhou_override_debuff = nil
    end
}