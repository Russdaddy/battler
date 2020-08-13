extends Node2D

var Slime = preload("res://Slime.tscn")
export var slime_timer = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(Slime.instance())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if slime_timer > 0:
		slime_timer-=1
	else:
		var slime = Slime.instance()
		add_child(slime)
		slime_timer = 500
