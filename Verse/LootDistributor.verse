module GravityBox

// Handles distribution of loot chests throughout the cube
class LootDistributor extends creative_device:
    // Called when the device begins play
    OnBegin<override>()<suspends>:
        DistributeLoot()

    // Place loot chests in concentric rings from center outward
    DistributeLoot()<suspends>:
        loot_log := log("loot_log")
        rings := 3
        spacing :float = 300.0
        for r := 0..<rings:
            rarity := rings - r
            radius := spacing * float(r + 1)
            positions := [
                vector3{X:= radius, Y:=0.0, Z:=0.0},
                vector3{X:=-radius, Y:=0.0, Z:=0.0},
                vector3{X:=0.0, Y:= radius, Z:=0.0},
                vector3{X:=0.0, Y:=-radius, Z:=0.0},
                vector3{X:=0.0, Y:=0.0, Z:= radius},
                vector3{X:=0.0, Y:=0.0, Z:=-radius}
            ]
            for pos in positions:
                SpawnLoot(pos, rarity)
                loot_log("Spawned loot at {pos} rarity={rarity}")

    SpawnLoot(pos:vector3, rarity:int)<suspends>:
        loot_log("Spawn loot placeholder at {pos} with rarity {rarity}")

