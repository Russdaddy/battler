extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var hSpeed = -20
var vSpeed = 0
var horizontalDecayRate = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func handle_collisions(delta):
	var collision = move_and_collide(Vector2(hSpeed,vSpeed) * delta)
	if(hSpeed > 0):
		hSpeed -= horizontalDecayRate
	if collision:
		if collision.collider.name == "player":
			match collision.collider.status:
				"idle":
					print("hurt")
				"attack":
					hSpeed = 500
				
					print("attack")


func _physics_process(delta):
	 handle_collisions(delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
