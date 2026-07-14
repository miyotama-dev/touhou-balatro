return {
	misc = {
		dictionary = {
			k_touhou_boss_reroll = "Rerolled!",
            k_touhou_cherry = "Cherry",
            k_touhou_mystic = "Mystic",
            k_touhou_exterminate = "Exterminated!",
            k_touhou_roukanken_ex = "Cut!",
            k_touhou_drunk_ex = "Drunk!",
            k_touhou_consumed_ex = "Consumed!",
		},
        v_dictionary = {
			a_touhou_blind_divide = "/#1# Blind Size",
        },
	},
	descriptions = {
        Back = {
            b_touhou_cherry = {
				name = "Cherry Deck",
				text =  {
                    "Earn {C:touhou_cherry}Cherry{} each round",
                    "Gives {X:mult,C:white}XMult{} based",
                    "on current {C:touhou_cherry}Cherry{}",
                }
			},
            b_touhou_mystic = {
				name = "Mystic Deck",
				text =  {
                    "Gives {C:attention}Mystic{} after every hand",
                    "and round based on owned Jokers",
                    "May alter {C:chips}Chips{} and {X:mult,C:white}XMult{}",
                    "with enough {C:attention}Mystic{}",
                }
			},
        },
        Sleeve = {
            sleeve_touhou_cherry = {
				name = "Cherry Sleeve",
				text =  {
                    "Earn {C:touhou_cherry}Cherry{} each round",
                    "Gives {X:mult,C:white}XMult{} based",
                    "on current {C:touhou_cherry}Cherry{}",
                }
			},
            sleeve_touhou_cherry_alt = {
				name = "Cherry Sleeve",
				text =  {
                    "Earn {C:attention}50%{} more {C:touhou_cherry}Cherry{}",
                }
			},
            sleeve_touhou_mystic = {
				name = "Mystic Sleeve",
				text =  {
                    "Gives {C:attention}Mystic{} after every hand",
                    "and round based on owned Jokers",
                    "May alter {C:chips}Chips{} and {X:mult,C:white}XMult{} with enough {C:attention}Mystic{}",
                }
			},
            sleeve_touhou_mystic_alt = {
				name = "Mystic Sleeve",
				text =  {
                    "{C:attention}Mystic{} requirements and limits are reduced",
                }
			},
        },
        Blind = {
            bl_touhou_mansion = {
                name = "The Mansion",
                text = {
                    "All Jokers disabled",
                    "until #1# hand remaining",
                },
            },
            bl_touhou_bloom = {
                name = "The Bloom",
                text = {
                    "X#1# Blind size after",
                    "every hand played",
                },
            },
            bl_touhou_mist = {
                name = "The Mist",
                text = {
                    "Triggered cards each",
                    "give X#1# Mult",
                },
            },
            bl_touhou_fake = {
                name = "The Fake",
                text = {
                    "#1# in #2# chance to",
                    "draw an illusory card"
                },
            },
            bl_touhou_flower = {
                name = "The Flower",
                text = {
                    "First played card of",
                    "each suit are debuffed",
                },
            },
            bl_touhou_shot = {
                name = "The Shot",
                text = {
                    "Must play a strictly increasing",
                    "number of cards each hand",
                },
            },
        },
        Enhanced = {
            m_touhou_hihiirokane = {
                name = "Hihiirokane Card",
                text = {
                    "{X:mult,C:white}X#1#{} Mult when played",
                    "and scored or held in hand",
                    "Gain {C:money}$#2#{} when played and",
                    "scored or at end of round",
                },
            },
        },
		Joker = {
            j_touhou_reimu_hakurei = {
                name = "Reimu Hakurei",
                text = {
                    "Earn {C:attention}no{} interest",
                    "This Joker gains {X:mult,C:white}XMult{}",
                    "equal to {C:attention}one twenty-fifth{}",
                    "of otherwise earned interest",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{}{C:inactive} Mult){}",
                },
            },
            j_touhou_marisa_kirisame = {
                name = "Marisa Kirisame",
                text = {
                    "Held consumables each",
                    "give {X:mult,C:white}X#1#{} Mult and used",
					"consumables each give {C:money}$#2#{}",
                },
            },
            j_touhou_rumia = {
                name = "Rumia",
                text = {
                    "Played cards with",
                    "{C:spades}#2#{} suit or {C:clubs}#3#{} suit give",
                    "{C:chips}+#1#{} Chips when scored",
                },
            },
            j_touhou_daiyousei = {
                name = "Daiyousei",
                text = {
                    "{C:touhou_fairy_pink}Fairy{} {C:attention}Jokers{} each randomly",
                    "give {C:chips}+#1#{} Chips, {C:mult}+#2#{} Mult,",
                    "{X:chips,C:white}X#3#{} Chips, or {X:mult,C:white}X#4#{} Mult",
                },
            },
            j_touhou_cirno = {
                name = "Cirno",
                text = {
                    "Each played {C:attention}9{} gives {C:chips}+9{} Chips",
                    "for each {C:attention}9{} played",
                },
            },
            j_touhou_hong_meiling = {
                name = "Hong Meiling",
                text = {
                    "Each played {C:attention}7{} has a",
                    "{C:green}#1# in #2#{} chance to gain a",
                    "random {C:attention}Enhancement{}, {C:attention}Edition{},",
                    "or {C:attention}Seal{} each when scored",
                },
            },
            j_touhou_koakuma = {
                name = "Koakuma",
                text = {
                    "{C:attention}Enhanced{} cards each",
                    "give {C:mult}+#1#{} Mult when scored",
                    "{C:inactive}(Gives {C:mult}+#2#{}{C:inactive} Mult instead if{}",
                    "{C:inactive}Patchouli Knowledge is present){}",
                },
            },
            j_touhou_patchouli_knowledge = {
                name = "Patchouli Knowedge",
                text = {
                    "Hey! This wasn\'t supposed to happen!",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}???{}",
                },
            },
            j_touhou_patchouli_knowledge_sun = {
                name = "Patchouli Knowedge",
                text = {
                    "Played cards with {C:hearts}Heart{} suit",
                    "give {X:mult,C:white}X#1#{} Mult when scored",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}Sun{}",
                },
            },
            j_touhou_patchouli_knowledge_moon = {
                name = "Patchouli Knowedge",
                text = {
                    "Played cards with {C:vlubs}Club{} suit",
                    "give {C:mult}+#1#{} Mult when scored",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}Moon{}",
                },
            },
            j_touhou_patchouli_knowledge_fire = {
                name = "Patchouli Knowedge",
                text = {
                    "Upgrade the level of the",
                    "first {C:attention}discarded{} and the first",
                    "{C:attention}played{} poker hands this round",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}Fire{}",
                },
            },
            j_touhou_patchouli_knowledge_water = {
                name = "Patchouli Knowedge",
                text = {
                    "{C:attention}+#1#{} hand size,",
                    "{C:blue}+#2#{} hand this round,",
                    "{C:red}-#3#{} discard this round",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}Water{}",
                },
            },
            j_touhou_patchouli_knowledge_wood = {
                name = "Patchouli Knowedge",
                text = {
                    "Played {C:attention}non-face{} cards",
                    "give {C:chips}+#1#{} Chips",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}Wood{}",
                },
            },
            j_touhou_patchouli_knowledge_metal = {
                name = "Patchouli Knowedge",
                text = {
                    "Played {C:attention}Steel{} cards give {X:mult,C:white}X#1#{} and",
                    "Played {C:attention}Gold{} cards earn {C:money}$#2#{} when",
                    "held in hand after playing a hand",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}Metal{}",
                },
            },
            j_touhou_patchouli_knowledge_earth = {
                name = "Patchouli Knowedge",
                text = {
                    "{C:chips}+#1#{} Chips and {C:mult}+#2#{} Mult if played",
                    "hand contains a {C:attention}#3#",
                    "{C:inactive}(Changes abilities each round){}",
                    "{C:inactive}Current Phase: {}{C:attention}Earth{}",
                },
            },
            j_touhou_sakuya_izayoi = {
                name = "Sakuya Izayoi",
                text = {
                    "When {C:attention}Boss Blind{} is defeated,",
                    "prevent the ante from increasing,",
                    "skip the shop, and extinct this card",
                },
            },
            j_touhou_remilia_scarlet = {
                name = "Remilia Scarlet",
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "{C:attention}reroll boss blind{}",
                    "if played hand is your",
                    "second-most played {C:attention}poker hand{}",
                    "{C:inactive}(Currently {C:attention}#3#{}{C:inactive}){}",
                },
            },
            j_touhou_flandre_scarlet = {
                name = "Flandre Scarlet",
                text = {
                    "{C:green}#1# in #2#{} chance to destroy",
                    "each {C:attention}played{} card and card",
                    "{C:attention}held in hand{} when hand is played",
                    "Give {X:mult,C:white}X#3#{} Mult for each destroyed card",
                },
            },
            j_touhou_letty_whiterock = {
                name = "Letty Whiterock",
                text = {
                    "Gains {X:mult,C:white}X#1#{} Mult every round",
                    "Self-destructs if fire effect occurs",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
                },
            },
            j_touhou_chen = {
                name = "Chen",
                text = {
                    "Each 'cat' {C:attention}Joker{} gives {X:mult,C:white}X#1#{} Mult",
                },
            },
            j_touhou_alice_margatroid = {
                name = "Alice Margatroid",
                text = {
                    "If final score is less than",
                    "{C:attention}#1#x{} blind requirement, add",
                    "a free random {C:attention}booster pack{}",
                    "to the next shop"
                },
            },
            j_touhou_lily_white = {
                name = "Lily White",
                text = {
                    "Sell this card to create",
                    "a free {C:attention}consumable{}",
                },
            },
            j_touhou_lily_black = {
                name = "Lily Black",
                text = {
                    "Sell this card to create",
                    "a free {C:attention}tag{}",
                    "{C:inactive}(Must have room){}",
                },
            },
            j_touhou_lyrica_prismriver = {
                name = "Lyrica Prismriver",
                text = {
                    "{C:attention}Undebuff{} the first",
                    "debuffed card",
                    "played each hand"
                },
            },
            j_touhou_lunasa_prismriver = {
                name = "Lunasa Prismriver",
                text = {
                    "Subtracts {C:attention}#1#%{} of Chips or",
                    "Mult (whichever is higher)",
                    "and adds it to the other",
                },
            },
            j_touhou_merlin_prismriver = {
                name = "Merlin Prismriver",
                text = {
                    "Randomly gives anywhere from",
                    "{X:touhou_chips_mult,C:white}X#1#{} to {X:touhou_chips_mult,C:white}X#2#{} Chips and Mult",
                },
            },
            j_touhou_youmu_konpaku = {
                name = "Youmu Konpaku",
                text = {
                    "{B:1,C:white}/log#1#(Mult){} Blind size",
                    "{C:inactive}(Cannot increase Blind size){}",
                },
            },
            j_touhou_yuyuko_saigyouji = {
                name = "Yuyuko Saigyouji",
                text = {
                    "Create a {C:attention}Death{} card",
                    "at end of round",
                    "{C:inactive}(Must have room){}",
                },
            },
            j_touhou_ran_yakumo = {
                name = "Ran Yakumo",
                text = {
                    "{C:attention}+#1#{} Booster Pack size from",
                    "{C:tarot}Arcana{} and {C:spectral}Spectral{} Packs",
                },
            },
            j_touhou_yukari_yakumo = {
                name = "Yukari Yakumo",
                text = {
                    "{X:dark_edition,C:white}+#1#{} {C:attention}Straight{} gap size",
                    "{C:attention}Straights{} can wrap around",
                    "{C:inactive}(ex: {}{C:attention}4 2 A K Q{}{C:inactive}){}",
                },
            },
            j_touhou_suika_ibuki = {
                name = "Suika Ibuki",
                text = {
                    "{C:green}#1# in #2#{} chance to retrigger",
                    "each played card {C:attention}#3#{} time",
                    "Lose {C:money}$#4#{} each round",
                },
            },
            j_touhou_wriggle_nightbug = {
                name = "Wriggle Nightbug",
                text = {
                    "{C:chips}+#1#{} Chips for each",
                    "card held in hand",
                },
            },
            j_touhou_mystia_lorelei = {
                name = "Mystia Lorelei",
                text = {
                    "Played {C:attention}face down{} cards",
                    "each give {C:mult}+#1#{} Mult",
                    "First drawn card is drawn",
                    "{C:attention}face down{} each draw",
                },
            },
            j_touhou_keine_kamishirawara = {
                name = "Keine Kamishirasawa",
                text = {
                    "Hey! This wasn\'t supposed to happen!",
                },
            },
            j_touhou_keine_kamishirawara_human = {
                name = "Keine Kamishirasawa (Human)",
                text = { -- I have no clue how to add the numbers automatically as a function of the table
                    "{X:mult,C:white}X#1#{} Mult if played hand contains the",
                    "ranks of any number in the {C:attention}table{}",
                    "{C:inactive}711, 585, 507, 939, 1394, 1945{}",
                    "{C:inactive}(Aces count as 1, Rankless cards count as 0){}",
                },
            },
            j_touhou_keine_kamishirawara_hakutaku = {
                name = "Keine Kamishirasawa (Hakutaku)",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played hand contains the",
                    "ranks of any number in the {C:attention}table{}",
                    "plus an extra {X:mult,C:white}X#2#{} Mult for each",
                    "additional combination satisfied",
                    "{C:inactive,s:0.8}711, 660, 585, 148, 507, 538, 710, 712, 720, 794, 797, 840, 869,{}",
                    "{C:inactive,s:0.8}879, 901, 939, 1185, 1333, 1394, 1467, 1603, 1868, 1885, 1945{}",
                    "{C:inactive}(Aces count as 1, Rankless cards count as 0){}",
                },
            },
            j_touhou_tewi_inaba = {
                name = "Tewi Inaba",
                text = {
                    "Retrigger all played",
                    "{C:attention}Lucky{} cards {C:attention}#1#{} time",
                },
            },
            j_touhou_reisen_udongein_inaba = {
                name = "Reisen Udongein Inaba",
                text = {
                    "{C:attention}Disguise{} the {C:attention}first{} played card",
                    "as the {C:attention}second{} played card"
                },
            },
            j_touhou_eirin_yagokoro = {
                name = "Eirin Yagokoro",
                text = {
                    "At end of round, create",
                    "a random {C:planet}Planet{} card",
                    "{C:inactive}(must have room){}",
                },
            },
            j_touhou_kaguya_houraisan = {
                name = "Kaguya Houraisan",
                text = {
                    "At the end of the shop, add",
                    "{C:attention}Eternal{} to {C:attention}#1#{} random Joker, then",
                    "remove {C:attention}Eternal{} from {C:attention}#1#{} random Joker",
                },
            },
            j_touhou_fujiwara_no_mokou = {
                name = "Fujiwara no Mokou",
                text = {
                    "Returns immediately when destroyed and has",
                    "a chance of returning in the shop when sold",
                    "Gains {X:mult,C:white}X#1#{} Mult each return",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
                },
            },
            j_touhou_aya_shameimaru = {
                name = "Aya Shameimaru",
                text = {
                    "{C:mult}+#1#{} Mult for each",
                    "remaining {C:attention}hand{}",
                },
            },
            j_touhou_medicine_melancholy = {
                name = "Medicine Melancholy",
                text = {
                    "Played cards become {C:attention}Perishable{}",
                    "{C:attention}Perishable{} cards give",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                },
            },
            j_touhou_komachi_onozuka = {
                name = "Komachi Onozuka",
                text = {
                    "{C:chips}+#1#{} Chips for each difference",
                    "between the {C:attention}nominal{} values{} of the",
                    "{C:attention}highest{} and {C:attention}lowest{} scored cards",
                    "{C:inactive}({C:attention}Aces{}{C:inactive} are high){}"
                },
            },
            j_touhou_eiki_shiki_yamaxanadu = {
                name = "Eiki Shiki, Yamaxanadu",
                text = {
                    "{C:green}#1# in #2#{} chance for each scored card to gain an {C:attention}Edition{}",
                    "{C:green}#1# in #2#{} chance for each scored card to be destroyed",
                    "{C:attention}Editioned cards{} give {X:mult,C:white}X#3#{} Mult when scored",
                },
            },
            j_touhou_yin_yang_orb = {
                name = "Yin-Yang Orb",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "create a random Joker",
                    "{C:inactive}(Must have room){}",
                },
            },
            j_touhou_extermination_needles = {
                name = "Extermination Needles",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "for every {C:attention}Youkai{} Joker",
                    "that is sold or destroyed",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
                },
            },
            j_touhou_donation_box = {
                name = "Donation Box",
                text = {
                    "Earn up to {C:money}$#1#{} of unmodified interest",
                    "that would have been earned above",
                    "the interest cap at end of round",
                },
            },
            j_touhou_mini_hakkero = {
                name = "Mini Hakkero",
                text = {
                    "Each scored {C:attention}Steel{} or {C:attention}Gold{} card",
                    "in played hand becomes {C:attention}Hihiirokane{}",
                },
            },
            j_touhou_magician_broom = {
                name = "Magician Broom",
                text = {
                    "Earn an extra {C:money}$#1#{} for each hand",
                    "remaining at end of round",
                },
            },
            j_touhou_sphere_of_darkness = {
                name = "Sphere of Darkness",
                text = {
                    "{C:hearts}Hearts{} count as {C:spades}Spades{}",
                    "{C:diamonds}Diamonds{} count as {C:clubs}Clubs{}",
                },
            },
            j_touhou_frozen_frog = {
                name = "Frozen Frog",
                text = {
                    "{C:attention}Unmodified{} cards each",
                    "give {C:mult}+#1#{} Mult and",
                    "{C:chips}+#2#{} Chips when scored",
                },
            },
            j_touhou_philosophers_stone = {
                name = "Philosopher's Stone",
                text = {
                    "Randomize the {C:attention}Edition{}",
                    "of each played and scored",
                    "card with an {C:attention}Edition{}",
                },
            },
            j_touhou_silver_knives = {
                name = "Silver Knives",
                text = {
                    "{C:attention}Steel{} cards each give",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                },
            },
            j_touhou_pocket_watch = {
                name = "Pocket Watch",
                text = {
                    "If no hands left and",
                    "about to lose {C:attention}Blind{},",
                    "gain {C:blue}+#1#{} hand",
                    "{C:inactive}(Extincts in {C:attention}#2#{}{C:inactive} uses){}"
                },
            },
            j_touhou_gungnir = {
                name = "Gungnir",
                text = {
                    "{C:attention}Glass{} cards give",
                    "{X:mult,C:white}X#1#{} Mult when scored",
                    "{C:attention}Glass{} cards always",
                    "break when scored",
                },
            },
            j_touhou_laevateinn = {
                name = "Lævateinn",
                text = {
                    "{C:attention}Sell{} a random card",
                    "held in hand",
                    "at end of round",
                },
            },
            j_touhou_mountain_cat = {
                name = "Mountain Cat",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:inactive}(Randomizes at end of round){}",
                },
            },
            j_touhou_grilled_lamprey = {
                name = "Grilled Lamprey",
                text = {
                    "Earn {C:money}$#1#{} at end of round",
                    "Decreases by {C:money}$#2#{} every round",
                },
            },
            j_touhou_straw_effigy = {
                name = "Straw Effigy",
                text = {
                    "If there are multiple played and",
                    "scored {C:attention}copies{} of a played card,",
                    "destroy all but the first one",
                },
            },
            j_touhou_shanghai_doll = {
                name = "Shanghai Doll",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand is a lower hand",
                },
            },
            j_touhou_hourai_doll = {
                name = "Hourai Doll",
                text = {
                    "{C:mult}+#1#{} Mult if played",
                    "hand is a higher hand",
                },
            },
            j_touhou_netherworld_phantom = {
                name = "Netherworld Phantom",
                text = {
                    "{C:chips}+#1#{} Chips per {C:spectral}Spectral{}",
                    "card used this run",
                    "{C:inactive}(Currently {C:chips}+#2#{}{C:inactive} Chips){}",
                },
            },
            j_touhou_roukanken = {
                name = "Roukanken",
                text = {
                    "Make one non-Editioned",
                    "consumable {C:dark_edition}Negative{}",
                    "at the end of the {C:attention}shop{}",
                },
            },
            j_touhou_hakurouken = {
                name = "Hakurouken",
                text = {
                    "{C:attention}Undebuff{} Joker to the right",
                    "This Joker cannot be debuffed",
                },
            },
            j_touhou_hyperbolic_tangent = {
                name = "Hyperbolic Tangent",
                text = {
                    "When setting Blind, decrease the",
                    "{C:attention}Blind size{} based on current money",
                    "{C:inactive}(Currently {B:1,C:white}/#2#{}{C:inactive}){}",
                },
            },
            j_touhou_miniature_gap = {
                name = "Miniature Gap",
                text = {
                    "{C:dark_edition}+#1#{} Joker slot",
                },
            },
            j_touhou_portable_barrier = {
                name = "Portable Barrier",
                text = {
                    "If no discards left,",
                    "gain {C:red}+#1#{} discards",
                    "{C:inactive}(Self-destructs in {C:attention}#2#{}{C:inactive} uses){}",
                },
            },
            j_touhou_ghostly_fan = {
                name = "Ghostly Fan",
                text = {
                    "When a {C:attention}playing card{} is destroyed,",
                    "gain {C:chips}+Chips{} equal to",
                    "{C:chips}+Chips{} of destroyed card",
                    "{C:inactive}(Currently {C:chips}+#1#{}{C:inactive} Chips){}",
                },
            },
            j_touhou_cherry_blossom = {
                name = "Cherry Blossom",
                text = {
                    "Played cards give {C:attention}#1#{} times",
                    "their {C:chips}+Chips{} as {C:mult}+Mult{}",
                },
            },
            j_touhou_saigyou_ayakashi = {
                name = "Saigyou Ayakashi",
                text = {
                    "This Joker gains {X:mult,C:white}X#1#{} Mult",
                    "for each {C:attention}Editioned{} Joker",
                    "Remove {C:attention}Edition{} from each Joker",
                    "{C:inactive}(Currently {X:mult,C:white}X#2#{}{C:inactive} Mult){}",
                },
            },
            j_touhou_ibuki_gourd = {
                name = "Ibuki Gourd",
                text = {
                    "{C:chips}+#1#{} Chips",
                    "{C:chips}-#2#{} Chips for every card",
                    "played or discarded below",
                    "maximum selection size",
                },
            },
            j_touhou_lucky_carrot = {
                name = "Lucky Carrot",
                text = {
                    "Increase all {C:attention}listed{} {C:green}probabilities{}",
                    "by {C:attention}#1#%{} when bought",
                    "Decrease all {C:attention}listed{} {C:green}probabilities{}",
                    "by {C:attention}#1#%{} when sold",
                },
            },
            j_touhou_butterfly_dream_pill = {
                name = "Butterfly Dream Pill",
                text = {
                    "Copies the ability of",
                    "the leftmost {C:attention}#1#{} Jokers",
                    "for the next {C:attention}#2#{} rounds",
                },
            },
            j_touhou_butterfly_dream_pill_nightmare_type = {
                name = "Butterfly Dream Pill (Nightmare Type)",
                text = {
                    "Copies the ability of",
                    "the rightmost {C:attention}#1#{} Jokers",
                    "for the next {C:attention}#2#{} rounds",
                },
            },
            j_touhou_earth_rabbit_mochi = {
                name = "Earth Rabbit Mochi",
                text = {
                    "{C:mult}+#1#{} Mult",
                    "Decrease by the {C:attention}number{}",
                    "{C:attention}of hands{} each round",
                    "at end of round",
                    "{C:mult}+1{} Mult each hand played",
                },
            },
            j_touhou_tengu_camera = {
                name = "Tengu Camera",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips",
                    "for every unique {C:attention}Joker{} bought",
                    "{C:inactive}(Currently {C:chips}+#2#{}{C:inactive} Chips){}",
                },
            },
            j_touhou_reapers_scythe = {
                name = "Reaper's Scythe",
                text = {
                    "When a debuffed {C:attention}card{} is sold,",
                    "give its purchase price as money"
                },
            },
            j_touhou_rokumon = {
                name = "Rokumon",
                text = {
                    "{B:1,C:white}/#1#{} Blind size when sold",
                },
            },
            j_touhou_rod_of_remorse = {
                name = "Rod of Remorse",
                text = {
                    "This Joker gives {X:mult,C:white}XMult{} equal to the",
                    "base scaling of the current {C:attention}Blind{}",
                    "{C:inactive}(Currently {X:mult,C:white}X#1#{}{C:inactive} Chips){}"
                },
            },
            j_touhou_cleansed_crystal_mirror = {
                name = "Cleansed Crystal Mirror",
                text = {
                    "If the card to the {C:attention}right{} of",
                    "a played card has a {C:attention}lower{} rank,",
                    "retrigger that card once",
                },
            },
            j_touhou_ordinary_grimoire = {
                name = "Ordinary Grimoire",
                text = {
                    "This joker always acts as a",
                    "random owned {C:attention}Joker{}",
                },
            },
            j_touhou_hexagrammic_grimoire = {
                name = "Hexagrammic Grimoire",
                text = {
                    "{X:mult,C:white}X#1#{} Mult if played hand",
                    "contains at least",
                    "{C:attention}#2#{} unique {C:attention}Enhancements{}",
                },
            },
            j_touhou_grimoire_of_seven_colors = {
                name = "Grimoire of Seven Colors",
                text = {
                    "At end of round, each card held",
                    "in hand has a {C:green}#1# in #2#{} chance",
                    "to create a card based on its {C:attention}suit{}",
                    "{C:hearts,s:0.8}Hearts{}{s:0.8}: {}{C:tarot,s:0.8}Tarot{}{s:0.8}    {}{C:spades,s:0.8}Spades{}{s:0.8}: {}{C:spectral,s:0.8}Spectral{}",
                    "{C:diamonds,s:0.8}Diamonds{}{s:0.8}: {}{C:planet,s:0.8}Planet{}{s:0.8}    {}{C:clubs,s:0.8}Clubs{}{s:0.8}: {}{C:attention,s:0.8}Enhanced{}",
                },
            },
            j_touhou_dragons_jewel = {
                name = "Dragon's Jewel",
                text = {
                    "After {C:attention}#1#{} rounds,",
                    "sell this card to create",
                    "{C:attention}#2#{} random non-{C:blue}Common{} {C:attention}Jokers{}",
                },
            },
            j_touhou_buddhas_begging_bowl = {
                name = "Buddha's Begging Bowl",
                text = {
                    "Gives {C:money}$#1#{} at start of shop",
                    "if entering with {C:money}$#2#{} or less",
                },
            },
            j_touhou_fire_rats_robe = {
                name = "Fire Rat's Robe",
                text = {
                    "Return all cards in the first",
                    "{C:attention}discarded{} poker hand",
                    "each round on the next draw",
                },
            },
            j_touhou_swallows_cowrie_shell = {
                name = "Swallow's Cowrie Shell",
                text = {
                    "Accumulates half of all",
                    "{C:attention}cash out{} money earned",
                    "Gives all accumulated",
                    "money when {C:attention}sold{}",
                },
            },
            j_touhou_jeweled_branch_of_hourai = {
                name = "Jeweled Branch of Hourai",
                text = {
                    "This Joker gains {C:chips}+#1#{} Chips for",
                    "every {C:attention}Enhancement{} or {C:attention}Seal{} scored,",
                    "{C:mult}+#2#{} Mult for every {C:attention}Edition{} scored,",
                    "and {X:mult,C:white}X#3#{} for every {C:attention}Sticker{} scored",
                    "Self-destructs in {C:attention}#7#{} increases",
                    "{C:inactive}(Currently {C:chips}+#4#{}{C:inactive} Chips, {C:mult}+#5#{}{C:inactive} Mult, {X:mult,C:white}X#6#{}{C:inactive} Mult){}",
                },
            },
		},
		Spectral = {},
	},
}