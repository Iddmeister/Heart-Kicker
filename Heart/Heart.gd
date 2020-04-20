extends RigidBody2D

class_name Heart

export var maxSpeed = 5000

export var puntParticles:PackedScene

var pulling = false

var hitBody

var dead = false

var delivered = false

signal death()

func _draw():
	
	if pulling:
		
		draw_arc(Vector2(0, 0), 30, 0, deg2rad(360), 30, Color(1, 1, 1, 1), 7)
		

func _ready():
	Globals.heart = self
	
func _physics_process(_delta):
	
	update()
	
	if global_position.y > Globals.deathHeight:
		
		if not dead:
			hit()

func punt(power:int, direction:float):
	
	hitBody = null
	
	linear_velocity = Vector2(0, 0)
	applied_force = Vector2(0, 0)
	
	$Space/Strike.global_position = global_position-Vector2(10, 0).rotated(direction)
	$Space/Strike.global_rotation = direction+deg2rad(45)
	$Animation.play("Punt")
	
	apply_central_impulse(Vector2(power, 0).rotated(direction))
	apply_torque_impulse(2000)
	
	var p = puntParticles.instance()
	$Space.add_child(p)
	p.global_position = global_position
	p.emitting = true
	p.global_rotation = direction
	
	$Punt.pitch_scale = 1+rand_range(-0.2, 0.2)
	$Punt.play()
	
	pass
	
func _integrate_forces(state):
	
	state.linear_velocity = state.linear_velocity.clamped(maxSpeed)
	
	pass
	
func hit():
	pause_mode = Node.PAUSE_MODE_PROCESS
	$Death.play()
	explode()
	
func explode():
	
	$Sprite.visible = false
	$Blood.emitting = true
	dead = true
	$CollisionPolygon2D.set_deferred("disabled", true)
	$Trail/Line.visible = false
	set_deferred("mode", RigidBody2D.MODE_STATIC)
	emit_signal("death")
	
	pass
	
func delivered():
	delivered = true
	set_deferred("mode", RigidBody2D.MODE_STATIC)
	$Trail/Line.visible = false
	visible = false
	pass


func _on_Heart_body_entered(body):
	
	if body.is_in_group("Hittable"):
		
		body.hit(global_position.angle_to(body.global_position))
		
		pass
	
	if not body.is_in_group("Dispenser"):
		
		if not hitBody == body:
		
			$Bounce.pitch_scale = 1+rand_range(-0.2, 0.2)
			$Bounce.play()
			hitBody = body

