module GravityBox

// Synchronizes destruction and restoration of props across all cubes
class PropMirror extends creative_device:
    MirrorMap:map<string,array<creative_prop>> = map{}
    ghost_suffix := "Ghost_"
    mirror_log := log("mirror_log")

    OnBegin<override>()<suspends>:
        BuildMirrorMap()

    BuildMirrorMap()<suspends>:
        # TODO: populate MirrorMap by scanning tags on props
        pass

    HandlePropDestroyed(id:string)<suspends>:
        mirror_log("Prop {id} destroyed; enabling ghosts")
        # TODO: disable props and enable ghosts in all cubes
        pass

    RestoreProp(id:string)<suspends>:
        mirror_log("Restoring prop {id}")
        # TODO: enable props and disable ghosts in all cubes
        pass
