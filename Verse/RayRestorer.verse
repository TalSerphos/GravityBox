module GravityBox

// Custom weapon used to rebuild ghost props across all cubes
class RayRestorer extends creative_device:
    Cooldown:float = 5.0
    LastUse:map<player,float> = map{}
    ray_log := log("rayrestorer_log")

    OnBegin<override>()<suspends>:
        # TODO: grant weapon to players
        pass

    OnRayFired(p:player, hit:hit_result)<suspends>:
        # TODO: check cooldown and whether hit a ghost prop
        # PropMirror.RestoreProp should be called when appropriate
        pass
