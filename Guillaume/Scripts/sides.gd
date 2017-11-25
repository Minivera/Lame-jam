extends Node2D

# Constants that defines how big and small the tunnel can be, in percentages.
const MAX_MIDDLE_SPACE = 0.80
const MIN_MIDDLE_SPACE = 0.50

# Constants that define how close one side can be to the center, in percentages.
const MAX_SIDE_LEAN = 0.20

# Saves all the dots for both sides in an array of array of vectors for the dots.
var dots = []

# Accumulates speed at every call of the process method until it reaches the speed global
var accumulation = 0

func _ready():
	set_process(true)
	self.set_pos(Vector2(get_viewport_rect().size.width/2, get_viewport_rect().size.height/2))

func _draw():
	# The actual curve for the left side
	var curveLeft = Curve2D.new()
	# The actual curve for the right side
	var curveRight = Curve2D.new()
	
	var col = Color(0,0,0,1)
	print(dots)
	for i in range(dots.size()):
		if i > 0:
			curveLeft.add_point(dots[i]["left"])
			curveRight.add_point(dots[i]["right"])
	get_node("RightDraw/RightSide").set_curve(curveLeft)
	get_node("LeftDraw/LeftSide").set_curve(curveRight)
	get_node("RightDraw").update()
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
	var viewport = get_viewport().get_rect().size
	var viewWidth = viewport[0]
	var centerPos = viewWidth / 2
	# Get a random number for the max and min middle space
	var sizePercent = rand_range(MIN_MIDDLE_SPACE, MAX_MIDDLE_SPACE)
	var spotWidth = viewWidth * sizePercent
	# Get a random number for the distance between spot and middle (Minus mean to the left
	var sideLean = rand_range(-MAX_SIDE_LEAN, MAX_SIDE_LEAN)
	var finalLean = sideLean * viewWidth;
	var dot = {
		"left" : Vector2(centerPos - ((spotWidth / 2) + finalLean), 0),
		"right": Vector2(centerPos + ((spotWidth / 2) + finalLean), 0)
	}
	# Add the dot to the array
	# Go through all dots and add the total scroll to their position
	for i in range(dots.size()):
		if i > 0:
			dots[i]["left"] = Vector2(dots[i]["left"].x, dots[i]["left"].y + total_scroll)
			dots[i]["right"] = Vector2(dots[i]["left"].x, dots[i]["left"].y + total_scroll)
	dots.push_front(dot)
	update()