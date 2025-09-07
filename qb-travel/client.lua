local QBCore = exports['qb-core']:GetCoreObject()

-- Spawn the NPC at airport
CreateThread(function()
    local npc = Config.NPC
    RequestModel(GetHashKey(npc.model))
    while not HasModelLoaded(GetHashKey(npc.model)) do
        Wait(0)
    end

    local ped = CreatePed(4, GetHashKey(npc.model), npc.coords.x, npc.coords.y, npc.coords.z - 1, npc.coords.w, false, true)
    SetEntityAsMissionEntity(ped, true, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)

    if npc.scenario then
        TaskStartScenarioInPlace(ped, npc.scenario, 0, true)
    end

    -- OX TARGET
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'travel_npc',
            label = '✈️ Travel',
            icon = 'fa-solid fa-plane',
            distance = 2.0,
            onSelect = function()
                OpenTravelMenu()
            end
        }
    })
end)

-- Travel Menu
function OpenTravelMenu()
    local menu = {
        {
            title = "✈️ Choose Destination",
            description = "Select where you want to fly",
            disabled = true
        }
    }

    for name, coords in pairs(Config.Locations) do
        menu[#menu+1] = {
            title = name,
            description = "Travel to " .. name,
            event = "qb-travel:client:goToLocation",
            args = {
                coords = coords,
                name = name
            }
        }
    end

    menu[#menu+1] = {
        title = "⬅️ Cancel",
        event = ""
    }

    lib.registerContext({
        id = 'travel_menu',
        title = 'Flight Destinations',
        options = menu
    })
    lib.showContext('travel_menu')
end

-- Teleport with cutscene
RegisterNetEvent("qb-travel:client:goToLocation", function(data)
    DoTravelCutscene(data.coords, data.name)
end)

-- Travel cutscene function
function DoTravelCutscene(coords, name)
    local player = PlayerPedId()

    -- Fade out
    DoScreenFadeOut(1000)
    Wait(1500)

    -- Load cutscene cam
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(cam, -1045.5, -2750.0, 22.0) -- near LSIA runway
    PointCamAtCoord(cam, -1336.0, -3040.0, 13.0) -- pan direction
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1500, true, true)

    -- Airplane sound
    RequestAmbientAudioBank("SCRIPT\\\\FBI_HEIST_H5_ANIM_GETAWAY_HELI", false)
    PlaySoundFrontend(-1, "TakeOff", "MP_CEILING_FAN_SOUNDS", true)

    -- Small wait to simulate takeoff
    Wait(5000)

    -- Teleport while "in flight"
    SetEntityCoords(player, coords.x, coords.y, coords.z, false, false, false, true)
    SetEntityHeading(player, coords.w)

    -- Camera reset
    RenderScriptCams(false, true, 1500, true, true)
    DestroyCam(cam, false)

    Wait(1000)
    DoScreenFadeIn(1500)

    QBCore.Functions.Notify("You have arrived in " .. name, "success")
end
