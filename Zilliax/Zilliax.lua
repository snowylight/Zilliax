--- STEAMODDED HEADER
--- MOD_NAME: Zilliax
--- MOD_ID: Zilliax
--- MOD_AUTHOR: [sishui]
--- MOD_DESCRIPTION: Customizable Your own Zilliax
--- BADGE_COLOUR: 9933FF
--- VERSION: 1.0.1
--- PREFIX: zil
----------------------------------------------
------------MOD CODE -------------------------
SMODS.Atlas({key = 'haywire_module', path = 'Haywire_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'perfect_module', path = 'Perfect_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'power_module', path = 'Power_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'pylon_module', path = 'Pylon_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'recursive_module', path = 'Recursive_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'ticking_module', path = 'Ticking_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'virus_module', path = 'Virus_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'twin_module', path = 'Twin_Module.png', px = 71, py = 95 })
SMODS.Atlas({key = 'zilliax', path = 'Zilliax.png', px = 71, py = 95 })
SMODS.Atlas({key = 'zilpack', path = 'Zilpack.png', px = 71, py = 95 })

local alias__G_UIDEF_use_and_sell_buttons = G.UIDEF.use_and_sell_buttons;
function G.UIDEF.use_and_sell_buttons(card)
    local ret = alias__G_UIDEF_use_and_sell_buttons(card)
    
    if card.config.center.key and (card.area == G.pack_cards and G.pack_cards) and string.find(card.ability.name, "zilmodule") then
        return {
            n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                {n=G.UIT.R, config={mid = true}, nodes={
                }},
                {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, minh = 0.8*card.T.h, maxw = 0.7*card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'select_module', func = 'can_select_module'}, nodes={
                {n=G.UIT.T, config={text = localize('b_select'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
            }},
        }}
    end
    
    return ret
end

G.FUNCS.can_select_module = function(e)
    if G.GAME.modifiers.moduleassemble == false or ((e.config.ref_table.edition and e.config.ref_table.edition.negative) or #G.jokers.cards < G.jokers.config.card_limit) then 
        e.config.colour = G.C.GREEN
        e.config.button = 'select_module'
    else
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
    end
end

G.FUNCS.select_module = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          if G.GAME.modifiers.moduleassemble == true then
          c1:remove()
          if c1.children.price then c1.children.price:remove() end
          c1.children.price = nil
          if c1.children.buy_button then c1.children.buy_button:remove() end
          c1.children.buy_button = nil
          remove_nils(c1.children)
          cmodule0 = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_zil_zilliax", nil)
          cmodule0:add_to_deck()
          G.jokers:emplace(cmodule0)
          cmodule0.ability[c1.ability.name] = true
          G.GAME.pack_choices = G.GAME.pack_choices - 1
          else
          c1:remove()
          if c1.children.price then c1.children.price:remove() end
          c1.children.price = nil
          if c1.children.buy_button then c1.children.buy_button:remove() end
          c1.children.buy_button = nil
          remove_nils(c1.children)
          cmodule0.ability[c1.ability.name] = true
          card_eval_status_text(cmodule0, 'extra', nil, nil, nil, {message = "" .. localize('k_booster_assemble'), colour = G.C.DARK_EDITION})
          G.GAME.pack_choices = G.GAME.pack_choices - 1
          end
          if G.GAME.pack_choices <= 0 then
            G.FUNCS.end_consumeable(nil, delay_fac)
          end
          G.GAME.modifiers.moduleassemble = false
          return true
        end
    }))
end

function get_zilpack_pool(_pack, _type, _rarity, _legendary, _append)

    G.ARGS.TEMP_POOL = EMPTY(G.ARGS.TEMP_POOL)
    local _pool, _starting_pool,_pool_key, _pool_size = G.ARGS.TEMP_POOL, nil, '', 0

    _starting_pool = {
        'j_zil_haywire_module',
        'j_zil_perfect_module',
        'j_zil_power_module',
        'j_zil_pylon_module',
        'j_zil_recursive_module',
        'j_zil_ticking_module',
        'j_zil_virus_module',
        'j_zil_twin_module',
    }

    --cull the pool
    for k, v in ipairs(_starting_pool) do
        local add = true
        
        if G.GAME.used_jokers[v] then
            add = nil
        end

        if add then
           _pool[#_pool+1] = v
        end
    end

    for k,v in pairs(_pool) do
        _pool_size = _pool_size + 1
    end

    --if pool is empty
    if _pool_size == 0 then
        _pool = EMPTY(G.ARGS.TEMP_POOL)
        if _type == 'Tarot' or _type == 'Tarot_Planet' then _pool[#_pool + 1] = "c_fool"
        elseif _type == 'Planet' then _pool[#_pool + 1] = "c_pluto"
        elseif _type == 'Spectral' then _pool[#_pool + 1] = "c_incantation"
        elseif _type == 'Joker' then _pool[#_pool + 1] = "j_joker"
        elseif _type == 'Demo' then _pool[#_pool + 1] = "j_joker"
        elseif _type == 'Voucher' then _pool[#_pool + 1] = "v_blank"
        elseif _type == 'Tag' then _pool[#_pool + 1] = "tag_handy"
        else _pool[#_pool + 1] = "j_joker"
        end
    end

    return _pool, _pool_key..G.GAME.round_resets.ante
end

function create_zilpack_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local area = area or G.jokers
    local center = G.P_CENTERS.b_red
        

    --should pool be skipped with a forced key
    if not forced_key and soulable and (not G.GAME.banned_keys['c_soul']) then
    	for _, v in ipairs(SMODS.Consumable.legendaries) do
    		if (_type == v.type.key or _type == v.soul_set) and not (G.GAME.used_jokers[v.key] and not next(find_joker("Showman")) and not v.can_repeat_soul) then
    			if pseudorandom('soul_'..v.key.._type..G.GAME.round_resets.ante) > (1 - v.soul_rate) then
    				forced_key = v.key
    			end
    		end
    	end
        if (_type == 'Tarot' or _type == 'Spectral' or _type == 'Tarot_Planet') and
        not (G.GAME.used_jokers['c_soul'] and not next(find_joker("Showman")))  then
            if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                forced_key = 'c_soul'
            end
        end
        if (_type == 'Planet' or _type == 'Spectral') and
        not (G.GAME.used_jokers['c_black_hole'] and not next(find_joker("Showman")))  then 
            if pseudorandom('soul_'.._type..G.GAME.round_resets.ante) > 0.997 then
                forced_key = 'c_black_hole'
            end
        end
    end

    if _type == 'Base' then 
        forced_key = 'c_base'
    end



    if forced_key and not G.GAME.banned_keys[forced_key] then 
        center = G.P_CENTERS[forced_key]
        _type = (center.set ~= 'Default' and center.set or _type)
    else
        local _pool, _pool_key = get_zilpack_pool(_type, _rarity, legendary, key_append)
        center = pseudorandom_element(_pool, pseudoseed(_pool_key))
        local it = 1
        while center == 'UNAVAILABLE' do
            it = it + 1
            center = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
        end

        center = G.P_CENTERS[center]
    end

    local front = ((_type=='Base' or _type == 'Enhanced') and pseudorandom_element(G.P_CARDS, pseudoseed('front'..(key_append or '')..G.GAME.round_resets.ante))) or nil

    local card = Card(area.T.x + area.T.w/2, area.T.y, G.CARD_W, G.CARD_H, front, center,
    {bypass_discovery_center = area==G.shop_jokers or area == G.pack_cards or area == G.shop_vouchers or (G.shop_demo and area==G.shop_demo) or area==G.jokers or area==G.consumeables,
     bypass_discovery_ui = area==G.shop_jokers or area == G.pack_cards or area==G.shop_vouchers or (G.shop_demo and area==G.shop_demo),
     discover = area==G.jokers or area==G.consumeables, 
     bypass_back = G.GAME.selected_back.pos})
    if card.ability.consumeable and not skip_materialize then card:start_materialize() end
    for k, v in ipairs(SMODS.Sticker.obj_buffer) do
        local sticker = SMODS.Stickers[v]
        if sticker.should_apply and type(sticker.should_apply) == 'function' and sticker:should_apply(card, center, area) then
            sticker:apply(card, true)
        end
    end

    return card
end

SMODS.Booster{
    key = "zilpack",
    atlas = 'zilpack',
    pos = {x = 0, y = 0},
    weight = 0.8,
    cost = 12,
    config = {extra = 5, choose = 2},
    discovered = true,
    loc_txt ={},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = "j_zil_zilliax", set = "Joker"}
        return { vars = {card.ability.choose, card.ability.extra} }
    end,
    create_card = function(self, card)
        return create_zilpack_card('Joker', G.pack_cards, nil, nil, true, nil, nil, 'zilpackmodule')
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.FILTER)
        ease_background_colour{new_colour = G.C.PURPLE, special_colour = G.C.DARK_EDITION, contrast = 5}
    end,
    create_UIBox = function(self)
        G.GAME.modifiers.moduleassemble = true
        local _size = SMODS.OPENED_BOOSTER.ability.extra
        G.pack_cards = CardArea(
            G.ROOM.T.x + 9 + G.hand.T.x, G.hand.T.y,
            math.max(1,math.min(_size,5))*G.CARD_W*1.1,
            1.05*G.CARD_H, 
            {card_limit = _size, type = 'consumeable', highlight_limit = 1})

        local t = {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
            {n=G.UIT.R, config={align = "cl", colour = G.C.CLEAR,r=0.15, padding = 0.1, minh = 2, shadow = true}, nodes={
                {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.1}, nodes={
                    {n=G.UIT.C, config={align = "cm", r=0.2, colour = G.C.CLEAR, shadow = true}, nodes={
                        {n=G.UIT.O, config={object = G.pack_cards}},}}}}}},
            {n=G.UIT.R, config={align = "cm"}, nodes={}},
            {n=G.UIT.R, config={align = "tm"}, nodes={
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05}, nodes={
                    UIBox_dyn_container({
                        {n=G.UIT.C, config={align = "cm", padding = 0.05, minw = 4}, nodes={
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_booster_zilpackname')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.7, maxw = 4, pop_in = 0.5})}}}},
                            {n=G.UIT.R,config={align = "bm", padding = 0.05}, nodes={
                                {n=G.UIT.O, config={object = DynaText({string = {localize('k_choose')..' '}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}},
                                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = G.GAME, ref_value = 'pack_choices'}}, colours = {G.C.WHITE},shadow = true, rotate = true, bump = true, spacing =2, scale = 0.5, pop_in = 0.7})}}}},}}
                    }),}},
                {n=G.UIT.C,config={align = "tm", padding = 0.05, minw = 2.4}, nodes={
                    {n=G.UIT.R,config={minh =0.2}, nodes={}},
                    {n=G.UIT.R,config={align = "tm",padding = 0.2, minh = 1.2, minw = 1.8, r=0.15,colour = G.C.GREY, one_press = true, button = 'skip_booster', hover = true,shadow = true, func = 'can_skip_booster'}, nodes = {
                        {n=G.UIT.T, config={text = localize('b_skip'), scale = 0.5, colour = G.C.WHITE, shadow = true, focus_args = {button = 'y', orientation = 'bm'}, func = 'set_button_pip'}}}}}}}}}}}}
        return t
    end,
}

SMODS.Joker{
    key = 'zilliax',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'zilliax',
    config = {zilmodule1=false, zilmodule2=false, zilmodule3=false, zilmodule4=false, zilmodule5=false, zilmodule6=false, zilmodule7=false, zilmodule8=false, extra={rept=0, moduletally=1}},
    loc_vars = function(self, info_queue, card)
        if card.ability.zilmodule1 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_haywire_module', set = 'Joker'}
        end
        if card.ability.zilmodule2 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_perfect_module', set = 'Joker'}
        end
        if card.ability.zilmodule3 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_power_module', set = 'Joker'}
        end
        if card.ability.zilmodule4 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_pylon_module', set = 'Joker'}
        end
        if card.ability.zilmodule5 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_recursive_module', set = 'Joker'}
        end
        if card.ability.zilmodule6 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_ticking_module', set = 'Joker'}
        end
        if card.ability.zilmodule7 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_virus_module', set = 'Joker'}
        end
        if card.ability.zilmodule8 == true then
        info_queue[#info_queue+1] = {key = 'j_zil_twin_module', set = 'Joker'}
        end
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        --1
        if card.ability.zilmodule1 == true then
        if context.joker_main and context.cardarea == G.jokers then
        return {
            message = localize('k_zilmodule1')..' ',
            chip_mod = 40,
            mult_mod = 10,
            Xmult_mod = 2
        }
        end
        end
        --2
        if card.ability.zilmodule2 == true then
        if context.cardarea == G.play and context.individual and not context.other_card.debuff then
                return {
                    chips = 20,
                    mult = 12,
				    card = card
                }
        end
        end
        --3
        if card.ability.zilmodule3 == true then
        if context.cardarea == G.hand and context.individual and not context.end_of_round and not context.other_card.debuff then
            return{
                x_mult = 1.25,
                card = card
            }
        end
        end
        --4
        if card.ability.zilmodule4 == true then
        if context.cardarea == G.hand and context.end_of_round and context.repetition and (next(context.card_effects[1]) or #context.card_effects > 1) and not context.other_card.debuff then
            return {
                message = localize('k_again_ex'),
                repetitions = math.min(math.max(card.ability.extra.rept, 1), 10),
                card = card
            }
        end
        if context.setting_blind and not context.blueprint then
            card.ability.extra.rept = card.ability.extra.rept + 1
        end
        end
        --5
        if card.ability.zilmodule5 == true then
        if context.other_joker and context.other_joker ~= card and context.other_joker.ability.set == 'Joker' then
                -- Animate
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                }))
                -- Apply xmult
                return {
                    message = localize {
                        type = 'variable',
                        key = 'a_xmult',
                        vars = { 1.6 }
                    },
                    Xmult_mod = 1.6
                }
        end
        end
        --6
        if card.ability.zilmodule6 == true then
        if context.setting_blind then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "" .. localize('k_zilmodule6'), colour = G.C.GREEN})
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 0.7)
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                
                local chips_UI = G.hand_text_area.blind_chips
                G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                G.HUD_blind:recalculate() 
                chips_UI:juice_up()

                return true end }))
        end
        end
        --7
        if card.ability.zilmodule7 == true then
        if context.skip_blind then
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "" .. localize('k_zilmodule7'), colour = G.C.PURPLE})
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1
        end
        end
        --8
        if card.ability.zilmodule8 == true then
        if G.GAME.blind.boss and context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            card.ability.extra.moduletally = card.ability.extra.moduletally + 1
            if card.ability.extra.moduletally%2 == 1 then
                local canadd = true
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = "" .. localize('k_zilmodule8'), colour = G.C.DARK_EDITION})
                if card.ability.zilmodule1 == false and canadd == true then
                   card.ability.zilmodule1 = true
                   canadd = false
                elseif card.ability.zilmodule2 == false and canadd == true then
                   card.ability.zilmodule2 = true
                   canadd = false
                elseif card.ability.zilmodule3 == false and canadd == true then
                   card.ability.zilmodule3 = true
                   canadd = false
                elseif card.ability.zilmodule4 == false and canadd == true then
                   card.ability.zilmodule4 = true
                   canadd = false
                elseif card.ability.zilmodule5 == false and canadd == true then
                   card.ability.zilmodule5 = true
                   canadd = false
                elseif card.ability.zilmodule6 == false and canadd == true then
                   card.ability.zilmodule6 = true
                   canadd = false
                elseif card.ability.zilmodule7 == false and canadd == true then
                   card.ability.zilmodule7 = true
                   canadd = false
                end
            end
        end
        end
    end
}

SMODS.Joker{
    name = 'zilmodule1',
    key = 'haywire_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'haywire_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'zilmodule2',
    key = 'perfect_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'perfect_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'zilmodule3',
    key = 'power_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'power_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'zilmodule4',
    key = 'pylon_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'pylon_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'zilmodule5',
    key = 'recursive_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'recursive_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'zilmodule6',
    key = 'ticking_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'ticking_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'zilmodule7',
    key = 'virus_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'virus_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}

SMODS.Joker{
    name = 'zilmodule8',
    key = 'twin_module',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    loc_txt ={},
    yes_pool_flag = 'zilmodule_extinct',
    atlas = 'twin_module',
    config = {},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'zilliax_module', set = 'Other'}
        return { vars = {} }
    end,
    calculate = function(self, card, context)
    end
}
----------------------------------------------
------------MOD CODE END----------------------