module GravityBox

// Responsible for constructing the destructible box grid and main arena
class WorldBuilder extends creative_device:
    // Called when the device begins play
    OnBegin<override>()<suspends>:
        BuildArena()

    // Create destructible sub-cubes and keep main cube indestructible
    BuildArena()<suspends>:
        // TODO: spawn destructible cubes in a 3D grid
        // TODO: ensure main cube walls are indestructible
        pass

