module GravityBox

// Responsible for constructing the destructible box grid and main arena
class WorldBuilder extends creative_device:
    world_log := log("world_builder_log")
    WallMaterials:array<string> = array[
        "Wood",
        "Metal",
        "Stone"
    ]
    // Called when the device begins play
    OnBegin<override>()<suspends>:
        BuildArena()

    // Create destructible sub-cubes and keep main cube indestructible
    BuildArena()<suspends>:
        gridSize := 5
        spacing :float = 100.0
        offset :float = -((gridSize - 1) * spacing) / 2.0

        for x := 0..<gridSize:
            for y := 0..<gridSize:
                for z := 0..<gridSize:
                    loc := vector3{X:=offset + float(x) * spacing,
                                    Y:=offset + float(y) * spacing,
                                    Z:=offset + float(z) * spacing}
                    destructible := x != 0 && x != gridSize - 1 &&
                                    y != 0 && y != gridSize - 1 &&
                                    z != 0 && z != gridSize - 1
                    mat := PickRandomMaterial()
                    SpawnCube(loc, destructible, mat)
        world_log("Arena built")

    // Helper to spawn a cube with optional destructibility
    SpawnCube(loc:vector3, destructible:logic, material:string)<suspends>:
        world_log(
            "Spawn cube at {loc} destructible={destructible} material={material}"
        )

    PickRandomMaterial():string=
        return WallMaterials[RandomInt(0, WallMaterials.length - 1)]

