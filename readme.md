Discord : NakreS#8888

Follow what's new by joining my Discord server : https://discord.gg/dqVdxm589c

You can do all the configurations in Config.lua

For those who do not use money as an item, there is a configuration in server.lua, for this it will be enough to use the line with addaccountmoney instead of addinventoryitem
server>main.lua and search for this code and comment first one if you don't use money as item and if you use money as item comment second one 

   -- xPlayer.addInventoryItem("cash", money) -- If you are using money as item, use this
    xPlayer.addAccountMoney('money', money) -- If in account use this

Dependencies : bt-target , mhacking , ESX  

!!!!!!!!!!!!!!!!!!!Unauthorized distribution is strictly prohibited.!!!!!!!!!!!!!!!!!!!!
