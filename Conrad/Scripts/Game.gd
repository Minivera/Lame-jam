extends Node

var scroll_speed = 100
var timer = 0
var timeSinceShine = 0
var shine_meter = 0
var mySprite


func _ready():
	pass

func _process(delta):
	timer += round(delta)
	if (timer % 1 == 0):
		mySprite = preload("res://Scenes/Shine.tscn").instance() 
		mySprite.init()
		add_child(mySprite)