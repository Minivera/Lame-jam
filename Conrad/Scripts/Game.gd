extends Node

var scroll_speed = 100
var timer = null
var ready = true
var timeSinceShine = 0
var shine_meter = 0
var mySprite


func _ready():
	set_process(true)
	timer = Timer.new()
	timer.set_wait_time( 2 )
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)

func _on_timer_timeout():
	ready = true

func _process(delta):
	if (ready):
		mySprite = preload("res://Scenes/Shine2.tscn").instance() 
		#mySprite.init()
		add_child(mySprite)
		ready = false
		timer.start()