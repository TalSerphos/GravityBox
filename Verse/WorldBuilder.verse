module GravityBox

// Builds the six gameplay cubes and their internal structures
class WorldBuilder extends creative_device:
    world_log := log("world_builder_log")
    CubeSpacing:float = 2000.0
    CubeNames:array<string> = array[
        "Down",
        "Front",
        "Back",
        "Up",
        "Left",
        "Right"
    ]
    CubeOffsetMap:map<string,vector3> = map{
        "Front" := vector3{X:=0.0, Y:=CubeSpacing, Z:=0.0},
        "Back" := vector3{X:=0.0, Y:=-CubeSpacing, Z:=0.0},
        "Up" := vector3{X:=0.0, Y:=0.0, Z:=CubeSpacing},
        "Down" := vector3{X:=0.0, Y:=0.0, Z:=-CubeSpacing},
        "Left" := vector3{X:=-CubeSpacing, Y:=0.0, Z:=0.0},
        "Right" := vector3{X:=CubeSpacing, Y:=0.0, Z:=0.0}
    }
    CubeRotationMap:map<string,rotation> = map{
        "Down" := rotation{Pitch:=0.0, Yaw:=0.0, Roll:=0.0},
        "Up" := rotation{Pitch:=180.0, Yaw:=0.0, Roll:=0.0},
        "Left" := rotation{Pitch:=0.0, Yaw:=0.0, Roll:=90.0},
        "Right" := rotation{Pitch:=0.0, Yaw:=0.0, Roll:=-90.0},
        "Front" := rotation{Pitch:=90.0, Yaw:=0.0, Roll:=0.0},
        "Back" := rotation{Pitch:=-90.0, Yaw:=0.0, Roll:=0.0}
    }
    FaceOffsetMap:map<string,vector3> = map{
        "Front" := vector3{X:=0.0, Y:=CubeSpacing/2.0, Z:=0.0},
        "Back" := vector3{X:=0.0, Y:=-CubeSpacing/2.0, Z:=0.0},
        "Up" := vector3{X:=0.0, Y:=0.0, Z:=CubeSpacing/2.0},
        "Down" := vector3{X:=0.0, Y:=0.0, Z:=-CubeSpacing/2.0},
        "Left" := vector3{X:=-CubeSpacing/2.0, Y:=0.0, Z:=0.0},
        "Right" := vector3{X:=CubeSpacing/2.0, Y:=0.0, Z:=0.0}
    }
    WallMaterial:string = "Wood"

    OnBegin<override>()<suspends>:
        BuildWorld()

    BuildWorld()<suspends>:
        origin := CubeOffsetMap["Down"]
        BuildBaseCube(origin)
        world_log("Six cubes built")

    # Spawns the base structure in the Down cube and records prop transforms
    BuildBaseCube(origin:vector3)<suspends>:
        world_log("Building base cube at {origin}")
        Props:map<string,transform> = map{}
        id:int = 0
        for face in CubeNames:
            BuildFaceBox(face, origin, Props, &id)
        # Mirror props to the other cubes
        for cube in CubeNames:
            if cube != "Down":
                MirrorProps(Props, "Down", cube)

    BuildFaceBox(face:string, origin:vector3, props:map<string,transform>, id:&int)<suspends>:
        tile:float = 500.0
        base := origin + FaceOffsetMap[face]
        # four sides of the box
        for i := -1..1:
            local := vector3{X:=tile*float(i), Y:=tile, Z:=0.0}
            SpawnFaceWall(face, base, local, rotation{}, props, id)
            local2 := vector3{X:=tile*float(i), Y:=-tile, Z:=0.0}
            SpawnFaceWall(face, base, local2, rotation{}, props, id)
            local3 := vector3{X:=tile, Y:=tile*float(i), Z:=0.0}
            SpawnFaceWall(face, base, local3, rotation{Yaw:=90.0}, props, id)
            local4 := vector3{X:=-tile, Y:=tile*float(i), Z:=0.0}
            SpawnFaceWall(face, base, local4, rotation{Yaw:=90.0}, props, id)
        # roof
        for x := -1..1:
            for y := -1..1:
                local := vector3{X:=tile*float(x), Y:=tile*float(y), Z:=tile}
                SpawnFaceWall(face, base, local, rotation{Pitch:=90.0}, props, id)
        # diagonals
        for i := -1..1:
            for step := 1..2:
                local := vector3{X:=tile*float(i), Y:=tile + tile*float(step), Z:=tile*float(step)}
                SpawnFaceWall(face, base, local, rotation{Pitch:=45.0}, props, id)
                local2 := vector3{X:=tile*float(i), Y:=-tile - tile*float(step), Z:=tile*float(step)}
                SpawnFaceWall(face, base, local2, rotation{Pitch:=45.0, Yaw:=180.0}, props, id)
                local3 := vector3{X:=tile + tile*float(step), Y:=tile*float(i), Z:=tile*float(step)}
                SpawnFaceWall(face, base, local3, rotation{Pitch:=45.0, Yaw:=90.0}, props, id)
                local4 := vector3{X:=-tile - tile*float(step), Y:=tile*float(i), Z:=tile*float(step)}
                SpawnFaceWall(face, base, local4, rotation{Pitch:=45.0, Yaw:=-90.0}, props, id)

    SpawnFaceWall(face:string, base:vector3, local:vector3, rot:rotation, props:map<string,transform>, id:&int)<suspends>:
        world := base + RotateVector(local, "Up", face)
        r := RotateRotation(rot, "Up", face)
        t := transform{Translation:=world, Rotation:=r}
        wall_id := "wall_{id}"
        props[wall_id] := t
        SpawnWall(wall_id, t)
        id += 1

    # Applies rotation and translation of all props from cube1 to cube2
    MirrorProps(props:map<string,transform>, cube1:string, cube2:string)<suspends>:
        for id, p in props:
            (loc, rot) := RT(p.Translation, p.Rotation, cube1, cube2)
            t := transform{Translation:=loc, Rotation:=rot}
            SpawnWall(id, t)

    RT(loc:vector3, orient:rotation, cube1:string, cube2:string):(vector3, rotation)=
        down_pos := ToDown(loc - CubeOffsetMap[cube1], cube1)
        down_rot := ToDownRotation(orient, cube1)
        rotated_pos := FromDown(down_pos, cube2)
        rotated_rot := FromDownRotation(down_rot, cube2)
        new_loc := rotated_pos + CubeOffsetMap[cube2]
        return (new_loc, rotated_rot)

    ToDown(v:vector3, cube:string):vector3=
        switch cube:
            case "Down":
                return v
            case "Up":
                return vector3{X:=v.X, Y:=v.Y, Z:=-v.Z}
            case "Left":
                return vector3{X:=-v.Z, Y:=v.Y, Z:=v.X}
            case "Right":
                return vector3{X:=v.Z, Y:=v.Y, Z:=-v.X}
            case "Front":
                return vector3{X:=v.X, Y:=v.Z, Z:=-v.Y}
            case "Back":
                return vector3{X:=v.X, Y:=-v.Z, Z:=v.Y}
            default:
                return v

    FromDown(v:vector3, cube:string):vector3=
        switch cube:
            case "Down":
                return v
            case "Up":
                return vector3{X:=v.X, Y:=v.Y, Z:=-v.Z}
            case "Left":
                return vector3{X:=v.Z, Y:=v.Y, Z:=-v.X}
            case "Right":
                return vector3{X:=-v.Z, Y:=v.Y, Z:=v.X}
            case "Front":
                return vector3{X:=v.X, Y:=-v.Z, Z:=v.Y}
            case "Back":
                return vector3{X:=v.X, Y:=v.Z, Z:=-v.Y}
            default:
                return v

    ToDownRotation(r:rotation, cube:string):rotation=
        base := CubeRotationMap[cube]
        return rotation{Pitch:=r.Pitch - base.Pitch, Yaw:=r.Yaw - base.Yaw, Roll:=r.Roll - base.Roll}

    FromDownRotation(r:rotation, cube:string):rotation=
        base := CubeRotationMap[cube]
        return rotation{Pitch:=r.Pitch + base.Pitch, Yaw:=r.Yaw + base.Yaw, Roll:=r.Roll + base.Roll}

    RotateVector(v:vector3, from_face:string, to_face:string):vector3=
        return FromDown(ToDown(v, from_face), to_face)

    RotateRotation(r:rotation, from_face:string, to_face:string):rotation=
        return FromDownRotation(ToDownRotation(r, from_face), to_face)

    SpawnWall(id:string, t:transform)<suspends>:
        world_log("Spawn wall {id} at {t.Translation} rot={t.Rotation}")

    PickRandomMaterial():string=
        return WallMaterial
