module GravityBox

// Builds the six gameplay cubes and their internal structures
class WorldBuilder extends creative_device:
    world_log := log("world_builder_log")
    CubeSpacing:float = 2000.0
    WallMaterials:array<string> = array[
        "Wood",
        "Metal",
        "Stone"
    ]

    OnBegin<override>()<suspends>:
        BuildWorld()

    BuildWorld()<suspends>:
        CubeOffsets := [
            // Offset cubes along each axis; include one below the origin
            vector3{X:=0.0, Y:=0.0, Z:=-CubeSpacing},
            vector3{X:=CubeSpacing, Y:=0.0, Z:=0.0},
            vector3{X:=-CubeSpacing, Y:=0.0, Z:=0.0},
            vector3{X:=0.0, Y:=CubeSpacing, Z:=0.0},
            vector3{X:=0.0, Y:=-CubeSpacing, Z:=0.0},
            vector3{X:=0.0, Y:=0.0, Z:=CubeSpacing}
        ]
        for i := 0..<CubeOffsets.length:
            BuildCube(i, CubeOffsets[i])
        world_log("Six cubes built")

    BuildCube(index:int, origin:vector3)<suspends>:
        world_log("Build cube {index} at {origin}")
        # TODO: spawn internal walls, floors and stairs with randomized materials
        # Props should be tagged for mirroring
        pass

    PickRandomMaterial():string=
        return WallMaterials[RandomInt(0, WallMaterials.length - 1)]
