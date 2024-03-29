# Palworld Mod - Permadeath

![Permadeath](logo-20x.png)

Permadeath is a mod developed to add an extra layer of challenge. In this mod, if your character dies, all your items, including equipped gear, and all five companion Pals, who accompany you in the world, will be deleted.

## Download

On Nexus Mods: <https://www.nexusmods.com/palworld/mods/309?tab=files>
On Releases: <https://github.com/Diegiwg/PermadeathMod/releases>

## Installation

1. To install, you first need UE4SS (<https://github.com/UE4SS-RE/RE-UE4SS/releases>).
2. Ensure that the **PalLib** mod (<https://www.nexusmods.com/palworld/mods/380>) is installed.
3. Copy the **'PermadeathMod'** folder into the *Mods* folder of **UE4SS**.
4. Edit the *mods.txt* file and add the line **'PermadeathMod : 1'**.
5. Open your game and be careful not to die.

## Configuration

The **PermadeathMod** mod has a configuration file (config.txt) with the following options:

1. **Enabled** - Enables or disables the mod.
2. **ClearInventory** - Enables or disables inventory clearing.
3. **ClearPals** - Enables or disables Pal clearing.
4. **DevMode** - Enables or disables developer mode.

## Changelog

### v0.0.3

In this version, the **PalLib** mod is now used to provide configuration options.

### v0.0.2-dev

In this version, a rule has been added that when your character dies, the five Pals that accompany you in the world will also be deleted.

BUG-1: The image of the Pals will continue to exist in your UI until you exit and re-enter the world or capture a new friendly Pal.

### v0.0.1-dev-1

In this version, when your character dies, all items, including equipped ones, will be deleted.

BUG-1: Equipped items appear as 'ghosts' on your character but have no practical effect on stats.

## Credits

The idea originated on Discord (Palworld Modding Community) in a post by user **Rebiosi** (<https://discord.com/channels/881638083169230928/1202048172747390996>).
