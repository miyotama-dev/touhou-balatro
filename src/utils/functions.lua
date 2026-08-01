TOUHOU.table_length = function(table)
    local i = 0
    for k, v in pairs(table) do i = i + 1 end
    return i
end

TOUHOU.in_table = function(table, item)
    for k, v in pairs(table) do 
        if v == item then
            return true
        end
    end
    return false
end

TOUHOU.get_name = function(card)
    return card:generate_UIBox_ability_table().name[1].nodes[1].nodes[1].config.object.string
end

TOUHOU.get_key = function(card)
    return card.config.center.key
end

TOUHOU.log = function(num, base)
    base = base or 10
    if type(num) == "table" then
        return num:log10()/to_big(base):log10()
    else
        if type(base) == "table" then
            if base.array then
                if base > to_big(1e308) then
                    return to_big(0)
                elseif base.array[2] and base.array[2] >= 3 then
                    return to_big(0)
                else
                    return to_big(math.log(num, base:to_number()))
                end
            else
                return nil
            end
        else
            return math.log(num, base)
        end
    end
end

TOUHOU.deduplicate = function(lst)
    local checked = {}
    local out = {}
    for k, v in ipairs(lst) do
        if (not checked[v]) then
            out[#out+1] = v
            checked[v] = true
        end
    end
    return out
end

TOUHOU.set_card_types = function()
    for k, v in pairs(TOUHOU.other_card_types) do
        for i, j in ipairs(v) do
            TOUHOU.card_types[j] = TOUHOU.card_types[j] or {}
            TOUHOU.card_types[j][k] = true
        end
    end
    for k, v in pairs(TOUHOU.other_card_types_special) do
        TOUHOU.card_types[k] = TOUHOU.card_types[k] or {}
        for i, j in pairs(v) do
            TOUHOU.card_types[k][i] = j
        end
    end
end

TOUHOU.check_type = function(card, card_type)
    if not TOUHOU.card_types[TOUHOU.get_key(card)] then
        return nil
    end
    return TOUHOU.card_types[TOUHOU.get_key(card)][card_type]
end

TOUHOU.get_nth_most_played_hand = function(n, last_hand)
    if not G.GAME then
        return nil
    end
    if table_length(G.GAME.hands or {}) < n then
        return nil
    end
    local hand_list = {}
    for k, v in pairs(G.GAME.hands) do
        table.insert(hand_list, {key = k, value = v.played})
    end
    if last_hand then
        for k, v in pairs(hand_list) do
            if v.key == last_hand then
                v.value = v.value + 1
            end
        end
    end
    table.sort(hand_list, function(a, b) return a.value > b.value end)
    return hand_list[n].key
end

TOUHOU.get_skip_limit = function()
    local limit = 0
    if SMODS.shortcut() then
        limit = 1
    end
    for k, v in ipairs(SMODS.find_card("j_touhou_yukari_yakumo")) do
        limit = limit + (v.ability.extra.skip_limit or 0)
    end
    return limit
end

local wrap_around_straight_hook = SMODS.wrap_around_straight
function SMODS.wrap_around_straight()
    if next(SMODS.find_card("j_touhou_yukari_yakumo")) then
        return true
    end
    return wrap_around_straight_hook()
end

local get_straight_hook = get_straight
function get_straight(hand, min_length, skip, wrap)
    if type(skip) ~= "number" then
        return get_straight_hook(hand, min_length, skip, wrap)
    end
    min_length = min_length or 5
    if min_length < 2 then min_length = 2 end
    if #hand < min_length then return {} end
    local ranks = {}
    for k,_ in pairs(SMODS.Ranks) do ranks[k] = {} end
    for _,card in ipairs(hand) do
        local id = card:get_id()
        if id > 0 then
            for k,v in pairs(SMODS.Ranks) do
                if v.id == id then table.insert(ranks[k], card); break end
            end
        end
    end
    local function next_ranks(key, start)
        local rank = SMODS.Ranks[key]
        local ret = {}
		if not start and not wrap and rank.straight_edge then return ret end
        for _,v in ipairs(rank.next) do
            ret[#ret+1] = v
			if skip ~= 0 then
				for iters = 1, skip do
                    final = #ret
                    for rnk = 1, final do
                        if wrap or not SMODS.Ranks[ret[rnk]].straight_edge then
                            for _,w in ipairs(SMODS.Ranks[ret[rnk]].next) do
                                ret[#ret+1] = w
                            end
                        end
                    end
                    ret = TOUHOU.deduplicate(ret)
                end
			end
        end
        return ret
    end
    local tuples = {}
    local ret = {}
    for _,k in ipairs(SMODS.Rank.obj_buffer) do
        if next(ranks[k]) then
            tuples[#tuples+1] = {k}
        end
    end
    for i = 2, #hand+1 do
        local new_tuples = {}
        for _, tuple in ipairs(tuples) do
            local any_tuple
            if i ~= #hand+1 then
                for _,l in ipairs(next_ranks(tuple[i-1], i == 2)) do
                    if next(ranks[l]) then
                        local new_tuple = {}
                        for _,v in ipairs(tuple) do new_tuple[#new_tuple+1] = v end
                        new_tuple[#new_tuple+1] = l
                        new_tuples[#new_tuples+1] = new_tuple
                        any_tuple = true
                    end
                end
            end
            if i > min_length and not any_tuple then
                local straight = {}
                for _,v in ipairs(tuple) do
                    for _,card in ipairs(ranks[v]) do
                        straight[#straight+1] = card
                    end
                end
                ret[#ret+1] = straight
            end
        end
        tuples = new_tuples
    end
    table.sort(ret, function(a,b) return #a > #b end)
    return ret
end
if SMODS.PokerHandPart.obj_table then -- SMODS.PokerHandPart:take_ownership("_straight", {...}) doesn't work
    SMODS.PokerHandPart.obj_table["_straight"].func = function(hand)
        return get_straight(hand, SMODS.four_fingers("straight"), TOUHOU.get_skip_limit(), SMODS.wrap_around_straight())
    end
end

TOUHOU.force_perishable = function(card, value, rounds)
    card.ability.perishable = value
    card.ability.perish_tally = value and (rounds or G.GAME.perishable_rounds) or nil
end

SMODS.Sticker:take_ownership("perishable", {
    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval then
            card:calculate_perishable()
		end
    end,
})

local cash_out_hook = G.FUNCS.cash_out
G.FUNCS.cash_out = function(e)
    TOUHOU.purge_all()
    SMODS.calculate_context({touhou_cash_out = true})
    return cash_out_hook(e)
end

local play_cards_from_highlighted_hook = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    if G.play and G.play.cards[1] then return end
    for i = 1, #G.hand.highlighted do
        if G.hand.highlighted[i].ability then
            if G.hand.highlighted[i].ability.wheel_flipped then
                G.hand.highlighted[i].ability.touhou_flipped = true
            else
                G.hand.highlighted[i].ability.touhou_flipped = nil
            end
        end
    end
    if next(SMODS.find_card("j_touhou_reisen_udongein_inaba")) then
        if #G.hand.highlighted >= 2 then
            table.sort(G.hand.highlighted, function(a,b) return a.T.x < b.T.x end)
            local card = G.hand.highlighted[1]
            draw_card(G.hand, G.discard, 0, "down", false, card, nil, true)
            local new_card = copy_card(G.hand.highlighted[2])
            new_card.ability.touhou_temporary_card = true
            new_card:add_to_deck()
            G.hand:emplace(new_card, "front")
            table.remove(G.hand.highlighted, 1)
            table.insert(G.hand.highlighted, 1, new_card)
        end
    end
    return play_cards_from_highlighted_hook(e)
end

local create_UIBox_HUD_hook = create_UIBox_HUD
function create_UIBox_HUD()
  local UIBox_HUD = create_UIBox_HUD_hook()
	if not (G.GAME.starting_params.touhou_deck_cherry or G.GAME.starting_params.touhou_deck_mystic) then return UIBox_HUD end
    local scale = 0.4
    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    local contents = {}

    local spacing = 0.13
    local temp_col = G.C.DYN_UI.BOSS_MAIN
    local temp_col2 = G.C.DYN_UI.BOSS_DARK

    -- local amount = 

    contents.buttons = {
      {n=G.UIT.C, config={align = "cm", r=0.1, colour = G.C.CLEAR, shadow = true, id = 'button_area', padding = 0.2}, nodes={
          {n=G.UIT.R, config={id = 'run_info_button', align = "cm", minh = 1.15, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.RED, button = "run_info", shadow = true}, nodes={
            {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.4}, nodes={
              {n=G.UIT.T, config={text = localize('b_run_info_1'), scale = 1.2*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
            {n=G.UIT.R, config={align = "cm", padding = 0, maxw = 1.4}, nodes={
              {n=G.UIT.T, config={text = localize('b_run_info_2'), scale = 1*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true, focus_args = {button = G.F_GUIDE and 'guide' or 'back', orientation = 'bm'}, func = 'set_button_pip'}}
            }}
          }},
          {n=G.UIT.R, config={align = "cm", minh = 1.15, minw = 1.5,padding = 0.05, r = 0.1, hover = true, colour = G.C.ORANGE, button = "options", shadow = true}, nodes={
            {n=G.UIT.C, config={align = "cm", maxw = 1.4, focus_args = {button = 'start', orientation = 'bm'}, func = 'set_button_pip'}, nodes={
              {n=G.UIT.T, config={text = localize('b_options'), scale = scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }},
          }},
        }}
    }

    if G.GAME.starting_params.touhou_deck_cherry then
        G.GAME.touhou_cherry = G.GAME.touhou_cherry or 0
        table.insert(contents.buttons[1].nodes, 
            {n=G.UIT.R, config={align = "cm", padding = 0.05, minw = 1.5, minh = 1.15, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
              {n=G.UIT.R, config={align = "cm", minw = 1.2}, nodes={
                {n=G.UIT.T, config={text = localize('k_touhou_cherry'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
              }},
              {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2, id = 'row_touhou_cherry_text'}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'touhou_cherry'}}, colours = {G.C.TOUHOU_CHERRY},shadow = true, scale = 2*scale}),id = 'row_touhou_cherry_text_UI_count'}},
              }},
            }}
        )
    end

    if G.GAME.starting_params.touhou_deck_mystic then
        G.GAME.touhou_mystic = G.GAME.touhou_mystic or 0
        table.insert(contents.buttons[1].nodes, 
            {n=G.UIT.R, config={align = "cm", padding = 0.05, minw = 1.5, minh = 1.15, colour = temp_col, emboss = 0.05, r = 0.1}, nodes={
              {n=G.UIT.R, config={align = "cm", minw = 1.2}, nodes={
                {n=G.UIT.T, config={text = localize('k_touhou_mystic'), minh = 0.33, scale = 0.85*scale, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
              }},
              {n=G.UIT.R, config={align = "cm", r = 0.1, minw = 1.2, colour = temp_col2, id = 'row_touhou_mystic_text'}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'touhou_mystic'}}, colours = {G.C.TOUHOU_MYSTIC},shadow = true, scale = 2*scale}),id = 'row_touhou_mystic_text_UI_count'}},
              }},
            }}
        )
    end

    UIBox_HUD.nodes[1].nodes[1].nodes[5].nodes[1].nodes = contents.buttons
    return UIBox_HUD
end

TOUHOU.ease_cherry = function(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local cherry_UI = G.HUD:get_UIE_by_ID('row_touhou_cherry_text_UI_count')
          mod = mod or 0
          local text = '+'
          local col = G.C.IMPORTANT
          if to_big(mod) < to_big(0) then
              text = '-'
              col = G.C.RED
          end
          G.GAME.touhou_cherry = (G.GAME.touhou_cherry or 0) + mod
          if cherry_UI then
            G.HUD:recalculate()
            if not Talisman.config_file.disable_anims then
              attention_text({
                text = text..tostring(math.abs(mod)),
                scale = 1, 
                hold = 0.7,
                cover = cherry_UI.parent,
                cover_colour = col,
                align = 'cm',
              })
            end
          end
          return true
      end
    }))
end

TOUHOU.ease_mystic = function(mod)
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
          local mystic_UI = G.HUD:get_UIE_by_ID('row_mystic_text_UI_count')
          mod = mod or 0
          local text = '+'
          local col = G.C.IMPORTANT
          if to_big(mod) < to_big(0) then
              text = '-'
              col = G.C.RED
          end
          if not G.GAME.touhou_mystic_uncapped then
            G.GAME.touhou_mystic = (G.GAME.touhou_mystic or 0) + mod
            if G.GAME.touhou_mystic > (G.GAME.touhou_mystic_max or TOUHOU.mystic_max) then
                G.GAME.touhou_mystic = G.GAME.touhou_mystic_max or TOUHOU.mystic_max
            end
            if G.GAME.touhou_mystic < (G.GAME.touhou_mystic_min or TOUHOU.mystic_min) then
                G.GAME.touhou_mystic = G.GAME.touhou_mystic_min or TOUHOU.mystic_min
            end
          end
          if mystic_UI then
            G.HUD:recalculate()
            if not Talisman.config_file.disable_anims then
              attention_text({
                text = text..tostring(math.abs(mod)),
                scale = 1, 
                hold = 0.7,
                cover = mystic_UI.parent,
                cover_colour = col,
                align = 'cm',
              })
            end
          end
          TOUHOU.calculate_mystic_color()
          return true
      end
    }))
end

TOUHOU.calculate_mystic_color = function()
    G.GAME.touhou_mystic = G.GAME.touhou_mystic or 0
    G.GAME.touhou_mystic_max = G.GAME.touhou_mystic_max or TOUHOU.mystic_max
    G.GAME.touhou_mystic_youkai = G.GAME.touhou_mystic_youkai or TOUHOU.mystic_youkai
    G.GAME.touhou_mystic_neutral = G.GAME.touhou_mystic_neutral or TOUHOU.mystic_neutral
    G.GAME.touhou_mystic_human = G.GAME.touhou_mystic_human or TOUHOU.mystic_human
    G.GAME.touhou_mystic_min = G.GAME.touhou_mystic_min or TOUHOU.mystic_min
    for i = 1, #G.C.TOUHOU_MYSTIC do
        if G.GAME.touhou_mystic > TOUHOU.mystic_youkai then
            G.C.TOUHOU_MYSTIC[i] = G.C.TOUHOU_MYSTIC_YOUKAI[i]
        elseif G.GAME.touhou_mystic < TOUHOU.mystic_human then
            G.C.TOUHOU_MYSTIC[i] = G.C.TOUHOU_MYSTIC_HUMAN[i]
        elseif G.GAME.touhou_mystic > TOUHOU.mystic_neutral then
            G.C.TOUHOU_MYSTIC[i] = (G.C.TOUHOU_MYSTIC_YOUKAI[i] * (G.GAME.touhou_mystic - G.GAME.touhou_mystic_neutral) + G.C.TOUHOU_MYSTIC_NEUTRAL[i] * (G.GAME.touhou_mystic_youkai - G.GAME.touhou_mystic))/(G.GAME.touhou_mystic_youkai - G.GAME.touhou_mystic_neutral)
        elseif G.GAME.touhou_mystic < TOUHOU.mystic_neutral then
            G.C.TOUHOU_MYSTIC[i] = (G.C.TOUHOU_MYSTIC_HUMAN[i] * (G.GAME.touhou_mystic_neutral - G.GAME.touhou_mystic) + G.C.TOUHOU_MYSTIC_NEUTRAL[i] * (G.GAME.touhou_mystic - G.GAME.touhou_mystic_human))/(G.GAME.touhou_mystic_neutral - G.GAME.touhou_mystic_human)
        else
            G.C.TOUHOU_MYSTIC[i] = G.C.TOUHOU_MYSTIC_NEUTRAL[i]
        end
    end
end

TOUHOU.end_of_round_calculations = function()
    TOUHOU.purge_all()
    if G.GAME.starting_params.touhou_deck_cherry then
        amount = TOUHOU.log(G.GAME.chips/G.GAME.blind.chips) * (G.GAME.touhou_cherry_multiplier or 1) * 20
        if amount * 2 == amount then
            amount = to_big(0)
        end
        TOUHOU.ease_cherry(amount)
    end
end

local main_menu_hook = Game.main_menu
Game.main_menu = function(change_context)
    local main_menu_eval = main_menu_hook(change_context)

    local SC_scale = 1.1*(G.debug_splash_size_toggle and 0.8 or 1)
    local replace_card = Card(G.title_top.T.x, G.title_top.T.y, 1.2*G.CARD_W*SC_scale, 1.2*G.CARD_H*SC_scale, G.P_CARDS.empty, G.P_CENTERS.j_touhou_yukari_yakumo, { bypass_discovery_center = true })
    G.title_top.T.w = G.title_top.T.w * 1.7675
    G.title_top.T.x = G.title_top.T.x - 0.8
    G.title_top:emplace(replace_card)
    
    replace_card.states.visible = false
    replace_card.no_ui = true
    replace_card.ambient_tilt = 0.0

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0,
        blockable = false,
        blocking = false,
        func = (function()
            if change_context == 'splash' then 
                replace_card.states.visible = true
                replace_card:start_materialize({G.C.WHITE,G.C.WHITE}, true, 2.5)
            else
                replace_card.states.visible = true
                replace_card:start_materialize({G.C.WHITE,G.C.WHITE}, nil, 1.2)
            end
            return true
    end)}))

    return main_menu_eval
end

local draw_card_hook = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
    if from == G.deck and to == G.hand then
        if G.GAME.touhou_illusion_draw then
            if pseudorandom("touhou_illusion_draw") < (G.GAME.touhou_illusion_draw_probability or 1) * (G.GAME.probabilities.normal or 1) then
                local card_copy = copy_card(card)
                card_copy.ability.touhou_illusion_card = true
                G.GAME.touhou_fake_deck_cardarea:emplace(card_copy, 'front')
                card_copy:add_to_deck()
                return draw_card_hook(G.GAME.touhou_fake_deck_cardarea, G.hand, percent, dir, sort, card_copy, delay, mute, stay_flipped, vol, discarded_only)
            end
        end
    end
    return draw_card_hook(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
end

local game_start_run_hook = Game.start_run
function Game:start_run(args)
    game_start_run_hook(self, args)
    G.GAME.touhou_fake_deck_cardarea = CardArea(0, 0, 0, 0, { highlight_limit = 0, card_limit = 10000, type = 'deck' })
    G.GAME.touhou_fake_deck_cardarea.cards = G.GAME.touhou_fake_deck_cardarea.cards or {}
    G.GAME.touhou_fake_deck_cardarea.original_T = G.deck.original_T
    G.GAME.touhou_fake_deck_cardarea.T = G.deck.T
    G.GAME.touhou_fake_deck_cardarea:hard_set_VT()
end

eval_card_hook = eval_card
function eval_card(card, context)
    if card and card.ability.touhou_illusion_card then
        return {}
    end
    return eval_card_hook(card, context)
end

TOUHOU.purge = function(area, card_type, remove)
    for i = #area.cards, 1, -1 do
        if area.cards[i].ability[card_type] then
            area.cards[i]:start_dissolve()
            area:remove_card(area.cards[i], false)
        end
    end
end

local purge_all_list = {"touhou_temporary_card", "touhou_illusion_card", "touhou_effigy_destroy"}
TOUHOU.purge_all = function()
    for area = 1, #G.I.CARDAREA do
        for card_type = 1, #purge_all_list do
            TOUHOU.purge(G.I.CARDAREA[area], purge_all_list[card_type], false)
        end
    end
end

TOUHOU.purge_cards = function(area, card_type, remove, cards)
    for i = #cards, 1, -1 do
        if cards[i].ability[card_type] then
            cards[i]:start_dissolve()
            area:remove_card(cards[i], false)
        end
    end
end

local end_round_hook = end_round
function end_round()
    result = end_round_hook()
    TOUHOU.purge_all()
    return result
end

local play_cards_from_highlighted_hook = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    TOUHOU.purge_cards(G.hand, "touhou_illusion_card", true, G.hand.highlighted)
    return play_cards_from_highlighted_hook()
end

-- local evaluate_play_intro_hook = evaluate_play_intro
-- function evaluate_play_intro()
--     TOUHOU.purge(G.play, "touhou_illusion_card", true)
--     return evaluate_play_intro_hook()
-- end

local evaluate_play_intro_hook = evaluate_play_intro
function evaluate_play_intro()
    local text,disp_text,poker_hands,scoring_hand,non_loc_disp_text = G.FUNCS.get_poker_hand_info(G.play.cards)
    if G.GAME.hands[text] then
        return evaluate_play_intro_hook()
    end
    return
end

local evaluate_play_main_hook = evaluate_play_main
function evaluate_play_main(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    if G.GAME.hands[text] then
        return evaluate_play_main_hook(text, disp_text, poker_hands, scoring_hand, non_loc_disp_text, percent, percent_delta)
    end
    return
end

local play_cards_from_highlighted_hook = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    local ret = play_cards_from_highlighted_hook(e)
    if G.GAME.starting_params.touhou_deck_mystic then
        for i = 1, #G.jokers.cards do
            if TOUHOU.check_type(G.jokers.cards[i], "human") then
                if type(TOUHOU.check_type(G.jokers.cards[i], "human")) == "boolean" then
                    TOUHOU.ease_mystic(-1)
                elseif type(TOUHOU.check_type(G.jokers.cards[i], "human")) == "number" then
                    TOUHOU.ease_mystic(-TOUHOU.check_type(G.jokers.cards[i], "human"))
                end
            end
            if TOUHOU.check_type(G.jokers.cards[i], "youkai") then
                if type(TOUHOU.check_type(G.jokers.cards[i], "youkai")) == "boolean" then
                    TOUHOU.ease_mystic(1)
                elseif type(TOUHOU.check_type(G.jokers.cards[i], "youkai")) == "number" then
                    TOUHOU.ease_mystic(TOUHOU.check_type(G.jokers.cards[i], "human"))
                end
            end
        end
    end
    return ret
end

TOUHOU.get_max_nominal = function(cards)
    local card = nil
    local maximum = nil
    for k, v in pairs(cards) do
        maximum = math.max(maximum or v.base.nominal, v.base.nominal)
        card = v.base.nominal == maximum and v or card
    end
    return card
end

TOUHOU.get_min_nominal = function(cards)
    local card = nil
    local minimum = nil
    for k, v in pairs(cards) do
        minimum = math.min(minimum or v.base.nominal, v.base.nominal)
        card = v.base.nominal == minimum and v or card
    end
    return card
end

local add_to_deck_hook = Card.add_to_deck
function Card:add_to_deck(from_debuff)
    if not self.added_to_deck then
        SMODS.calculate_context({touhou_card_add_to_deck = true, card = self})
    end
    return add_to_deck_hook(self, from_debuff)
end

local remove_from_deck_hook = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
    if self.added_to_deck then
        SMODS.calculate_context({touhou_card_remove_from_deck = true, card = self})
    end
    return remove_from_deck_hook(self, from_debuff)
end

local sell_card_hook = Card.sell_card
function Card:sell_card()
    if self.added_to_deck then
        SMODS.calculate_context({touhou_sell_card = true, card = self})
    end
    return sell_card_hook(self)
end

local is_suit_hook = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    ret = is_suit_hook(self, suit, bypass_debuff, flush_calc)
    if ret then
        return ret
    end
    return TOUHOU.sphere_of_darkness_check(self, suit)
end

TOUHOU.sphere_of_darkness_check = function(card, suit)
    if not next(SMODS.find_card("j_touhou_sphere_of_darkness")) then
        return false
    end
    if (card.base.suit == "Hearts") and (suit == "Hearts" or suit == "Spades") then
        return true
    elseif (card.base.suit == "Diamonds") and (suit == "Diamonds" or suit == "Clubs") then
        return true
    end
    return false
end

local set_ability_hook = Card.set_ability
function Card:set_ability(center, initial, delay_sprites)
    ret = set_ability_hook(self, center, initial, delay_sprites)
    if self.config.center.key == "j_touhou_mountain_cat" then
        self.ability.extra.current_chips = pseudorandom("touhou_mountain_cat", self.ability.extra.min_chips, self.ability.extra.max_chips)
    end
    return ret
end

TOUHOU.share_id = function(card1, card2)
    return card1:get_id() == card2:get_id()
end

TOUHOU.share_suit = function(card1, card2)
    return (card1:is_suit(card1.base.suit) and card2:is_suit(card1.base.suit)) or (card1:is_suit(card2.base.suit) and card2:is_suit(card2.base.suit))
end

TOUHOU.get_hands = function()
    if not G.GAME then
        return nil
    end
    local hand_list = {}
    for k, v in pairs(SMODS.PokerHands) do
        table.insert(hand_list, {key = k, value = v.order})
    end
    table.sort(hand_list, function(a, b) return a.value < b.value end)
    return hand_list
end

TOUHOU.has_high_hand = function(hand, poker_hands)
    local hand_list = TOUHOU.get_hands()
    for i = 1, math.floor(#hand_list/2) do
        local scoring_name = G.FUNCS.get_poker_hand_info(hand)
        local hand = hand_list[i].key
        if scoring_name == hand then
            return hand
        end
        -- if poker_hands[hand] and next(poker_hands[hand]) then
        --     return hand
        -- end
    end
end

TOUHOU.has_low_hand = function(hand, poker_hands)
    local hand_list = TOUHOU.get_hands()
    for i = math.floor(#hand_list/2) + 1, #hand_list do
        local scoring_name = G.FUNCS.get_poker_hand_info(hand)
        local hand = hand_list[i].key
        if scoring_name == hand then
            return hand
        end
        -- if poker_hands[hand] and next(poker_hands[hand]) then
        --     return hand
        -- end
    end
end

local discard_cards_from_highlighted_hook = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
    ret = discard_cards_from_highlighted_hook(e, hook)
    SMODS.calculate_context({touhou_after_discard = true})
    return ret
end

-- Easy way doesn't work
-- SMODS.calculation_keys[#SMODS.calculation_keys + 1] = "touhou_blind_div"
local calculate_effect_hook = SMODS.calculate_effect
function SMODS.calculate_effect(effect, scored_card, from_edition, pre_jokers)
    local keys = {"touhou_blind_div"}
    for k, v in pairs(keys) do
        if not TOUHOU.in_table(SMODS.calculation_keys, v) then
            SMODS.calculation_keys[#SMODS.calculation_keys + 1] = v
        end
    end
    SMODS.calculate_effect = calculate_effect_hook
    -- print(SMODS.calculation_keys)
    return calculate_effect_hook(effect, scored_card, from_edition, pre_jokers)
end


local calculate_individual_effect_hook = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    if key == "touhou_blind_div" and amount then
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.blind.chips = G.GAME.blind.chips * 1/amount
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                return true
            end
        }))
        card_eval_status_text(scored_card, "jokers", nil, percent, nil, { message = "/"..amount.." Blind Size", colour = G.C.TOUHOU_BLIND_MANIPULATE })
        return true
    end
    return calculate_individual_effect_hook(effect, scored_card, key, amount, from_edition)
end

local set_debuff_hook = Card.set_debuff
function Card:set_debuff(should_debuff)
    if TOUHOU.get_key(self) == "j_touhou_hakurouken" then
        should_debuff = false
    end
    ret = set_debuff_hook(self, should_debuff)
    if TOUHOU.get_key(self) == "j_touhou_hakurouken" then
        self.debuff = false
    end
    return ret
end
    