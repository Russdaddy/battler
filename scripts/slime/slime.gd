extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var hSpeed = -500
var vSpeed = 0
var horizontalDecayRate = 10
var verticalDecayRate = 10
var hittable = true
var hit = false
var hitFrom = Vector2(0,0)
var movementInterval = 200
var hitTimer = 100
var dead = false
var hitPower = 20

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
		#difference from distance
		var x = round(abs(hitFrom.x - position.x))
		var y = round(abs(hitFrom.y - position.y))
		#even
		if fmod(x,2) != 0:
			x = x-1
		if fmod(y,2) != 0:
			y = y-1
			
		hitTimer = 100
		dead = true
		horizontalDecayRate = x * (hitPower / 12)
		verticalDecayRate = y * (hitPower / 12)
		print(verticalDecayRate," ", horizontalDecayRate)
		hSpeed = (x * hitPower) if (hitFrom.x < position.x) else -(x*hitPower)
		vSpeed = (y * hitPower) if (hitFrom.y < position.y) else -(y*hitPower)
		hit = false

func handle_movement(delta):
	velocity = Vector2(hSpeed,vSpeed)
	move_and_collide(velocity * delta)
	if(hSpeed > 0):
		if(hSpeed < horizontalDecayRate): 
			hSpeed = 0
			vSpeed = 0
		else: hSpeed -= horizontalDecayRate
	elif (hSpeed < 0):
		hSpeed += horizontalDecayRate
	if(vSpeed > 0):
		if(vSpeed < verticalDecayRate): 
			vSpeed = 0
			hSpeed = 0
		else: vSpeed -= verticalDecayRate
	elif (vSpeed < 0):
		vSpeed += verticalDecayRate
	if hitTimer == 0 && movementInterval == 0 && dead == false:
		hSpeed = -300
		movementInterval = 200
	
func handle_timers():
	if hitTimer > 0:
		hitTimer-=1
	if movementInterval > 0:
		movementInterval-=2

func handle_death():
	if (hSpeed + vSpeed) == 0 && dead == true:
		self.queue_free()

func _physics_process(delta):
	handle_death()
	handle_timers()
	handle_hit(delta)
	handle_movement(delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
