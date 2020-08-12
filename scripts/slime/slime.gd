extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var hSpeed = -50
var vSpeed = 0
var horizontalDecayRate = 10

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var xpos = rng.randf_range(1200,1280)
	var ypos = rng.randf_range(100,700)
	position.x = xpos
	position.y = ypos
	get_node("../player").connect("attack_hit",self,"_on_attack_hit")

func _on_attack_hit(collider):
	print('hit',collider)

func handle_collisions(delta):
	var collision = move_and_collide(Vector2(hSpeed,vSpeed) * delta)
	if(hSpeed > 0):
		hSpeed -= horizontalDecayRate
#	if collision:
#		if collision.collider.name == "player":
#			match collision.collider.status:
#				"idle":
#					hSpeed=0
#				"attack":
#					hSpeed = 500d
#					print("attack")

func _physics_process(delta):
	handle_collisions(delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
