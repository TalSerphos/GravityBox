module GravityBox

// Shares cooldowns between linked loot spawners across cubes
class LootSyncer extends creative_device:
    EdgeSpawners:array<loot_spawner> = array[]
    CenterSpawners:array<loot_spawner> = array[]
    cooldown_log := log("loot_cooldown_log")

    OnBegin<override>()<suspends>:
        # TODO: bind to spawner events
        pass

    OnLootSpawned(spawner:loot_spawner)<suspends>:
        cooldown_log("Loot spawned; triggering shared cooldown")
        # TODO: start cooldown for linked spawners
        pass
