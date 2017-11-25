extends Node2D

# Constants that defines how big and small the tunnel can be, in percentages.
const MAX_MIDDLE_SPACE = 0.80
const MIN_MIDDLE_SPACE = 0.50

# Constants that defines how far from the last point the next point can be, in percentages.
const MAX_SIDE_LEAN = 0.10

# Constants that defines how close the two dots can be, in pixels.
const MAX_SIDE_LEAN = 200

# Saves all the dots for both sides in an array of array of vectors for the dots.
var LeftPath = []
var RightPath = []

# Accumulates speed at every call of the process method until it reaches the speed global
var accumulation = 0

func _ready():
	set_process(true)
	var viewport = get_viewport().get_rect().size
	var viewWidth = viewport[0]
	var viewHeight = viewport[1]
	# Get a random number for the max and min middle space
	var sizePercent = rand_range(MIN_MIDDLE_SPACE, MAX_MIDDLE_SPACE)
	var spotWidth = viewWidth * sizePercent
	LeftPath.push_front(Vector2(viewWidth / 2 - spotWidth / 2, viewHeight))
	LeftPath.push_front(Vector2(viewWidth / 2 - spotWidth / 2, 0))
	RightPath.push_front(Vector2(viewWidth - spotWidth / 2, viewHeight))
	RightPath.push_front(Vector2(viewWidth - spotWidth / 2, 0))
	get_node("RightDraw").path = LeftPath;
	get_node("RightDraw").update()
	get_node("LeftDraw").path = RightPath;
	get_node("LeftDraw").update()

func _draw():
	get_node("RightDraw").path = LeftPath;
	get_node("RightDraw").update()
	get_node("LeftDraw").path = RightPath;
	get_node("LeftDraw").update()

func _process(delta):
	accumulation += delta
	# TODO: REMOVE THAT!
	get_node("/root/Game").total_scroll += delta
	var speed = get_node("/root/Game").scroll_speed
	if (accumulation >= speed):
		accumulation = 0
		generate_middle_dot()

func generate_middle_dot():
	var total_scroll = get_node("/root/Game").total_scroll
	# Get a random number for the distance between spot and middle (Minus mean to the left
	var sideLean = rand_range(-MAX_SIDE_LEAN, MAX_SIDE_LEAN)
	var leftPos = LeftPath[0].x + (LeftPath[0].x * sideLean)
	var rightPos = RightPath[0].x + (RightPath[0].x * sideLean)
	var leftdot = Vector2(leftPos, 0)
	var rightdot = Vector2(rightPos, 0)
	# Add the dot to the array
	# Go through all dots and add the total scroll to their position
	for i in range(LeftPath.size()):
		if i > 0:
			LeftPath[i] = Vector2(LeftPath[i].x, LeftPath[i].y + total_scroll)
			RightPath[i] = Vector2(RightPath[i].x, RightPath[i].y + total_scroll)
	LeftPath.push_front(leftdot)
	RightPath.push_front(rightdot)
	update()