-- Reimu Hakurei
SMODS.Joker {
    key = "reimu_hakurei",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_characters",
    pos = { x = 0, y = 0 },
    config = { extra = { xmult = 1, immutable = { fraction = 25 } } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.individual and not context.repetition then
            G.GAME.touhou_stored_interest_amount = (G.GAME.touhou_stored_interest_amount or 0) + G.GAME.interest_amount
            G.GAME.interest_amount = 0
        end
        if context.touhou_cash_out and not G.GAME.modifiers.no_interest then
            card.ability.extra.xmult = card.ability.extra.xmult + ((G.GAME.interest_amount + (G.GAME.touhou_stored_interest_amount or 0)) * math.min(math.floor(G.GAME.dollars/5), G.GAME.interest_cap/5))/card.ability.extra.immutable.fraction
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.touhou_stored_interest_amount = (G.GAME.touhou_stored_interest_amount or 0) + G.GAME.interest_amount
        G.GAME.interest_amount = 0
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not next(SMODS.find_card("j_touhou_reimu_hakurei")) then
            G.GAME.interest_amount = G.GAME.interest_amount + (G.GAME.touhou_stored_interest_amount or 0)
            G.GAME.touhou_stored_interest_amount = 0
        end
    end,
	in_pool = function(self)
		return not G.GAME.modifiers.no_interest
	end,
}

-- Marisa Kirisame
SMODS.Joker {
    key = "marisa_kirisame",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = "atlas_jokers_characters",
    pos = { x = 1, y = 0 },
    config = { extra = { xmult = 1.2, money = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.other_consumeable then -- Check to see whether this is correct or the misspelling is correct
            return {
                xmult = card.ability.extra.xmult,
                message_card = context.other_consumeable
            }
        end
        if context.using_consumeable then
            return {
                dollars = card.ability.extra.money,
                card = card
            }
        end
    end,
}

-- Rumia
SMODS.Joker {
    key = "rumia",
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_characters",
    pos = { x = 0, y = 1 },
    config = { extra = { chips = 15, suits = {"Spades", "Clubs"} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, localize(card.ability.extra.suits[1], "suits_singular"), localize(card.ability.extra.suits[2], "suits_singular") } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local is_suit = false
            for k, v in pairs(card.ability.extra.suits) do
                if context.other_card:is_suit(v) then
                    is_suit = true
                end
            end
            if is_suit then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}

-- Daiyousei
SMODS.Joker {
    key = "daiyousei",
    blueprint_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 1, y = 1 },
    config = { extra = { chips = 30, mult = 4, xchips = 1.2, xmult = 1.2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xchips, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and TOUHOU.check_type(context.other_joker, "fairy") then
            local random = math.floor(pseudorandom("touhou_daiyousei") * 6)
            if random < 2 then
                return {
                    chips = card.ability.extra.chips
                }
            elseif random < 4 then
                return {
                    mult = card.ability.extra.mult
                }
            elseif random < 5 then
                return {
                    xchips = card.ability.extra.xchips
                }
            else
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Cirno
SMODS.Joker {
    key = "cirno",
    blueprint_compat = true,
    rarity = 2,
    cost = 9,
    atlas = "atlas_jokers_characters",
    pos = { x = 2, y = 1 },
    config = { extra = { chips = 9 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local nines = 0
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 9 then
                    nines = nines + 1
                end
            end
            if context.other_card:get_id() == 9 then
                return {
                    chips = card.ability.extra.chips * nines
                }
            end
        end
    end,
}

-- Hong Meiling
SMODS.Joker {
    key = "hong_meiling",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_characters",
    pos = { x = 3, y = 1 },
    config = { extra = { numerator = 1, denominator = 7 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            for k, v in ipairs(context.scoring_hand) do
                if v:get_id() == 7 then
                    if SMODS.pseudorandom_probability(self, "touhou_hong_meiling", card.ability.extra.numerator, card.ability.extra.denominator) then 
                        v:set_edition(poll_edition("touhou_hong_meiling", nil, true, true))
                    end
                    if SMODS.pseudorandom_probability(self, "touhou_hong_meiling", card.ability.extra.numerator, card.ability.extra.denominator) then 
                        v:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = "touhou_hong_meiling" }))
                    end
                    if SMODS.pseudorandom_probability(self, "touhou_hong_meiling", card.ability.extra.numerator, card.ability.extra.denominator) then 
                        v:set_ability(G.P_CENTERS[SMODS.poll_enhancement({ guaranteed = true, type_key = "touhou_hong_meiling" })])
                    end
                end
            end
        end
    end,
}

-- Koakuma
SMODS.Joker {
    key = "koakuma",
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    atlas = "atlas_jokers_characters",
    pos = { x = 4, y = 1 },
    config = { extra = { mult = 5, patchouli_mult = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.patchouli_mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if next(SMODS.get_enhancements(context.other_card)) then
                if next(SMODS.find_card("j_touhou_patchouli_knowledge")) then
                    return {
                        mult = card.ability.extra.patchouli_mult
                    }
                else
                    return {
                        mult = card.ability.extra.mult
                    }
                end
            end
        end
    end,
}

-- Patchouli Knowledge
SMODS.Joker {
    key = "patchouli_knowledge",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 5, y = 1 },
    config = { extra = { sun_xmult = 1.25, moon_mult = 10, water_hand_size = 1, water_hands = 1, water_discards = 1, wood_chips = 30, metal_steel_xmult = 1.5, metal_gold_dollars = 3, earth_hand_type = "Full House", earth_chips = 90, earth_mult = 11, immutable = { phase = 1 } } },
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.immutable.phase == 1 then
            return { key = "j_touhou_patchouli_knowledge_sun", vars = { card.ability.extra.sun_xmult } }
        elseif card.ability.extra.immutable.phase == 2 then
            return { key = "j_touhou_patchouli_knowledge_moon", vars = { card.ability.extra.moon_mult } }
        elseif card.ability.extra.immutable.phase == 3 then
            return { key = "j_touhou_patchouli_knowledge_fire", vars = {  } }
        elseif card.ability.extra.immutable.phase == 4 then
            return { key = "j_touhou_patchouli_knowledge_water", vars = { card.ability.extra.water_hand_size, card.ability.extra.water_hands, card.ability.extra.water_discards } }
        elseif card.ability.extra.immutable.phase == 5 then
            return { key = "j_touhou_patchouli_knowledge_wood", vars = { card.ability.extra.wood_chips } }
        elseif card.ability.extra.immutable.phase == 6 then
            return { key = "j_touhou_patchouli_knowledge_metal", vars = { card.ability.extra.metal_steel_xmult, card.ability.extra.metal_gold_dollars } }
        elseif card.ability.extra.immutable.phase == 7 then
            return { key = "j_touhou_patchouli_knowledge_earth", vars = { card.ability.extra.earth_chips, card.ability.extra.earth_mult, localize(card.ability.extra.earth_hand_type, "poker_hands") } }
        end
        return { key = self.key, vars = {} }
    end,
    calculate = function(self, card, context)
        if card.ability.extra.immutable.phase == 1 then
            if context.individual and context.cardarea == G.play and context.other_card:is_suit("Hearts") then
                return {
                    xmult = card.ability.extra.sun_xmult
                }
            end
        elseif card.ability.extra.immutable.phase == 2 then
            if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
                return {
                    mult = card.ability.extra.moon_mult
                }
            end
        elseif card.ability.extra.immutable.phase == 3 then
            if context.before and G.GAME.current_round.hands_played <= 0 and not context.hook then
                local text, _ = G.FUNCS.get_poker_hand_info(G.play.cards)
                return {
                    level_up = true,
                    level_up_hand = text,
                    message = localize("k_level_up_ex"),
                }
            end
            if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook then
                local text, _ = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                return {
                    level_up = true,
                    level_up_hand = text,
                    message = localize("k_level_up_ex"),
                }
            end
        elseif card.ability.extra.immutable.phase == 4 then
            -- 
        elseif card.ability.extra.immutable.phase == 5 then
            if context.individual and context.cardarea == G.play then
                if not context.other_card:is_face() then
                    return {
                        chips = card.ability.extra.wood_chips
                    }
                end
            end
        elseif card.ability.extra.immutable.phase == 6 then
            if context.individual and context.cardarea == G.hand and not context.end_of_round then
                if not context.other_card.debuff and SMODS.has_enhancement(context.other_card, "m_gold") then
                    return {
                        dollars = card.ability.extra.metal_gold_dollars,
                        card = context.other_card
                    }
                end
                if not context.other_card.debuff and SMODS.has_enhancement(context.other_card, "m_steel") then
                    return {
                        xmult = card.ability.extra.metal_steel_xmult
                    }
                end
            end
        elseif card.ability.extra.immutable.phase == 7 then
            if context.joker_main and next(context.poker_hands[card.ability.extra.earth_hand_type]) then
                return {
                    chips = card.ability.extra.earth_chips,
                    mult = card.ability.extra.earth_mult
                }
            end
        end
        if context.end_of_round and not context.other_card and not context.blueprint and not context.repetition then
            old_phase = card.ability.extra.immutable.phase
            card.ability.extra.immutable.phase = card.ability.extra.immutable.phase + 1
            if card.ability.extra.immutable.phase > 7 or card.ability.extra.immutable.phase < 1 then
                card.ability.extra.immutable.phase = 1
            end
            if old_phase == 4 then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.water_hands
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.water_discards
                G.hand:change_size(-card.ability.extra.water_hand_size)
            end
            if card.ability.extra.immutable.phase == 4 then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.water_hands
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.water_discards
                G.hand:change_size(card.ability.extra.water_hand_size)
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.immutable.phase == 4 then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.water_hands
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.water_discards
            G.hand:change_size(card.ability.extra.water_hand_size)
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.immutable.phase == 4 and not context.blueprint then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.water_hands
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.water_discards
            G.hand:change_size(-card.ability.extra.water_hand_size)
        end
    end,
}

-- Sakuya Izayoi
SMODS.Joker {
    key = "sakuya_izayoi",
    blueprint_compat = false,
    eternal_compat = false,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_characters",
    pos = { x = 6, y = 1 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss then
            G.GAME.TOUHOU_SKIP_SHOP = true
            G.GAME.TOUHOU_BLOCK_ANTE_INCREASE = true
            G.GAME.pool_flags.touhou_sakuya_used = true
            card:start_dissolve()
        end
    end,
    in_pool = function(self)
        return not G.GAME.pool_flags.touhou_sakuya_used
    end,
}

-- Remilia Scarlet
SMODS.Joker {
    key = "remilia_scarlet",
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    atlas = "atlas_jokers_characters",
    pos = { x = 7, y = 1 },
    config = { extra = { numerator = 1, denominator = 4, hand_type = "" } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { numerator, denominator, localize(TOUHOU.get_nth_most_played_hand(2), "poker_hands") } }
    end,
    calculate = function(self, card, context)
        if card.ability.extra.hand_type == "" then
            card.ability.extra.hand_type = TOUHOU.get_nth_most_played_hand(2)
        end
        if context.before and context.main_eval and not context.blueprint then
            if context.scoring_name == card.ability.extra.hand_type then
                if SMODS.pseudorandom_probability(self, "touhou_remilia_scarlet", card.ability.extra.numerator, card.ability.extra.denominator) then
                    G.GAME.round_resets.blind_choices.Boss = get_new_boss()
                    card.ability.extra.hand_type = TOUHOU.get_nth_most_played_hand(2, context.scoring_name)
                    return {
                        message = localize("k_touhou_boss_reroll")
                    }
                end
            end
            card.ability.extra.hand_type = TOUHOU.get_nth_most_played_hand(2, context.scoring_name)
        end
    end,
}

-- Flandre Scarlet
SMODS.Joker {
    key = "flandre_scarlet",
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
    atlas = "atlas_jokers_characters",
    pos = { x = 8, y = 1 },
    config = { extra = { numerator = 1, denominator = 7, xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { numerator, denominator, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.destroy_card then
            if SMODS.pseudorandom_probability(self, "touhou_flandre_scarlet", card.ability.extra.numerator, card.ability.extra.denominator) then
                return {
                    xmult = card.ability.extra.xmult,
                    remove = true
                }
            end
        end
    end,
}

-- Letty Whiterock
SMODS.Joker {
    key = "letty_whiterock",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 0, y = 2 },
    config = { extra = { xmult = 1, gain = 0.1, immutable = {melt = false} } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.after then
            local fire = false
            if to_big(G.GAME.blind.chips) >= to_big(1) then
                if to_big(hand_chips * mult) >= to_big(G.GAME.blind.chips) then
                    fire = true
                end
            end
            if fire then
                card.ability.extra.immutable.melt = true
            end
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and not context.game_over and context.main_eval then
            if card.ability.extra.immutable.melt then
                card:start_dissolve()
            else
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.plus
                return {
                    message = localize { type = "variable", key = "a_xmult", vars = { card.ability.extra.xmult } }
                }
            end
        end
    end,
}

-- Chen
SMODS.Joker {
    key = "chen",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    atlas = "atlas_jokers_characters",
    pos = { x = 1, y = 2 },
    config = { extra = { xmult = 1.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker then
            if TOUHOU.check_type(context.other_joker, "cat") or TOUHOU.get_name(context.other_joker):lower():find("cat") then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Alice Margatroid
SMODS.Joker {
    key = "alice_margatroid",
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    atlas = "atlas_jokers_characters",
    pos = { x = 2, y = 2 },
    config = { extra = { limit = 1.2, active = false } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.limit } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and context.main_eval then
            if to_big(G.GAME.chips) <= to_big(G.GAME.blind.chips * card.ability.extra.limit) then
                card.ability.extra.active = true
                -- local booster_key = get_pack().key
                -- local card = Card(
                --     G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
                --     G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
                --     G.CARD_W*1.27,
                --     G.CARD_H*1.27,
                --     G.P_CARDS.empty,
                --     G.P_CENTERS[booster_key], 
                --     {bypass_discovery_center = true, bypass_discovery_ui = true}
                -- )
                -- card.cost = 0
                -- card.from_tag = true
                -- card:start_materialize()
                -- G.FUNCS.use_card({ config = { ref_table = card } })
            end
        end
        if context.starting_shop and card.ability.extra.active then
            local booster_key = get_pack().key
            local booster = SMODS.add_booster_to_shop(booster_key)
            booster.cost = 0
            card.ability.extra.active = false
        end
    end,
}

-- Lily White
SMODS.Joker {
    key = "lily_white",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_characters",
    pos = { x = 3, y = 2 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = "Consumeables",
                            area = G.consumeables,
                            key_append = "touhou_lily_white",
                        }
                        return true
                    end
                }))
            end
        end
    end,
}

-- Lily Black
SMODS.Joker {
    key = "lily_black",
    blueprint_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_characters",
    pos = { x = 4, y = 2 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            local pool = get_current_pool("Tag")
            local tag = pseudorandom_element(pool, pseudoseed("touhou_lily_black"))
            while tag == "UNAVAILABLE" do
                tag = pseudorandom_element(pool, pseudoseed("touhou_lily_black"))
            end
            add_tag(Tag(tag))
        end
    end,
}

-- Lyrica Prismriver
SMODS.Joker {
    key = "lyrica_prismriver",
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 5, y = 2 },
    config = { extra = { immutable = { limit = 1 } } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local limit = card.ability.extra.immutable.limit
            for k, v in ipairs(G.play.cards) do
                if limit <= 0 then
                    break
                end
                if v.debuff then
                    v:set_debuff(false)
                    limit = limit - 1
                end
            end
        end
    end,
}

-- Lunasa Prismriver
SMODS.Joker {
    key = "lunasa_prismriver",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 6, y = 2 },
    config = { extra = { mix = 0.15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mix * 100 } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if to_big(hand_chips) > to_big(mult) then
                return {
                    mult = hand_chips * card.ability.extra.mix,
                    chips = -hand_chips * card.ability.extra.mix
                }
            elseif mult > hand_chips then
                return {
                    chips = mult * card.ability.extra.mix,
                    mult = -mult * card.ability.extra.mix
                }
            end
        end
    end,
}

-- Merlin Prismriver
SMODS.Joker {
    key = "merlin_prismriver",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 7, y = 2 },
    config = { extra = { xmin = 0.75, xmax = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmin, card.ability.extra.xmax } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xchips = (card.ability.extra.xmax - card.ability.extra.xmin) * pseudorandom("merlin_prismriver") + card.ability.extra.xmin,
                xmult = (card.ability.extra.xmax - card.ability.extra.xmin) * pseudorandom("merlin_prismriver") + card.ability.extra.xmin
            }
        end
    end,
}

-- Youmu Konpaku
SMODS.Joker {
    key = "youmu_konpaku",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_characters",
    pos = { x = 8, y = 2 },
    config = { extra = { log_base = 50 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.log_base, colours = { G.C.TOUHOU_BLIND_MANIPULATE } } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local div = 1
            local active = false
            if to_big(mult) > to_big(card.ability.extra.log_base) then
                div = TOUHOU.log(mult, card.ability.extra.log_base)
                active = true
            end
            if active then
                return {
                    touhou_blind_div = div,
                    -- message = localize({ type = "variable", key = "a_touhou_blind_divide", vars = { div } }), 
                    -- colour = G.C.TOUHOU_BLIND_MANIPULATE
                }
            end
        end
    end,
}

-- Yuyuko Saigyouji
SMODS.Joker {
    key = "yuyuko_saigyouji",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_characters",
    pos = { x = 9, y = 2 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_death
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and context.main_eval then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = "Consumeables",
                            area = G.consumeables,
                            forced_key = "c_death",
                            key_append = "touhou_yuyuko_saigyouji",
                        }
                        return true
                    end
                }))
            end
        end
    end,
}

-- Ran Yakumo
SMODS.Joker {
    key = "ran_yakumo",
    blueprint_compat = true,
    rarity = 3,
    cost = 8,
    atlas = "atlas_jokers_characters",
    pos = { x = 10, y = 2 },
    config = { extra = { extra_choices = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.extra_choices } }
    end,
    calculate = function(self, card, context)
        if context.touhou_booster then
            if G.GAME.touhou_pack_name:find("Arcana") or G.GAME.touhou_pack_name:find("Spectral") then
                G.GAME.touhou_pack_size = (G.GAME.touhou_pack_size or 0) + card.ability.extra.extra_choices
            end
        end
    end,
}

-- Yukari Yakumo
SMODS.Joker {
    key = "yukari_yakumo",
    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    atlas = "atlas_jokers_characters",
    pos = { x = 11, y = 2 },
    soul_pos = { x = 12, y = 2 },
    config = { extra = { skip_limit = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.skip_limit } }
    end,
    calculate = function(self, card, context)
        -- 
    end,
}

-- Suika Ibuki
SMODS.Joker {
    key = "suika_ibuki",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 0, y = 3 },
    config = { extra = { numerator = 1, denominator = 2, repetitions = 1, loss = 2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { numerator, denominator, card.ability.extra.repetitions, card.ability.extra.loss } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(self, "touhou_suika_ibuki", card.ability.extra.numerator, card.ability.extra.denominator) then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        return -card.ability.extra.loss
    end,
}

-- Wriggle Nightbug
SMODS.Joker {
    key = "wriggle_nightbug",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 0, y = 4 },
    config = { extra = { chips = 15 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips * #G.hand.cards
            }
        end
    end,
}

-- Mystia Lorelei
SMODS.Joker {
    key = "mystia_lorelei",
    blueprint_compat = true,
    rarity = 1,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 1, y = 4 },
    -- config = { extra = { mult = 12, flipped = 1, hand_flipped = 0 } },
    config = { extra = { mult = 12, hand_flipped = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.flipped } }
    end,
    calculate = function(self, card, context)
        -- if context.stay_flipped and context.to_area == G.hand and to_big(card.ability.extra.hand_flipped) < to_big(card.ability.extra.flipped) then
        if context.stay_flipped and context.to_area == G.hand and to_big(card.ability.extra.hand_flipped) < to_big(1) then
            card.ability.extra.hand_flipped = card.ability.extra.hand_flipped + 1
            return {
                stay_flipped = true
            }
        end
        if context.setting_blind or context.before or context.pre_discard or context.open_booster then
            card.ability.extra.hand_flipped = 0
        end
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.touhou_flipped then
                context.other_card.ability.touhou_flipped = nil
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end,
}

-- Keine Kamishirasawa
SMODS.Joker {
    key = "keine_kamishirawara",
    blueprint_compat = true,
    rarity = 2,
    cost = 8,
    atlas = "atlas_jokers_characters",
    pos = { x = 2, y = 4 },
    config = { extra = { xmult = 3, extra_xmult = 1, immutable = { were = false, 
        date_list = {711, 585, 507, 939, 1394, 1945},
        extended_date_list = {711, 660, 585, 148, 507, 538, 710, 712, 720, 794, 797, 840, 869, 879, 901, 939, 1185, 1333, 1394, 1467, 1603, 1868, 1885, 1945}
    } } },
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.immutable.were then
            return { key = "j_touhou_keine_kamishirawara_hakutaku", vars = { card.ability.extra.xmult, card.ability.extra.extra_xmult, card.ability.extra.immutable.extended_date_list } }
        else
            return { key = "j_touhou_keine_kamishirawara_human", vars = { card.ability.extra.xmult, card.ability.extra.extra_xmult, card.ability.extra.immutable.date_list } }
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            card:flip()
            card.children.center.sprite_pos.x = 3
            card.ability.extra.immutable.were = true
            card:flip()
        end
        if context.end_of_round and context.main_eval and G.GAME.blind.boss and not context.blueprint then
            card:flip()
            card.children.center.sprite_pos.x = 2
            card.ability.extra.immutable.were = false
            card:flip()
        end
        if context.joker_main then
            local used_list = card.ability.extra.immutable.date_list
            if card.ability.extra.immutable.were then
                used_list = card.ability.extra.immutable.extended_date_list
            end
            local hand_ranks = {}
            local rank = nil
            for i = 1, #G.play.cards do
                if SMODS.has_no_rank(G.play.cards[i]) then
                    rank = 0
                elseif G.play.cards[i]:get_id() == 14 then
                    rank = 1
                else
                    rank = G.play.cards[i]:get_id()
                end
                hand_ranks[rank] = (hand_ranks[rank] or 0) + 1
            end
            local required_ranks = {}
            local valid = true
            local satisfied = 0
            for k, v in ipairs(used_list) do
                if type(v) == "table" then
                    break
                end
                required_ranks = {}
                while v > 0 do
                    required_ranks[v%10] = (required_ranks[v%10] or 0) + 1
                    v = math.floor(v/10)
                end
                for rank_k, rank_v in pairs(required_ranks) do
                    valid = true
                    if rank_v > (hand_ranks[rank_k] or 0) then
                        valid = false
                        break
                    end
                end
                if valid then
                    satisfied = satisfied + 1
                end
            end
            if satisfied > 0 then
                if card.ability.extra.immutable.were then
                    return {
                        xmult = card.ability.extra.xmult + (satisfied - 1) * card.ability.extra.extra_xmult
                    }
                else
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
    end,
}

-- Tewi Inaba
SMODS.Joker {
    key = "tewi_inaba",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 4, y = 4 },
    config = { extra = { repetitions = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, "m_lucky") then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end,
}

-- Reisen Udongein Inaba
SMODS.Joker {
    key = "reisen_udongein_inaba",
    blueprint_compat = false,
    rarity = 3,
    cost = 10,
    atlas = "atlas_jokers_characters",
    pos = { x = 5, y = 4 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        
    end,
}

-- Eirin Yagokoro
SMODS.Joker {
    key = "eirin_yagokoro",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    atlas = "atlas_jokers_characters",
    pos = { x = 6, y = 4 },
    config = { extra = {  } },
    loc_vars = function(self, info_queue, card)
        return { vars = {  } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.game_over and context.main_eval then
            if #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card {
                            set = "Planet",
                            area = G.consumeables,
                            key_append = "touhou_eirin_yagokoro",
                        }
                        return true
                    end
                }))
            end
        end
    end,
}

-- Kaguya Houraisan
SMODS.Joker {
    key = "kaguya_houraisan",
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    atlas = "atlas_jokers_characters",
    pos = { x = 7, y = 4 },
    config = { extra = { limit = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "eternal" }
        return { vars = { card.ability.extra.limit } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            local eternals = {}
            local non_eternals = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].ability.eternal then
                    table.insert(eternals, G.jokers.cards[i])
                elseif (G.jokers.cards[i].config.center.eternal_compat or G.jokers.cards[i].config.center.key == "j_touhou_fujiwara_no_mokou") and not G.jokers.cards[i].ability.perishable then
                    table.insert(non_eternals, G.jokers.cards[i])
                end
            end
            if #non_eternals > 0 then
                local selected = non_eternals[1 + math.floor(pseudorandom("touhou_kaguya_houraisan") * #non_eternals)]
                if selected.config.center.eternal_compat then
                    selected:set_eternal(true)
                else
                    selected.ability.eternal = true
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        selected:juice_up(0.8, 0.8)
                        return true
                    end
                }))
            end
            if #eternals > 0 then
                local selected = eternals[1 + math.floor(pseudorandom("touhou_kaguya_houraisan") * #eternals)]
                selected:set_eternal(false)
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        selected:juice_up(0.8, 0.8)
                        return true
                    end
                }))
            end
        end
    end,
}

-- Fujiwara no Mokou
SMODS.Joker {
    key = "fujiwara_no_mokou",
    blueprint_compat = true,
    eternal_compat = true,
    rarity = 3,
    cost = 7,
    atlas = "atlas_jokers_characters",
    pos = { x = 8, y = 4 },
    config = { extra = { xmult = 1.2, gain = 0.2, immutable = { sell = false, perma_remove = false } } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            card.ability.extra.immutable.sell = true
        end
        if context.check_eternal and card.ability.eternal then
            return {
                no_destroy = { override_compat = true }
            }
        end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        -- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        if not card.ability.extra.immutable.sell then
            G.E_MANAGER:add_event(Event({
                func = function()
                    local replica = copy_card(card)
                    replica:add_to_deck()
                    G.jokers:emplace(replica)
                    replica.ability.extra.xmult = replica.ability.extra.xmult + replica.ability.extra.gain
                    return true
                end
            }))
        elseif not card.ability.extra.immutable.perma_remove then
            card.ability.extra.immutable.sell = false
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.gain
            G.GAME.mokou_list = G.GAME.mokou_list or {}
            table.insert(G.GAME.mokou_list, card)
        end
    end,
}

-- Aya Shameimaru
SMODS.Joker {
    key = "aya_shameimaru",
    blueprint_compat = true,
    rarity = 1,
    cost = 5,
    atlas = "atlas_jokers_characters",
    pos = { x = 0, y = 5 },
    config = { extra = { mult = 8 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = G.GAME.current_round.hands_left * card.ability.extra.mult
            }
        end
    end,
}

-- Medicine Melancholy
SMODS.Joker {
    key = "medicine_melancholy",
    blueprint_compat = true,
    rarity = 3,
    cost = 7,
    atlas = "atlas_jokers_characters",
    pos = { x = 1, y = 5 },
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { set = "Other", key = "perishable", vars = { G.GAME.perishable_rounds, G.GAME.perishable_rounds } }
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            TOUHOU.force_perishable(context.other_card, true)
            if context.other_card.ability.perishable then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}

-- Komachi Onozuka
SMODS.Joker {
    key = "komachi_onozuka",
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    atlas = "atlas_jokers_characters",
    pos = { x = 2, y = 5 },
    config = { extra = { chips_per = 10 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_per } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if TOUHOU.get_max_nominal(scoring_hand) and TOUHOU.get_min_nominal(scoring_hand) then
                return {
                    chips = (TOUHOU.get_max_nominal(scoring_hand).base.nominal - TOUHOU.get_min_nominal(scoring_hand).base.nominal) * card.ability.extra.chips_per
                }
            end
        end
    end,
}

-- Eiki Shiki, Yamaxanadu
SMODS.Joker {
    key = "eiki_shiki_yamaxanadu",
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
    atlas = "atlas_jokers_characters",
    pos = { x = 3, y = 5 },
    soul_pos = { x = 4, y = 5 },
    config = { extra = { numerator = 1, denominator = 4, xmult = 1.2 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(self, card.ability.extra.numerator, card.ability.extra.denominator)
        return { vars = { numerator, denominator, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(self, "touhou_eiki_shiki_yamaxanadu", card.ability.extra.numerator, card.ability.extra.denominator) then 
                context.other_card:set_edition(poll_edition("touhou_eiki_shiki_yamaxanadu", nil, true, true))
            end
            local card_ref = context.other_card
            if SMODS.pseudorandom_probability(self, "touhou_eiki_shiki_yamaxanadu", card.ability.extra.numerator, card.ability.extra.denominator) then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_ref:start_dissolve()
                        return true
                    end
                }))
            end
            if context.other_card:get_edition() then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
}