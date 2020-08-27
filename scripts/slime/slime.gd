extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var velocity = Vector2(0,0)
var damping = .9
var hittable = true
var hit = false
var hitFrom = Vector2(0,0)
var movementInterval = 200
var hitTimer = 100
var dead = false
var hitPower = 1000

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	var xpos = rng.randf_range(500,500)
	var ypos = rng.randf_range(30,400)
	position.x = xpos
	position.y = ypos

func handle_hit(delta):
	if hit:
		hitTimer = 100
		dead = true
		velocity.x = round(hitFrom.direction_to(self.position).x * hitPower)
		velocity.y = round(hitFrom.direction_to(self.position).y * hitPower)
		hit = false

func handle_movement(delta):
	velocity = velocity * damping;
	move_and_collide(velocity * delta)
	
func handle_timers():
	if hitTimer > 0:
		hitTimer-=1
	if movementInterval > 0:
		movementInterval-=2

func handle_death():
	if int(velocity.x) == 0 && int(velocity.y) == 0 && (dead == true):
		self.queue_free()

func _physics_process(delta):
	handle_death()
	handle_timers()
	handle_hit(delta)
	handle_movement(delta)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
