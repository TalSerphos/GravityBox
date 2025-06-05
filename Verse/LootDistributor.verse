module GravityBox

// Handles distribution of loot chests throughout the cube
class LootDistributor extends creative_device:
    // Called when the device begins play
    OnBegin<override>()<suspends>:
        DistributeLoot()

    // Place loot chests in concentric rings from center outward
    DistributeLoot()<suspends>:
        // TODO: spawn loot with rarity decreasing toward the edges
        pass

