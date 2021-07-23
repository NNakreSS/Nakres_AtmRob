ESX = nil
--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------
local robcoords
local hackrob = 3
local ped = PlayerPedId()

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

local display = false

Citizen.CreateThread(function ()
      exports['bt-target']:AddCircleZone("robsstart", vector3(1271.88, -1711.12, 54.76), 0.5, {
        name="robsstart",
        heading=0.0,
        debugPoly=false,
        minZ=13.6,
        maxZ=14.3
      }, {
        options = {
        {
        event = "nakres:atmrobstart",
        icon = "fas fa-laptop-code",
        label = "Access weak software atm coordinate",
        },
      },
        job = {"all"},
        distance = 1.5
      })
end)


RegisterNetEvent("nakres:atmrobstart")
RegisterNetEvent("nakres:atmrobhack")

AddEventHandler("nakres:atmrobstart",function ()
    FreezeEntityPosition(PlayerPedId(),true)
    startAnim()
    Citizen.Wait(3000)
    SetDisplay(true)
end)

AddEventHandler("nakres:atmrobhack",function ()
  ESX.TriggerServerCallback('nakres:itemcheck', function(boolean)
    if boolean then
    local random = math.random(0,100)
    if hackrob > 0 then
    ped = PlayerPedId()
    TriggerEvent("mythic_progbar:client:progress", {
      name = "robhacking",
      duration = 5000,
      label = "You start the robbery",
      useWhileDead = false,
      canCancel = true,
      controlDisables = {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      },
  })

  FreezeEntityPosition(ped, true)
  TaskStartScenarioAtPosition(ped, "WORLD_HUMAN_STAND_MOBILE", GetEntityCoords(ped), GetEntityHeading(ped), 0, 0, 1)
  Citizen.Wait(5000)
    TriggerEvent("mhacking:show")
    TriggerEvent("mhacking:start",Config.diff,Config.time,robatm)
    if random <= Config.hackstartalert  then
        TriggerServerEvent("Alert", GetEntityCoords(ped))
    end
      else
        msg("ATM BLOCKED")
          TriggerServerEvent("Alert", GetEntityCoords(ped))
      end
  else
    msg(Config.erroritem)
  end
end, Config.itemname)
end)

function robatm(succes)
  ped = PlayerPedId()
  local random = math.random(0,100) 
  if succes then
    local money = math.random(Config.price.min,Config.price.max)
    TriggerEvent("mhacking:hide")
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    TriggerServerEvent('nakres:givemoney',money)
    msg("Robbery Successful Earnings".." "..money)
    exports['bt-target']:RemoveZone("atmrob")
  else
    TriggerEvent("mhacking:hide")
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    hackrob = hackrob - 1
    if hackrob < 3  then
        if random <= Config.alert then
             TriggerServerEvent("Alert", GetEntityCoords(ped))
        end
    elseif hackrob < 2 then
      if random <= Config.alert2 then
          TriggerServerEvent("Alert", GetEntityCoords(ped))
     end
    end
  end
end
--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------
RegisterNetEvent("Alert")
AddEventHandler("Alert",function (coords)
    local jobname = ESX.GetPlayerData().job.name
    if jobname == "police" then
        msg(Config.alerttext)
        local blip = AddBlipForCoord(coords)
        SetBlipSprite(blip, 161)
        SetBlipScale(blip, 2.0)
        SetBlipColour(blip, 1)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Atm Rob Alert")
        EndTextCommandSetBlipName(blip)
        PulseBlip(blip)
            Citizen.CreateThreadNow(function()
                local again = 0
                repeat
                    Citizen.Wait(4500)
                    msg(Config.alerttext)
                    again = again + 1
                until again == Config.alertrepait
                RemoveBlip(blip)
            end)
    end
end)

function startAnim()
	Citizen.CreateThread(function()
    while not HasAnimDictLoaded("anim@heists@prison_heiststation@cop_reactions") do
      RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
      Citizen.Wait(10)
      end
        RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
        TaskPlayAnim(PlayerPedId(), 'anim@heists@prison_heiststation@cop_reactions', 'cop_b_idle', 8.0, -8, 10.0, 49, 0, 0, 0, 0)
    end)
end

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterNUICallback("exit", function(data)
  ped = PlayerPedId()
    SetDisplay(false)
    FreezeEntityPosition(ped,false)
    Citizen.Wait(1000)
    ClearPedTasks(ped)
end)

RegisterNUICallback("code", function(data)
    ped = PlayerPedId()
    SetDisplay(false)
    FreezeEntityPosition(ped,false)
    Citizen.Wait(1000)
    ClearPedTasks(ped)
    -----------------
    robcoords = Config.atmcoords[math.random(1,#Config.atmcoords)]
    AddBlipAtm()
    msg(Config.gpsmarker)

    exports['bt-target']:AddCircleZone("atmrob", robcoords, 0.5, {
      name="atmrob",
      heading=0.0,
      debugPoly=false,
      minZ=13.6,
      maxZ=14.3
    }, {
      options = {
      {
      event = "nakres:atmrobhack",
      icon = "fas fa-laptop-code",
      label = "Access the system",
      },
    },
      job = {"all"},
      distance = 1.5
    })
    Citizen.Wait(Config.removebliptime)
    RemoveBlip(atmblip)
end)
--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------
function AddBlipAtm()
  atmblip = AddBlipForCoord(robcoords)
  SetBlipSprite(atmblip, 500)
  SetBlipDisplay(atmblip, 4)
  SetBlipScale(atmblip, 0.7)
  SetBlipColour(atmblip, 4)
  SetBlipAsShortRange(atmblip, true)
  BeginTextCommandSetBlipName("STRING")
  AddTextComponentString("ROB ATM")
  EndTextCommandSetBlipName(atmblip)
end

RegisterNUICallback("error", function(data)
  ped = PlayerPedId()
  msg(data.error)
  SetDisplay(false)
  FreezeEntityPosition(ped,false)
  Citizen.Wait(1000)
  ClearPedTasks(ped)
end)

Citizen.CreateThread(function()
  while display do
      Citizen.Wait(0)
      DisableControlAction(0, 1, display) -- LookLeftRight
      DisableControlAction(0, 2, display) -- LookUpDown
      DisableControlAction(0, 142, display) -- MeleeAttackAlternate
      DisableControlAction(0, 18, display) -- Enter
      DisableControlAction(0, 322, display) -- ESC
      DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
end
end)

function msg(str)
ESX.ShowNotification(str)
end
--.__   __.      ___       __  ___ .______       _______     _______. -
--|  \ |  |     /   \     |  |/  / |   _  \     |   ____|   /       | -
--|   \|  |    /  ^  \    |  '  /  |  |_)  |    |  |__     |   (----` -
--|  . `  |   /  /_\  \   |    <   |      /     |   __|     \   \     -
--|  |\   |  /  _____  \  |  .  \  |  |\  \----.|  |____.----)   |    -
--|__| \__| /__/     \__\ |__|\__\ | _| `._____||_______|_______/     -                                                        
--                                                                    - 
-----------------------------------------------------------------------