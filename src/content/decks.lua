-- Cherry Deck
SMODS.Back {
    key = "cherry",
    atlas = "atlas_decks",
    pos = { x = 0, y = 0 },
    unlocked = true,
    config = {  },
    apply = function(self, back)
        G.GAME.touhou_cherry = 0
        G.GAME.touhou_cherry_multiplier = 1
        G.GAME.starting_params.touhou_deck_cherry = true
    end,
    calculate = function(self, back, context)
        if context.final_scoring_step then
            return {
                xmult = 1 + TOUHOU.log(math.max(G.GAME.touhou_cherry, 1))/4
            }
        end
    end
}

-- Mystic Deck
SMODS.Back {
    key = "mystic",
    atlas = "atlas_decks",
    pos = { x = 1, y = 0 },
    unlocked = true,
    config = {  },
    apply = function(self, back)
        G.GAME.touhou_mystic = 0
        G.GAME.touhou_mystic_max = TOUHOU.mystic_max
        G.GAME.touhou_mystic_youkai = TOUHOU.mystic_youkai
        G.GAME.touhou_mystic_neutral = TOUHOU.mystic_neutral
        G.GAME.touhou_mystic_human = TOUHOU.mystic_human
        G.GAME.touhou_mystic_min = TOUHOU.mystic_min
        G.GAME.starting_params.touhou_deck_mystic = true
    end,
    calculate = function(self, back, context)
        if context.final_scoring_step then
            if G.GAME.touhou_mystic > G.GAME.touhou_mystic_youkai then
                return {
                    xmult = 1 + 2 * (G.GAME.touhou_mystic - G.GAME.touhou_mystic_youkai)/(G.GAME.touhou_mystic_max - G.GAME.touhou_mystic_youkai),
                    chips = -240 * (G.GAME.touhou_mystic - G.GAME.touhou_mystic_youkai)/(G.GAME.touhou_mystic_max - G.GAME.touhou_mystic_youkai)
                }
            elseif G.GAME.touhou_mystic < G.GAME.touhou_mystic_human then
                return {
                    chips = 120 * (G.GAME.touhou_mystic_human - G.GAME.touhou_mystic)/(G.GAME.touhou_mystic_youkai - G.GAME.touhou_mystic_min),
                    mult = 1/(1 + 1 * (G.GAME.touhou_mystic_human - G.GAME.touhou_mystic)/(G.GAME.touhou_mystic_youkai - G.GAME.touhou_mystic_min))
                }
            end
        end
    end
}

if CardSleeves then
    -- Cherry Sleeve
    CardSleeves.Sleeve {
        key = "cherry",
        name = "Cherry Sleeve",
        atlas = "atlas_sleeves",
        pos = { x = 0, y = 0 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_touhou_cherry" then
                key = self.key .. "_alt"
                self.config = { match = true }
                vars = {  }
            else
                key = self.key
                self.config = {  }
                vars = {  }
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            CardSleeves.Sleeve.apply(sleeve)
            if sleeve.config.match then
                G.GAME.touhou_cherry_multiplier = G.GAME.touhou_cherry_multiplier * 1.5
            else
                G.GAME.touhou_cherry = 0
                G.GAME.starting_params.touhou_deck_cherry = true
            end
        end,
        calculate = function(self, sleeve, context)
            if not sleeve.config.match then
                if context.final_scoring_step then
                    return {
                        xmult = 1 + TOUHOU.log(math.max(G.GAME.touhou_cherry, 1))/4
                    }
                end
            end
        end
    }
    
    -- Mystic Sleeve
    CardSleeves.Sleeve {
        key = "mystic",
        name = "Mystic Sleeve",
        atlas = "atlas_sleeves",
        pos = { x = 1, y = 0 },
        loc_vars = function(self)
            local key, vars
            if self.get_current_deck_key() == "b_touhou_mystic" then
                key = self.key .. "_alt"
                self.config = { match = true }
                vars = {  }
            else
                key = self.key
                self.config = {  }
                vars = {  }
            end
            return { key = key, vars = vars }
        end,
        apply = function(self, sleeve)
            CardSleeves.Sleeve.apply(sleeve)
            if sleeve.config.match then
                G.GAME.touhou_mystic_max = TOUHOU.mystic_max_reduced
                G.GAME.touhou_mystic_youkai = TOUHOU.mystic_youkai_reduced
                G.GAME.touhou_mystic_neutral = TOUHOU.mystic_neutral_reduced
                G.GAME.touhou_mystic_human = TOUHOU.mystic_human_reduced
                G.GAME.touhou_mystic_min = TOUHOU.mystic_min_reduced
            else
                G.GAME.touhou_mystic = 0
                G.GAME.touhou_mystic_max = TOUHOU.mystic_max
                G.GAME.touhou_mystic_youkai = TOUHOU.mystic_youkai
                G.GAME.touhou_mystic_neutral = TOUHOU.mystic_neutral
                G.GAME.touhou_mystic_human = TOUHOU.mystic_human
                G.GAME.touhou_mystic_min = TOUHOU.mystic_min
                G.GAME.starting_params.touhou_deck_mystic = true
            end
        end,
        calculate = function(self, sleeve, context)
            if not sleeve.config.match then
                if context.final_scoring_step then
                    if G.GAME.touhou_mystic > G.GAME.touhou_mystic_youkai then
                        return {
                            xmult = 1 + 2 * (G.GAME.touhou_mystic - G.GAME.touhou_mystic_youkai)/(G.GAME.touhou_mystic_max - G.GAME.touhou_mystic_youkai),
                            chips = -240 * (G.GAME.touhou_mystic - G.GAME.touhou_mystic_youkai)/(G.GAME.touhou_mystic_max - G.GAME.touhou_mystic_youkai)
                        }
                    elseif G.GAME.touhou_mystic < G.GAME.touhou_mystic_human then
                        return {
                            chips = 120 * (G.GAME.touhou_mystic_human - G.GAME.touhou_mystic)/(G.GAME.touhou_mystic_youkai - G.GAME.touhou_mystic_min),
                            mult = 1/(1 + 1 * (G.GAME.touhou_mystic_human - G.GAME.touhou_mystic)/(G.GAME.touhou_mystic_youkai - G.GAME.touhou_mystic_min))
                        }
                    end
                end
            end
        end
    }
end