ESX = nil
--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("nakres:givemoney")
AddEventHandler("nakres:givemoney",function (money)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem("cash", money) -- If you are using money as item, use this
    -- xPlayer.addAccountMoney('money', money) -- If in account use this
    if Config.dclog then    
        dcloggonder(xPlayer, "Robbed a bank , Total earnings : ".." "..money.." ".."$")
    end
end)

ESX.RegisterServerCallback('nakres:itemcheck', function(source, cb , itemname)
    local xPlayer = ESX.GetPlayerFromId(source)
    local count = xPlayer.getInventoryItem(itemname).count
    if count >= 1  then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent("Alert")
AddEventHandler("Alert", function(coords)
    TriggerClientEvent("Alert", -1, coords)
end)

----------- Discord Log-------------------
function dcloggonder(xPlayer, text)
    local playerName = Sanitize(xPlayer.getName())
    local discord_webhook = Config.weebhok
    if discord_webhook == '' then
      return
    end
    local headers = {
      ['Content-Type'] = 'application/json'
    }
    local data = {
      ["username"] = "NakreS-ATMROB",
      ["avatar_url"] = "https://media.discordapp.net/attachments/867885957528027196/867887021027491880/logo2.png?width=1246&height=701",
      ["embeds"] = {{
        ["author"] = {
          ["name"] = playerName .. ' - ' .. xPlayer.identifier
        },
        ["color"] = 1942002,
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
      }}
    }
    data['embeds'][1]['description'] = text
    PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end
--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------
function Sanitize(str)
    local replacements = {
        ['&' ] = '&amp;',
        ['<' ] = '&lt;',
        ['>' ] = '&gt;',
        ['\n'] = '<br/>'
    }
    return str
        :gsub('[&<>\n]', replacements)
        :gsub(' +', function(s)
            return ' '..('&nbsp;'):rep(#s-1)
        end)
end