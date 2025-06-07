module GravityBox

// Entry module referencing all game devices and orchestrating the game
class GravityBoxGame extends creative_device:
    World:WorldBuilder = WorldBuilder{}
    Teleporter:CubeTeleporter = CubeTeleporter{}
    Mirror:PropMirror = PropMirror{}
    RayGun:RayRestorer = RayRestorer{}
    Loot:LootSyncer = LootSyncer{}

    OnBegin<override>()<suspends>:
        # Devices initialize themselves on begin
        pass
