extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 300

var velocity = Vector2()
#one of idle,running,charging
var status: String = 'idle'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('charge'):
		status = 'charging'
	else: 
		status = 'running'
		if Input.is_action_pressed('ui_right'):
			velocity.x +=1
		if Input.is_action_pressed('ui_left'):
			velocity.x -=1	
		if Input.is_action_pressed('ui_down'):
			velocity.y +=1
		if Input.is_action_pressed('ui_up'):
			velocity.y -=1
		if !Input.is_action_pressed('ui_right') && !Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_up') && !Input.is_action_pressed('ui_down'):
			status = 'idle'
	
	velocity = velocity.normalized() * speed

func _physics_process(_delta):
	get_input()
	velocity = move_and_slide(velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
