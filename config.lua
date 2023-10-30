Config = {}

Config.Marker = vec3(128.967041, -1054.101074, 22.944336)
Config.Cook = vec3(143.169235, -1056.553833, 22.944336)

Config.Job = 'police'

Config.cookingTime = 5000 -- cook time in miliseconds

Config.modelPed = "a_m_m_prolhost_01" -- ped what spawn
Config.chefModelPed = "s_m_m_linecook" -- chef ped

Config.Npc = vector3(129.309891, -1052.940674, 22.944336) -- Coords for NPC , 
Config.NpcHeading = 158.740158 -- Heading of NPC

Config.chefNpc = vector3(149.2682, -1055.1135, 22.9602)
Config.chefNpcHeading = 84.8583

--------------------
----RAGNE OF PAY----
--------------------

Config.Pay1 = 20
Config.Pay2 = 40

Config.recipes = {
    [1] = { 
        name = "HotDog", 
        item = "hotdog",
        price = 5, 
        ingredients = {
            ["roll"] = 1,
            ["sausage"] = 1,
            -- další suroviny
        }
    },
    [2] = { 
        name = "Hamburger", 
        item = "hamburger",
        price = 8, 
        ingredients = {
            ["bun"] = 2,
            ["cucumber"] = 1,
            ["beef"] = 1,
            ["tomato"] = 1,
            -- další suroviny
        }
    },
    [3] = { 
        name = "Pizza", 
        item =  "pizza",
        price = 6, 
        ingredients = {
            ["dought"] = 1,
            ["tomato"] = 3,
            ["cheese"] = 1,
            ["ham"] = 2,
            ["mozzarela"] = 1,
        }
    },
    [4] = { 
        name = "Tortilla", 
        item =  "tortilla",
        price = 6, 
        ingredients = {
            ["pita"] = 1,
            ["tomato"] = 3,
            ["salad"] = 2,
            ["onion"] = 2,
            ["sauce"] = 1,
        }
    }
    -- more recepies
}


Config.Orders = {
    [1] = { text = "HotDog", sc = "hotdog" },
    [2] = { text = "Hamburger",  sc = "hamburger" },
    [3] = { text = "Pizza",  sc = "pizza" },
    [4] = { text = "Tortilla", sc = "tortilla"},
}
