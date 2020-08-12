extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var speed = 300

var velocity = Vector2()
#one of idle,charge,attack,run_left_,run_right
var status:String = 'idle'
var attackTimer = 0;
var chargeLength = 0;
export var attackCooldown = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_released('charge') && attackCooldown == 0:
		if chargeLength > 30:
			attackCooldown = 100
		chargeLength = 0
		attackTimer = 20
	pass
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('charge') && attackCooldown == 0:
		chargeLength+=1
		status = 'charge'
	elif attackTimer == 0: 
		if Input.is_action_pressed('ui_right'):
			status = 'run_right'
			velocity.x +=1
		if Input.is_action_pressed('ui_left'):
			status = 'run_left'
			velocity.x -=1	
		if Input.is_action_pressed('ui_down'):
			status = "run_down"
			velocity.y +=1
		if Input.is_action_pressed('ui_up'):
			status = "run_up"
			velocity.y -=1
		if !Input.is_action_pressed('ui_right') && !Input.is_action_pressed('ui_left') && !Input.is_action_pressed('ui_up') && !Input.is_action_pressed('ui_down') && status != 'attack':
			status = 'idle'
	
	velocity = velocity.normalized() * speed
	pass
	
func handle_attack_cooldown():
	if(attackCooldown > 0):
		attackCooldown -=1

func handle_attack():
	if(attackTimer > 0):
		attackTimer -= 1
		status = "attack"
	else:
		status = "idle"
pass

func _physics_process(_delta):
	handle_attack()
	handle_attack_cooldown()
	get_input()
	velocity = move_and_slide(velocity)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
