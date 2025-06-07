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

## Gameplay Overview

Players spawn on the faces of a large cube arena. Gravity periodically shifts in different directions, forcing players to adapt their movement and strategy. The arena is destructible, with indestructible outer walls, and loot is distributed with higher rarity toward the center.