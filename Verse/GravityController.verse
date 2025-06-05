module GravityBox

// Device responsible for managing gravity shifts during the match
class GravityController extends creative_device:
    // Minimum seconds between gravity changes
    GravityIntervalMin:float = 10.0
    // Maximum seconds between gravity changes
    GravityIntervalMax:float = 20.0

    // Current gravity direction
    var CurrentGravity:vector3 = vector3{X:=0.0, Y:=0.0, Z:=-1.0}

    // Log category for debugging gravity
    gravity_log := log("gravity_log")

    // Called when the device is spawned at match start
    OnBegin<override>()<suspends>:
        SetGravity(CurrentGravity)
        gravity_log("Initial gravity: {CurrentGravity}")
        spawn{ManageGravity()}

    // Main loop that changes gravity periodically
    ManageGravity()<suspends>:
        loop:
            Sleep(RandomFloat(GravityIntervalMin, GravityIntervalMax))
            NewDir := PickRandomGravity()
            CurrentGravity := NewDir
            SetGravity(NewDir)
            BroadcastGravity(NewDir)
            ReorientPlayers(NewDir)
            gravity_log("Gravity changed to {NewDir}")

    // Pick a random axis-aligned direction
    PickRandomGravity():vector3=
        dirs := array[
            vector3{X:=1.0, Y:=0.0, Z:=0.0},
            vector3{X:=-1.0, Y:=0.0, Z:=0.0},
            vector3{X:=0.0, Y:=1.0, Z:=0.0},
            vector3{X:=0.0, Y:=-1.0, Z:=0.0},
            vector3{X:=0.0, Y:=0.0, Z:=1.0},
            vector3{X:=0.0, Y:=0.0, Z:=-1.0}
        ]
        return dirs[RandomInt(0, dirs.length - 1)]

    // Apply the gravity vector to the world (placeholder)
    SetGravity(dir:vector3):void=
        // TODO: implement actual world gravity change
        pass

    // Send the gravity vector to all players (placeholder)
    BroadcastGravity(dir:vector3):void=
        // TODO: broadcast to players via gameplay message or replication
        pass

    // Adjust each player's orientation after gravity change (placeholder)
    ReorientPlayers(dir:vector3):void=
        // TODO: rotate players to new "down" direction
        pass

