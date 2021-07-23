--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------
Config = {}

Config.dclog = true --true if you want it to send logs

Config.weebhok = "https://discord.com/api/webhooks/867886053968183296/DWk2LuQHNqW9jSOMskLPdFvhscbLhDd-l-54ABVr2XqIhuwQxV4NQIiKQlPLx0EpsdpA"

Config.alertrepait = 5 -- How many times will it repeat in case of notification to the police?

Config.diff = 3 --  The number of letters in the hacking process becomes more difficult as the number decreases

Config.time = 15 -- The less time it takes to hack, the harder it gets

Config.hackstartalert = 0 -- Percentage of notification to the police when hacking starts 

Config.alert = 60 -- Percentage of police reporting on 2nd transaction after 1 failed hack

Config.alert2 = 80 -- Percentage of reporting to the police on 3rd attempt after 2nd unsuccessful hacking

Config.removebliptime = 35000 -- How many seconds the bank blip will appear on the map

Config.price = { --The minimum and maximum amount of money that can be won at the end of the robbery
    min = 150000,
    max = 250000
}
Config.itemname = "hackertablet" --Name of item required for hacking

Config.atmcoords = { -- You can add new ATMs in the same way as atm coordinates that will be randomly given to hack.
    vector3(145.8, -1035.52, 29.36),
    vector3(-537.64, -855.0, 29.44),
    vector3(89.64, 2.76, 68.48), 
}

----------- Text -----------------

Config.alerttext = "Someone is stealing an ATM."
Config.gpsmarker = "Location marked on gps"
Config.erroritem = "You need a tablet for hacking"
--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------