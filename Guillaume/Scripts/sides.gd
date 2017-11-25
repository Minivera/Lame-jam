extends Node2D

# Constants that defines how big and small the tunnel can be, in percentages.
const MAX_MIDDLE_SPACE = 0.80
const MIN_MIDDLE_SPACE = 0.50

# Constants that define how clode one side can be to the centrer, in percentages.
const MAX_SIDE_LEAN = 0.20

# Saves all the dots in the middle of the scene as a an array of arrays representing the actual size and division of the size
# It will build the sides paths for the actual scene rendering.
var middleDots = []

# Accumulates speed at every call of the process method until it reaches the speed global
var accumlation = 0

func _ready():
    set_process(true)

func _process(delta):
    accumlation += delta
    var speed = get_node("/root/Game").speed
    print(speed)