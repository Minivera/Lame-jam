extends Node

var scroll_speed = 100
var timer = 0
var timeSinceShine = 0
var shine_meter = 0
var mySprite


func _ready():
	set_process(true)

func _process(delta):
#	timer += round(delta)
	if (true):
		mySprite = preload("res://Scenes/Shine2.tscn").instance() 
		mySprite.init()
		add_child(mySprite)