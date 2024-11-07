return {
    descriptions = {
        Joker = {
            j_zil_haywire_module={
                name="失控模块",
                text={
                    "{C:chips}+40{}筹码 {C:mult}+10{}倍率",
                    "{X:mult,C:white} X2 {}倍率",
                },
            },
            j_zil_perfect_module={
                name="完美模块",
                text={
                    "打出的所有牌",
                    "在计分时给予",
                    "{C:chips}+20{}筹码和{C:mult}+12{}倍率",
                },
            },
            j_zil_power_module={
                name="能量模块",
                text={
                    "留在手牌中的",
                    "每一张牌",
                    "会给予{X:mult,C:white} X1.25 {}倍率",
                },
            },
            j_zil_pylon_module={
                name="输能模块",
                text={
                    "每回合结束重新触发所有",
                    "{C:attention}留在手牌中的{C:attention}牌{}的能力",
                    "下个回合的触发次数加一",
                    "{C:inactive}(最高累积到十次！)",
                },
            },
            j_zil_recursive_module={
                name="递归模块",
                text={
                    "其他每张小丑牌",
                    "会给予{X:mult,C:white} X1.6 {}倍率",
                },
            },
            j_zil_ticking_module={
                name="计时模块",
                text={
                    "在选择{C:attention}盲注{}时",
                    "减少{C:green}30%{}的盲注大小",
                },
            },
            j_zil_virus_module={
                name="病毒模块",
                text={
                    "在跳过{C:attention}盲注{}时",
                    "小丑牌槽位{C:dark_edition}+1{}",
                },
            },
            j_zil_twin_module={
                name="复制模块",
                text={
                    "在击败两个{C:attention}Boss盲注{}后",
                    "依次解锁一个{C:dark_edition}功能模块{}",
                },
            },
            j_zil_zilliax={
                name="奇利亚斯豪华3000版",
                text={
                    "组装{C:dark_edition}功能模块{}",
                    "来打造属于自己的",
                    "{C:tarot}奇利亚斯豪华3000版！",
                },
            },
        },
        Other = {
            zilliax_module={
                name = '奇利亚斯模块',
                text = {
                    '无法获取与使用',
                    '只能在{C:attention}奇利亚斯包{}',
                    '中被用于组装',
                },
            },
            p_zil_zilpack={
                name = '奇利亚斯包',
                text = {
                    '从最多{C:attention}#2#{}张{C:dark_edition}功能模块{}中',
                    '选择{C:attention}#1#{}张进行{C:dark_edition}组装{}',
                    '来打造属于自己的{C:tarot}奇利亚斯',
                },
            },
        },
    },
    misc={
        dictionary = {
            k_booster_zilpackname = "奇利亚斯包",
            k_booster_assemble = "组装",
            k_zilmodule1 = "团结，精确，完美",
            k_zilmodule6 = "-30%",
            k_zilmodule7 = "+1小丑牌槽位",
            k_zilmodule8 = "功能模块已组装",
        },
    },
}