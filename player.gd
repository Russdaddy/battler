extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 300

var velocity = Vector2()
#one of idle,run,charge,attack
var status:String = 'idle'
var attackTimer = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_released('charge'):
		attackTimer = 20
	pass
	
func get_input():
		
	velocity = Vector2()
	if Input.is_action_pressed('charge'):
		status = 'charge'
	else: 
		if Input.is_action_pressed('ui_right'):
			velocity.x +=1
		if Input.is_action_pressed('ui_left'):
			velocity.x -=1	
		if Input.is_action_pressed('ui_down'):	
			velocity.y +=1
		if Input.is_action_pressed('ui_up'):
			velocity.y -=1
		if !Input.is_action_pressed('ui_right') && !Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_up') && !Input.is_action_pressed('ui_down') && status != 'attack':
			status = 'idle'
	
	velocity = velocity.normalized() * speed
	pass

func handle_attack():
		if(attackTimer > 0):
			attackTimer -= 1
			status = "attack"
		else:
			status = "idle"
pass

func _physics_process(_delta):
	print(status)
	handle_attack()
	get_input()
	velocity = move_and_slide(velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
