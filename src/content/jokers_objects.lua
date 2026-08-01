-- Yin-Yang Orb
SMODS.Joker {
    key = "yin_yang_orb",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 0 },
    config = { extra = { immutable = { amount = 1 } } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            for _ = 1, card.ability.extra.immutable.amount do
                if #G.jokers.cards < G.jokers.config.card_limit then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = "Joker",
                                area = G.jokers,
                                key_append = "touhou_yin_yang_orb",
                            }
                            return true
                        end
                    }))
                    return {
                        message = localize("k_plus_joker"),
                        colour = G.C.BLUE,
                    }
                end
            end
        end
    end,
}

-- Extermination Needles
SMODS.Joker {
    key = "extermination_needles",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 0 },
    config = { extra = { xmult = 1, gain = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.touhou_card_remove_from_deck then
            if context.card.ability.set == "Joker" then
                if TOUHOU.check_type(context.card, "youkai") then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
                    return {
                        message = localize("k_touhou_exterminate"),
                        colour =  G.C.RED
                    }
                end
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

-- Donation Box
SMODS.Joker {
    key = "donation_box",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 0 },
    config = { extra = { limit = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.limit } }
    end,
    calc_dollar_bonus = function(self, card)
        if to_big(G.GAME.dollars + (G.GAME.dollar_buffer or 0)) > to_big(G.GAME.interest_cap) + 1 then
            return math.floor(math.min(10, math.max(0, (G.GAME.dollars + (G.GAME.dollar_buffer or 0)) - G.GAME.interest_cap)/5))
        end
    end,
}

-- Mini Hakkero
SMODS.Joker {
    key = "mini_hakkero",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 3, y = 0 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        info_queue[#info_queue + 1] = G.P_CENTERS.m_touhou_hihiirokane
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for k, v in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(v, "m_gold") or SMODS.has_enhancement(v, "m_steel") then
                    v:set_ability(G.P_CENTERS["m_touhou_hihiirokane"])
                end
            end
        end
    end,
    in_pool = function(self)
        for k, v in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(v, "m_gold") or SMODS.has_enhancement(v, "m_steel") then
                return true
            end
        end
        return false
    end,
}

-- Magician Broom
SMODS.Joker {
    key = "magician_broom",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 4, y = 0 },
    config = { extra = { amount = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount } }
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.amount * G.GAME.current_round.hands_left
    end,
}

-- Sphere of Darkness
SMODS.Joker {
    key = "sphere_of_darkness",
    blueprint_compat = false,
    eternal_compat = true,
    rarity = 1,
    cost = 7,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 1 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
}

-- Frozen Frog
SMODS.Joker {
    key = "frozen_frog",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 1 },
    config = { extra = { mult = 2, chips = 9 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if next(SMODS.get_enhancements(context.other_card)) then
                return
            end
            if context.other_card.edition then
                return
            end
            if context.other_card.seal then
                return
            end
            for k, v in pairs(SMODS.Stickers) do
                if context.other_card.ability[k] then
                    return
                end
            end
            return {
                mult = card.ability.extra.mult,
                chips = card.ability.extra.chips
            }
        end
    end,
}

-- Philosopher's Stone
SMODS.Joker {
    key = "philosophers_stone",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 1 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.edition then
                context.other_card:set_edition(poll_edition("touhou_philosophers_stone", nil, true, true))
            end
        end
    end,
}

-- Silver Knives
SMODS.Joker {
    key = "silver_knives",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 3, y = 1 },
    config = { extra = { xmult = 1.25 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_steel") then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Pocket Watch
SMODS.Joker {
    key = "pocket_watch",
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 3,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 4, y = 1 },
    config = { extra = { amount = 1, uses = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, card.ability.extra.uses } }
    end,
    calculate = function(self, card, context)
        if context.after then
            if to_big(card.ability.extra.uses) > to_big(0) then
                if to_big(hand_chips * mult + G.GAME.chips) <= to_big(G.GAME.blind.chips) and to_big(G.GAME.current_round.hands_left) <= to_big(0) then
                    ease_hands_played(card.ability.extra.amount)
                    card.ability.extra.uses = card.ability.extra.uses - 1
                    if to_big(card.ability.extra.uses) <= to_big(0) then
                        G.GAME.pool_flags.touhou_pocket_watch_used = true
                        card:start_dissolve()
                    end
                end
            end
        end
    end,
    in_pool = function(self)
        return not G.GAME.pool_flags.touhou_pocket_watch_used
    end,
}

-- Gungnir
SMODS.Joker {
    key = "gungnir",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 5, y = 1 },
    config = { extra = { xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_glass") then
                return {
                    xmult = card.ability.extra.xmult,
                    message_card = context.other_card
                }
            end
        end
        if context.destroying_card and context.cardarea == G.play then
            if SMODS.has_enhancement(context.destroying_card, "m_glass") then
                context.destroying_card.glass_trigger = true
                return {
                    remove = true
                }
            end
        end
    end,
}

-- Laevateinn
SMODS.Joker {
    key = "laevateinn",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 6, y = 1 },
    config = { extra = { amount = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and not context.blueprint then
            pseudorandom_element(G.hand.cards, pseudoseed("touhou_laevateinn")):sell_card()
        end
    end,
}

-- Mountain Cat
SMODS.Joker {
    key = "mountain_cat",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 4,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 2 },
    config = { extra = { min_chips = 0, max_chips = 150, current_chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.current_chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.current_chips
            }
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.current_chips = pseudorandom("touhou_mountain_cat", card.ability.extra.min_chips, card.ability.extra.max_chips)
        end
    end,
}

-- Grilled Lamprey
SMODS.Joker {
    key = "grilled_lamprey",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 2 },
    config = { extra = { dollars = 6, loss = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.loss } }
    end,
    calculate = function(self, card, context)
        if context.touhou_cash_out then
            if to_big(card.ability.extra.dollars) <= to_big(0) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize("k_eaten_ex"),
                    colour = G.C.MONEY
                }
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        local amount = card.ability.extra.dollars
        card.ability.extra.dollars = card.ability.extra.dollars - card.ability.extra.loss
        return amount
    end,
}

-- Straw Effigy
SMODS.Joker {
    key = "straw_effigy",
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 2,
    cost = 4,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 2 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.before then
            local unique_cards = {}
            for _, hand_card in ipairs(context.scoring_hand) do
                local add = true
                for k, v in ipairs(unique_cards) do
                    if TOUHOU.share_suit(hand_card, v) and TOUHOU.share_id(hand_card, v) then
                        hand_card.ability.touhou_effigy_destroy = true
                        add = false
                    end
                end
                if add then
                    table.insert(unique_cards, hand_card)
                end
            end
        end
        if context.destroying_card then
            if context.destroying_card.ability.touhou_effigy_destroy then
                return {
                    remove = true
                }
            end
        end
    end,
}

-- Shanghai Doll
SMODS.Joker {
    key = "shanghai_doll",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 3, y = 2 },
    config = { extra = { chips = 80 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if TOUHOU.has_low_hand(context.scoring_hand, context.poker_hands) then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,
}

-- Hourai Doll
SMODS.Joker {
    key = "hourai_doll",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 4, y = 2 },
    config = { extra = { mult = 15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if TOUHOU.has_high_hand(context.scoring_hand, context.poker_hands) then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end,
}

-- Netherworld Phantom
SMODS.Joker {
    key = "netherworld_phantom",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 5, y = 2 },
    config = { extra = { chips = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0) } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Spectral" then
            return {
                message = localize({ type = "variable", key = "a_chips", vars = { tostring(card.ability.extra.chips * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)).." Chips" } })
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)
            }
        end
    end,
}

-- Roukanken
SMODS.Joker {
    key = "roukanken",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 6, y = 2 },
    config = { extra = { amount = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop and G.consumeables.cards[1] then
            local editionless_consumables = SMODS.Edition:get_edition_cards(G.consumeables, true)
            local chosen_consumable = pseudorandom_element(editionless_consumables, "touhou_roukanken")
            chosen_consumable:set_edition({ negative = true })
            return {
                message = localize("k_touhou_roukanken_ex")
            }
        end
    end,
}

-- Hakurouken
SMODS.Joker {
    key = "hakurouken",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 7, y = 2 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local next_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    next_joker = G.jokers.cards[i + 1]
                end
            end
            if next_joker then
                next_joker:set_debuff(false)
            end
        end
    end,
}

-- Hyperbolic Tangent
SMODS.Joker {
    key = "hyperbolic_tangent",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 9,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 3 },
    config = { extra = { ratio = 100, limit = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ratio, 1 + (G.GAME.dollars or 0)/card.ability.extra.ratio, card.ability.extra.ratio, colours = { G.C.TOUHOU_BLIND_MANIPULATE } } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            local div = 1 + (G.GAME.dollars or 0)/card.ability.extra.ratio
            if to_big(div) > to_big(card.ability.extra.ratio) then
                div = card.ability.extra.ratio + TOUHOU.log(1 + div - card.ability.extra.ratio)
            end
            local active = (to_big(div) > to_big(0))
            if active then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = G.GAME.blind.chips * 1/div
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                        return true
                    end
                }))
                return {
                    message = "/"..div.." "..localize("k_touhou_blind_divide"),
                    colour = G.C.TOUHOU_BLIND_MANIPULATE,
                }
            end
        end
    end,
}

-- Miniature Gap
SMODS.Joker {
    key = "miniature_gap",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 3 },
    config = { extra = { slots = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.slots } }
    end,
    calculate = function(self, card, context)
        -- 
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self, card, from_debuff)
		G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.slots
	end,
}

-- Portable Barrier
SMODS.Joker {
    key = "portable_barrier",
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 3,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 3 },
    config = { extra = { amount = 2, uses = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount, card.ability.extra.uses } }
    end,
    calculate = function(self, card, context)
        if context.touhou_after_discard then
            if to_big(card.ability.extra.uses) > to_big(0) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        if to_big(G.GAME.current_round.discards_left) <= to_big(0) then
                            ease_discard(card.ability.extra.amount)
                            card.ability.extra.uses = card.ability.extra.uses - 1
                            if to_big(card.ability.extra.uses) <= to_big(0) then
                                -- G.GAME.pool_flags.touhou_portable_barrier_used = true
                                card:start_dissolve()
                            end
                        end
                        return true
                    end
                }))
            end
        end
    end,
    -- in_pool = function(self)
    --     return not G.GAME.pool_flags.touhou_portable_barrier_used
    -- end
}

-- Ghostly Fan
SMODS.Joker {
    key = "ghostly_fan",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 3, y = 3 },
    config = { extra = { chips = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint then
            for k, v in ipairs(context.removed) do
                if v.ability.set == "Enhanced" or v.ability.set == "Base" or v.ability.set == "Default" then
                    card.ability.extra.chips = card.ability.extra.chips + v:get_chip_bonus()
                end
            end
            return {
                message = localize({ type = "variable", key = "a_chips", vars = { card.ability.extra.chips } })
            }
        end
    end
}

-- Cherry Blossom
SMODS.Joker {
    key = "cherry_blossom",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 7,
    atlas = "atlas_jokers_objects",
    pos = { x = 4, y = 3 },
    config = { extra = { proportion = 0.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.proportion } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            return {
                mult = context.other_card:get_chip_bonus() * card.ability.extra.proportion
            }
        end
    end,
}

-- Saigyou Ayakashi
SMODS.Joker {
    key = "saigyou_ayakashi",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 7,
    atlas = "atlas_jokers_objects",
    pos = { x = 5, y = 3 },
    config = { extra = { xmult = 1, gain = 0.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        if context.before then
            local triggered = false
            for k, v in ipairs(G.jokers.cards) do
                if v:get_edition() then
                    v:set_edition()
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
                    triggered = true
                end
            end
            if triggered then
                return {
                    message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } })
                }
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}

-- Ibuki Gourd
SMODS.Joker {
    key = "ibuki_gourd",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 4 },
    config = { extra = { chips = 100, loss = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.loss } }
    end,
    calculate = function(self, card, context)
        if context.before then
            local minus = 0
            if to_big(#context.full_hand) <= to_big(G.GAME.starting_params.play_limit) then
                minus = card.ability.extra.loss * (G.GAME.starting_params.play_limit - #context.full_hand)
                card.ability.extra.chips = card.ability.extra.chips - minus
            end
            if to_big(card.ability.extra.chips) <= to_big(0) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize("k_touhou_drunk_ex")
                }
            end
            if to_big(#context.full_hand) <= to_big(G.GAME.starting_params.play_limit) then
                return {
                    message = localize({ type = "variable", key = "a_chips_minus", vars = { minus } }),
                    colour = G.C.CHIPS
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}

-- Lucky Carrot
SMODS.Joker {
    key = "lucky_carrot",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 3,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 5 },
    config = { extra = { percent = 50 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.percent } }
    end,
    calculate = function(self, card, context)
        -- 
    end,
    add_to_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v * (1 + card.ability.extra.percent / 100)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
		for k, v in pairs(G.GAME.probabilities) do 
            G.GAME.probabilities[k] = v * (1 - card.ability.extra.percent / 100)
        end
	end
}

-- Butterfly Dream Pill
SMODS.Joker {
    key = "butterfly_dream_pill",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 5 },
    config = { extra = { number = 2, rounds = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.number, card.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check then
            if context.other_card ~= card then
                local limit = math.min(card.ability.extra.number, #G.jokers.cards)
                for i = 1, limit do
                    if context.other_card == G.jokers.cards[i] then
                        return {
                            repetitions = 1,
                            card = context.other_card
                        }
                    end
                end
            end
		end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if to_big(card.ability.extra.rounds) <= to_big(0) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize("k_touhou_consumed_ex")
                }
            else
                return {
                    message = localize({ type = "variable", key = "a_remaining", vars = { card.ability.extra.rounds } }),
                    colour = G.C.TOUHOU_CHERRY
                }
            end
        end
    end,
}

-- Butterfly Dream Pill (Nightmare Type)
SMODS.Joker {
    key = "butterfly_dream_pill_nightmare_type",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 5 },
    config = { extra = { number = 2, rounds = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.number, card.ability.extra.rounds } }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check then
            if context.other_card ~= card then
                local limit = math.min(card.ability.extra.number, #G.jokers.cards)
                for i = 1, limit do
                    if context.other_card == G.jokers.cards[#G.jokers.cards - i + 1] then
                        return {
                            repetitions = 1,
                            card = context.other_card
                        }
                    end
                end
            end
		end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if to_big(card.ability.extra.rounds) <= to_big(0) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize("k_touhou_consumed_ex")
                }
            else
                return {
                    message = localize({ type = "variable", key = "a_remaining", vars = { card.ability.extra.rounds } }),
                    colour = G.C.BLACK
                }
            end
        end
    end,
}

-- Earth Rabbit Mochi
SMODS.Joker {
    key = "earth_rabbit_mochi",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 3, y = 5 },
    config = { extra = { mult = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.before then
            card.ability.extra.mult = card.ability.extra.mult + 1
		end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult - G.GAME.round_resets.hands
            if to_big(card.ability.extra.mult) <= to_big(0) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = localize("k_touhou_consumed_ex")
                }
            end
        end
    end,
}

-- Tengu Camera
SMODS.Joker {
    key = "tengu_camera",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 6 },
    config = { extra = { chips = 0, chips_per = 10, immutable = { seen = {} } } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_per, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.touhou_card_add_to_deck then
            if context.card.ability.set == "Joker" then
                if not card.ability.extra.immutable.seen[TOUHOU.get_key(context.card)] then
                    card.ability.extra.immutable.seen[TOUHOU.get_key(context.card)] = true
                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_per
                    return {
                        message = localize("k_upgrade_ex"),
                        colour = G.C.CHIPS
                    }
                end
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.immutable.seen[TOUHOU.get_key(card)] = true
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_per
    end,
}

-- Reaper's Scythe
SMODS.Joker {
    key = "reapers_scythe",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 6 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.touhou_sell_card then
            if context.card and context.card.debuff then
                return {
                    dollars = context.card.cost
                }
            end
        end
    end,
}

-- Rokumon
SMODS.Joker {
    key = "rokumon",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 6 },
    config = { extra = { div = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.div, colours = { G.C.TOUHOU_BLIND_MANIPULATE } } }
    end,
    calculate = function(self, card, context)
        if context.selling_self and G.GAME.blind.in_blind then
            return {
                touhou_blind_div = card.ability.extra.div
            }
        end
    end,
}

-- Rod of Remorse
SMODS.Joker {
    key = "rod_of_remorse",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 5,
    atlas = "atlas_jokers_objects",
    pos = { x = 3, y = 6 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = { ((G.GAME.blind and G.GAME.blind.mult) or 1) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = ((G.GAME.blind and G.GAME.blind.mult) or 1)
            }
        end
    end,
}

-- Cleansed Crystal Mirror
SMODS.Joker {
    key = "cleansed_crystal_mirror",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 4, y = 6 },
    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            for i = 1, #G.play.cards do
                if context.other_card == G.play.cards[i] and G.play.cards[i + 1] then
                    if to_big(context.other_card.base.nominal) >= to_big(G.play.cards[i + 1].base.nominal) then
                        return {
                            repetitions = card.ability.extra.repetitions
                        }
                    end
                end
            end
        end
    end,
}

-- Ordinary Grimoire
SMODS.Joker {
    key = "ordinary_grimoire",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 10,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 7 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if not context.touhou_recursion then
            local area = card.area
            local card_list = {}
            for i = 1, #area.cards do
                if area.cards[i] ~= card and area.cards[i].config.center ~= card.config.center then
                    table.insert(card_list, area.cards[i])
                end
            end
            local random_card = pseudorandom_element(card_list, pseudoseed("touhou_ordinary_grimoire"))
            local new_context = {}
            for k, v in pairs(context) do
                new_context[k] = v
            end
            new_context.touhou_recursion = true
            return random_card:calculate_joker(new_context)
        end
    end,
}

-- Hexagrammic Grimoire
SMODS.Joker {
    key = "hexagrammic_grimoire",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 7 },
    config = { extra = { xmult = 2, number = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.number } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local count = 0
            for k, v in pairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(v)) then
                    count = count + 1
                end
            end
            if to_big(card.ability.extra.number) >= to_big(2) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Grimoire of Seven Colors
SMODS.Joker {
    key = "grimoire_of_seven_colors",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 7 },
    config = { extra = { numerator = 1, denominator = 4, immutable = { card_types = { Hearts = "Tarot", Spades = "Spectral", Diamonds = "Planet", Clubs = "Enhanced" } } } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and context.main_eval then
            local created = {}
            for i = 1, #G.hand.cards do
                if not G.hand.cards[i].debuff then
                    if SMODS.pseudorandom_probability(self, "touhou_grimoire_of_seven_colors", card.ability.extra.numerator, card.ability.extra.denominator) then
                        for suit_key, suits in pairs(SMODS.Suits) do
                            local card_type = card.ability.extra.immutable.card_types[suit_key]
                            local location = G.consumeables
                            if card_type == "Joker" then
                                location = G.jokers
                            elseif card_type == "Enhanced" or card_type == "Base" or card_type == "Default" then
                                location = G.hand
                            end
                            created[location] = created[location] or 0
                            if card_type and G.hand.cards[i]:is_suit(suit_key) then
                                if location == G.hand or #location.cards + created[location] < G.consumeables.config.card_limit then
                                    created[location] = created[location] + 1
                                    card_eval_status_text(G.hand.cards[i], "jokers", nil, percent, nil, { message = "Create!", colour = G.C.SET[card_type] })
                                    G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local card = SMODS.add_card {
                                            set = card_type,
                                            area = location,
                                            key_append = "touhou_grimoire_of_seven_colors",
                                        }
                                        if location == G.hand then
                                            draw_card(G.hand, G.deck, 0, "down", false, card, nil, true)
                                        end
                                        return true
                                    end
                                    }))
                                end
                            end
                        end
                    end
                end
            end
        end
    end,
}

-- Dragon's Jewel
SMODS.Joker {
    key = "dragons_jewel",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 0, y = 8 },
    config = { extra = { rounds = 5, amount = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { math.max(card.ability.extra.rounds, 0), card.ability.extra.amount } }
    end,
    calculate = function(self, card, context)
        if to_big(card.ability.extra.amount) >= to_big(100) then
            card.ability.extra.amount = 100
        end
        if type(card.ability.extra.amount) == "table" then
            card.ability.extra.amount = card.ability.extra.amount:to_number()
        end
        if context.end_of_round and not context.game_over and context.main_eval then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
        end
        if context.selling_self then
            if to_big(card.ability.extra.rounds) <= to_big(0) then
                for i = 1, card.ability.extra.amount do
                    local common_key = "Common"
                    local rarity = common_key
                    local attempts = 0
                    while rarity == common_key do
                        if attempts < 5 then
                            rarity = SMODS.poll_rarity("Joker", "touhou_dragons_jewel")
                            rarity = TOUHOU.vanilla_rarities[rarity] or rarity
                            attempts = attempts + 1
                        else
                            local rarities = {}
                            for k, v in pairs(SMODS.Rarities) do
                                if k ~= common_key then
                                    table.insert(rarities, k)
                                end
                            end
                            rarity = pseudorandom_element(rarities, pseudoseed("touhou_dragons_jewel"))
                            rarity = TOUHOU.vanilla_rarities[rarity] or rarity
                            break
                        end
                    end
                    get_current_pool("Joker", rarity, nil, "touhou_dragons_jewel")
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = "Joker",
                                rarity = rarity,
                                area = G.jokers,
                                key_append = "touhou_dragons_jewel",
                            }
                            return true
                        end
                    }))
                end
            end
        end
    end,
}

-- Buddha's Begging Bowl
SMODS.Joker {
    key = "buddhas_begging_bowl",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 1, y = 8 },
    config = { extra = { dollars = 15, limit = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.limit } }
    end,
    calculate = function(self, card, context)
        if context.starting_shop then
            if to_big(G.GAME.dollars) <= to_big(card.ability.extra.limit) then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end,
}


-- Fire Rat's Robe
SMODS.Joker {
    key = "fire_rats_robe",
    blueprint_compat = false,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 2, y = 8 },
    config = { extra = { immutable = { used = false, cards = {} } } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.pre_discard then
            if not card.ability.extra.immutable.used then
                card.ability.extra.immutable.used = true
                for k, v in ipairs(G.hand.highlighted) do
                    table.insert(card.ability.extra.immutable.cards, v)
                end
                card.ability.extra.immutable.cards = TOUHOU.deduplicate(card.ability.extra.immutable.cards)
            end
        end
        if context.drawing_cards then
            for k, v in ipairs(card.ability.extra.immutable.cards) do
                draw_card(G.discard, G.hand, 0, nil, true, v)
            end
            card.ability.extra.immutable.cards = {}
        end
        if context.end_of_round and context.main_eval and not context.blueprint then
            card.ability.extra.immutable.used = false
        end
    end,
}

-- Swallow's Cowrie Shell
SMODS.Joker {
    key = "swallows_cowrie_shell",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 3, y = 8 },
    config = { extra = { amount = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.amount } }
    end,
    calculate = function(self, card, context)
        if context.touhou_cash_out and not G.GAME.modifiers.no_interest then
            card.ability.extra.amount = card.ability.extra.amount + G.GAME.current_round.dollars * 0.5
        end
        if context.selling_self then
            ease_dollars(card.ability.extra.amount)
        end
    end,
    in_pool = function(self)
		return not G.GAME.modifiers.no_interest
	end,
}

-- Jeweled Branch of Hourai
SMODS.Joker {
    key = "jeweled_branch_of_hourai",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_objects",
    pos = { x = 4, y = 8 },
    config = { extra = { chips_gain = 5, mult_gain = 1, xmult_gain = 0.05, chips = 0, mult = 0, xmult = 1, remaining = 40 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_gain, card.ability.extra.mult_gain, card.ability.extra.xmult_gain, card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.remaining } }
    end,
    calculate = function(self, card, context)
        if context.other_joker or context.individual then
            local other_card = context.other_joker or context.other_card
            if next(SMODS.get_enhancements(other_card)) then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                card.ability.extra.remaining = card.ability.extra.remaining - 1
            end
            if other_card.edition then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                card.ability.extra.remaining = card.ability.extra.remaining - 1
            end
            if other_card.seal then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
                card.ability.extra.remaining = card.ability.extra.remaining - 1
            end
            for k, v in pairs(SMODS.Stickers) do
                if other_card.ability[k] then
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                    card.ability.extra.remaining = card.ability.extra.remaining - 1
                end
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                xmult = card.ability.extra.xmult
            }
        end
        if to_big(card.ability.extra.remaining) <= to_big(0) then
            card:start_dissolve()
        end
    end,
}