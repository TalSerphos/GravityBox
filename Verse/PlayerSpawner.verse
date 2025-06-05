module GravityBox

// Device that spawns players at the six faces of the cube
class PlayerSpawner extends creative_device:
    // List of transforms for each spawn location around the cube
    SpawnPoints:array<transform> = array[]

    // Called when the device is spawned
    OnBegin<override>()<suspends>:
        spawn{SpawnAllPlayers()}

    // Spawn each player at a predefined face and align them with current gravity
    SpawnAllPlayers()<suspends>:
        players := GetPlaysers()
        for i := 0..<(min(players.length, SpawnPoints.length)):
            p := players[i]
            SpawnPlayer(p, SpawnPoints[i])
            AlignToGravity(p, GravityController.CurrentGravity)

    // Spawn player at given transform (placeholder)
    SpawnPlayer(p:player, t:transform)<suspends>:
        # TODO: implement actual spawn logic
        pass

    // Align a player to match the current "down" direction (placeholder)
    AlignToGravity(p:player, gravity:vector3):void=
        # TODO: rotate player to face gravity direction
        pass

