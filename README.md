## QBCore Travel NPC

### A QBCore resource that allows players to travel between multiple locations via an NPC at LSIA. Fully compatible with ox_target.

## Features

Spawn a travel NPC at Los Santos International Airport.

Players can select destinations via ox_target interaction.

Configurable destinations, NPC models, and locations.

Fully modular and easy to expand.

## Dependencies

[QBCore Framework](https://github.com/qbcore-framework/qb-core) ***(Required)***

[ox_target](https://github.com/overextended/ox_target) ***(Required)***

[ox_lib](https://github.com/overextended/ox_lib) ***(Required)***

Make sure these resources are installed and started before this script in your server.cfg.

## Example


https://github.com/user-attachments/assets/bc73c60b-cf67-46dc-b649-6a1879daab30


## Installation

Clone or download this repository.

Place the folder in your resources directory.

Add the following to your server.cfg:

ensure qb-core
ensure ox_lib
ensure ox_target
ensure qb-travel


Start/restart your server.

## Configuration

All settings are in config.lua.

## Main Airport NPC
```lua
Config.NPC = {
    model = "s_m_m_pilot_01",          -- NPC ped model
    coords = vector4(-1037.5, -2738.7, 20.1693, 328.0), -- LSIA position
    scenario = "WORLD_HUMAN_CLIPBOARD" -- NPC idle animation
}
```
## Travel Destinations
```lua
Config.Locations = {
    ["Sandy Shores"] = vector4(1747.0, 3269.7, 41.1, 105.0),
    ["Paleto Bay"] = vector4(-132.8, 6356.9, 31.5, 45.0),
}

```

> coords – Location where the player will teleport.

> returnNpc.enabled – Spawn a return NPC at this location.

> returnNpc.model – Ped model for the return NPC.

> returnNpc.coords – Location of the return NPC.

> returnNpc.scenario – Idle animation for the return NPC.

# You can add or remove destinations as needed.

# Usage

Approach the travel NPC at LSIA.

Interact with them via ox_target.

Select your destination from the menu.

The player will fade out, and then appear at the chosen location.

## Notes

Downtown Vinewood was the first one I added whilst making this to make sure it worked before doing Sandy or Paleto and will not be present upon download (as is obvious with the code snippets above!

You can adjust travel time by changing the Wait(3000) duration in client.lua.
