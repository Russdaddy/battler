extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var hSpeed = -500
var vSpeed = 0
var horizontalDecayRate = 10
var hittable = true
var hit = false
var hitFrom = Vector2(0,0)
var movementInterval = 200
var hitTimer = 100
var dead = false

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var xpos = rng.randf_range(1200,1280)
	var ypos = rng.randf_range(100,700)
	position.x = xpos
	position.y = ypos

func handle_hit(delta):
	if hit:
		hitTimer = 100
		dead = true
		hSpeed = 500 if (hitFrom.x < self.position.x) else -500
		hit = false

func handle_movement(delta):
	var velocity = Vector2(hSpeed,vSpeed)
	move_and_collide(velocity * delta)
	if(hSpeed > 0):
		hSpeed -= horizontalDecayRate
	elif (hSpeed < 0):
		hSpeed += horizontalDecayRate
	if hitTimer == 0 && movementInterval == 0:
		hSpeed = -300
		movementInterval = 200
	
func handle_timers():
	if hitTimer > 0:
		hitTimer-=1
	if movementInterval > 0:
		movementInterval-=2

func handle_death():
	if hSpeed == 0 && dead == true:
		self.queue_free()

func _physics_process(delta):
	handle_death()
	handle_timers()
	handle_hit(delta)
	handle_movement(delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
