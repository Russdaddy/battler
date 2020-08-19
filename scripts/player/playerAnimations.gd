extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var last_pressed: String = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	set_animation('default')
	play()
	pass # Replace with function body.

#last pressed tracking
func _input(event):
	if(event.is_action_released("ui_right")): 
		last_pressed = "right"
	if(event.is_action_released("ui_left")):
		last_pressed = "left"
	pass
	
func handle_flipping():
	if Input.is_action_pressed("ui_right"):
		flip_h = true
	elif Input.is_action_pressed("ui_left"):
		flip_h = false
	else:
		flip_h = true if last_pressed == "right" else false
	
func _process(delta):
	handle_flipping()
	match get_node("..").status:
		"charge":
			set_animation("charging")
		"attack":
			set_animation("attack")
		"attack_quick":
			set_animation("attack_quick")
		"run_left":
			set_animation("run")
		"run_right":
			set_animation("run")
		"run_up":
			set_animation("run")
		"run_down":
			set_animation("run")
		"idle":
			set_animation('default')
	
#	elif(!Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_right')):
#		flip_h = true if last_pressed == "right" else false
#		set_animation('default')
	
	pass
