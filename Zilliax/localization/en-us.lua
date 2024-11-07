return {
    descriptions = {
        Joker = {
            j_zil_haywire_module={
                name="Haywire Module",
                text={
                    "{C:chips}+40{} Chips {C:mult}+10{} Mult",
                    "{X:mult,C:white} X2 {} Mult",
                },
            },
            j_zil_perfect_module={
                name="Perfect Module",
                text={
                    "Played cards give",
                    "{C:chips}+20{} Chips and",
                    "{C:mult}+12{} Mult when scored", 
                },
            },
            j_zil_power_module={
                name="Power Module",
                text={
                    "Each card",
                    "held in hand",
                    "gives {X:mult,C:white} X1.25 {} Mult",
                },
            },
            j_zil_pylon_module={
                name="Pylon Module",
                text={
                    "Retrigger all card {C:attention}held in",
                    "{C:attention}hand{} abilities at end of round",
                    "next round will retrigger one more time",
                    "{C:inactive}(maximum accumulation up to ten times!)",
                },
            },
            j_zil_recursive_module={
                name="Recursive Module",
                text={
                    "Other Jokers",
                    "each give {X:mult,C:white} X1.6 {} Mult",
                },
            },
            j_zil_ticking_module={
                name="Ticking Module",
                text={
                    "When {C:attention}Blind{} is selected",
                    "reduce its score requirement by {C:green}30%{}",
                },
            },
            j_zil_virus_module={
                name="Virus Module",
                text={
                    "When {C:attention}Blind{} is skipped",
                    "{C:dark_edition}+1{} Joker Slot",
                },
            },
            j_zil_twin_module={
                name="Twin Module",
                text={
                    "After beating {C:attention}2 Boss Blind{}",
                    "Unlock a {C:dark_edition}Functional Module{} in turn",
                },
            },
            j_zil_zilliax={
                name="Zilliax",
                text={
                    "Assemble {C:dark_edition}Functional Modules{}",
                    "to create your own",
                    "{C:tarot}Zilliax!",
                },
            },
        },
        Other = {
            zilliax_module={
                name = 'Zilliax Module',
                text = {
                    'Unable to be accessed or utilized',
                    'can only be used for',
                    'assembly in {C:attention}Zilliax Pack',
                },
            },
            p_zil_zilpack={
                name = 'Zilliax Pack',
                text = {
                    "Choose {C:attention}#1#{} of up to",
                    "{C:attention}#2#{C:dark_edition} Functional Modules{} to assemble",
                    'your own {C:tarot}Zilliax!',
                },
            },
        },
    },
    misc={
        dictionary = {
            k_booster_zilpackname = "Zilliax Pack",
            k_booster_assemble = "Assemble",
            k_zilmodule1 = "United, Precise, Perfect",
            k_zilmodule6 = "-30%",
            k_zilmodule7 = "+1 Joker Slot",
            k_zilmodule8 = "Assemble Functional Module!",
        },
    },
}