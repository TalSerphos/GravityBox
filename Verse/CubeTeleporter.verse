module GravityBox

// Teleports all players to a random cube every fixed interval
class CubeTeleporter extends creative_device:
    TeleportInterval:float = 30.0
    CubeAnchors:array<transform> = array[]
    teleport_log := log("teleport_log")

    OnBegin<override>()<suspends>:
        spawn{TeleportLoop()}

    TeleportLoop()<suspends>:
        loop:
            Sleep(TeleportInterval)
            if CubeAnchors.length > 0:
                idx := RandomInt(0, CubeAnchors.length - 1)
                TeleportAll(idx)

    TeleportAll(idx:int)<suspends>:
        teleport_log("Teleporting players to cube {idx}")
        players := GetPlayers()
        for p in players:
            TeleportPlayer(p, idx)

    TeleportPlayer(p:player, idx:int)<suspends>:
        # TODO: compute new transform relative to cube anchor
        pass
