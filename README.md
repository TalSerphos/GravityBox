# GravityBox

GravityBox is a Verse-based Unreal Editor for Fortnite (UEFN) game module that creates a dynamic, destructible arena with shifting gravity. The project is structured around modular devices, each responsible for a core aspect of the gameplay experience.

## Project Structure

- **GravityController** (`Verse/GravityController.verse`):  
  Manages gravity shifts during the match, periodically changing the gravity direction and notifying players.

- **PlayerSpawner** (`Verse/PlayerSpawner.verse`):  
  Spawns players at the six faces of a cube and aligns them with the current gravity direction.

- **WorldBuilder** (`Verse/WorldBuilder.verse`):  
  Constructs the destructible box grid and main arena, ensuring the main cube walls are indestructible.

- **LootDistributor** (`Verse/LootDistributor.verse`):  
  Distributes loot chests throughout the cube, with rarity decreasing toward the edges.

- **GravityBox** (`Verse/GravityBox.verse`):
  Entry module referencing all game devices and orchestrating the overall game logic.
- **CubeTeleporter** (`Verse/CubeTeleporter.verse`):
  Teleports all players to a random cube at set intervals.
- **PropMirror** (`Verse/PropMirror.verse`):
  Synchronizes prop destruction and ghost states across cubes.
- **RayRestorer** (`Verse/RayRestorer.verse`):
  Player tool used to rebuild destroyed props via ghost props.
- **LootSyncer** (`Verse/LootSyncer.verse`):
  Shares loot spawner cooldowns between the six cubes.

## Gameplay Overview

Players spawn on the faces of a large cube arena. Gravity periodically shifts in different directions, forcing players to adapt their movement and strategy. The arena is destructible, with indestructible outer walls, and loot is distributed with higher rarity toward the center.
## Mirrored Cube World Update

This update introduces six identical cubic zones connected via teleportation. Each cube holds a randomized maze built from Fortnite building props. When a prop is destroyed its ghost version appears in all cubes. The `RayRestorer` weapon rebuilds these ghosts across every cube with a short cooldown.

All players are teleported to a random cube every **T** seconds by the `CubeTeleporter`. Loot spawners near the center provide higher rarity items and are linked through `LootSyncer` so only one cube spawns loot per cooldown window.
