extends Node2D

# Constants that defines how big and small the tunnel can be, in percentages.
const MAX_MIDDLE_SPACE = 0.80
const MIN_MIDDLE_SPACE = 0.50

# Constants that defines how far from the last point the next point can be, in percentages.
const MAX_SIDE_LEAN = 5

# How many time should the random try to go in the same direction to make it "smooth"
const TIME_SAME_SIDE = 15
var timesSameSide = 0

# Acceleration when moving to one side
const SIDE_ACCELERATION = 0.5

# Constants that defines how close the two dots can be, in pixels.
const MIN_DISTANCE = 400

# Saves all the dots for both sides in an array of array of vectors for the dots.
var LeftPath = []
var RightPath = []



# Current direction the walls are going
var direction = {
	"left" : 0,
	"right" : 0
}

var currentLean = {
	"left" : 0,
	"right" : 0
}

var maxLeft = 0;
var maxRight = 0;

func _ready():
	set_process(true)
	var viewport = get_viewport().get_rect().size
	var viewWidth = viewport[0]
	var viewHeight = viewport[1]
	# Get a random number for the max and min middle space
	var sizePercent = rand_range(MIN_MIDDLE_SPACE, MAX_MIDDLE_SPACE)
	var spotWidth = viewWidth * sizePercent
	var leftWall = viewWidth / 2 - spotWidth / 2
	# Add a straight wall to the paths
	LeftPath.push_front(Vector2(leftWall, viewHeight))
	LeftPath.push_front(Vector2(leftWall, 0))
	RightPath.push_front(Vector2(leftWall + spotWidth, viewHeight))
	RightPath.push_front(Vector2(leftWall + spotWidth, 0))
	# Render the sides
	get_node("RightDraw").path = LeftPath;
	get_node("RightDraw").update()
	get_node("LeftDraw").path = RightPath;
	get_node("LeftDraw").update()
	# Setup variables
	direction["left"] = rand_range(0 - MAX_SIDE_LEAN, MAX_SIDE_LEAN)
	direction["right"] = rand_range(0 - MAX_SIDE_LEAN, MAX_SIDE_LEAN)
	maxLeft = 0 + viewWidth * (1 - MAX_MIDDLE_SPACE)
	maxRight = viewWidth - viewWidth * (1 - MAX_MIDDLE_SPACE)

func _draw():
	# Render the sides
	get_node("RightDraw").path = LeftPath;
	get_node("RightDraw").update()
	get_node("LeftDraw").path = RightPath;
	get_node("LeftDraw").update()

func _process(delta):
	# TODO: REMOVE THAT!
	get_node("/root/Game").total_scroll += delta
	if (currentLean["left"] >= abs(direction["left"]) or currentLean["right"] >= abs(direction["right"])):
		print("rcalcul")
		# Check if we are still going to the same side
		if (timesSameSide == TIME_SAME_SIDE) :
			timesSameSide = 0
			# Get a random number for the distance between spots and middle (Minus means to the left)
			direction["left"] = rand_range(0 - MAX_SIDE_LEAN, MAX_SIDE_LEAN)
			direction["right"] = rand_range(0 - MAX_SIDE_LEAN, MAX_SIDE_LEAN)
		else :
			timesSameSide += 1
			# If yes, contnue going that side
			direction["left"] = rand_range(0, sign(direction["left"]) * MAX_SIDE_LEAN)
			direction["right"] = rand_range(0, sign(direction["right"]) * MAX_SIDE_LEAN)
		currentLean["left"] = 0
		currentLean["right"] = 0
		generate_middle_dot()
	else:
		generate_middle_dot()

func generate_middle_dot():
	var viewport = get_viewport().get_rect().size
	var total_scroll = get_node("/root/Game").total_scroll
	
	currentLean["left"] += abs(direction["left"] * SIDE_ACCELERATION)
	currentLean["right"] += abs(direction["right"] * SIDE_ACCELERATION)
	var leftPos = max(LeftPath[0].x + direction["left"] * SIDE_ACCELERATION, rand_range(maxLeft, maxLeft - 40))
	var rightPos = min(RightPath[0].x + direction["right"] * SIDE_ACCELERATION, rand_range(maxRight, maxRight - 40))
	print(rightPos - leftPos)
	print(MIN_DISTANCE)
	if (rightPos - leftPos <= MIN_DISTANCE):
		leftPos = max(LeftPath[0].x + ((-direction["left"]) * SIDE_ACCELERATION), maxLeft)
		rightPos = min(RightPath[0].x + ((-direction["right"]) * SIDE_ACCELERATION), maxRight)
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