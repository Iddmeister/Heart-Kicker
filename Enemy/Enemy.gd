extends RigidBody2D

export var Bullet:PackedScene

export var enabled = true

export var shootRange = 2000

var canShoot = true

var dead = false

func _ready():
	pass
	
func _physics_process(_delta):
	
	if enabled:
	
		if not dead:
		
			if global_position.distance_to(Globals.player.global_position) <= shootRange:
				
				$Gun.look_at(Globals.player.global_position)
				
				if $Firerate.is_stopped():
					$Firerate.start()
				
			else:
				$Firerate.stop()
		
		pass

func shoot():
	
	var b = Bullet.instance()
	
	get_parent().add_child(b)
	
	b.global_position = $Gun/Muzzle.global_position
	b.startPos = $Gun/Muzzle.global_position
	b.global_rotation = $Gun.global_rotation
	
	$Shoot.pitch_scale = 1+rand_range(-0.2, 0.2)
	
	$Shoot.play()
	
	pass

func _on_Firerate_timeout():
	if canShoot:
		shoot()
		
func hit(direction:float):
	
	if dead:
		return
		
	$Firerate.stop()
	$Death.play()
	dead = true
	$Sprite.modulate = Color(1, 0, 0, 1)
	call_deferred("die", direction)
	
	pass
	
func die(direction:float):
	
	mode = RigidBody2D.MODE_RIGID
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, false)
	set_collision_mask_bit(4, false)
	
	apply_central_impulse(Vector2(900, 0).rotated(direction))
	
	$Grav.space_override = Area2D.SPACE_OVERRIDE_DISABLED
	
	pass


func _on_NoGoTime_timeout():
	canShoot = true


func _on_NoShootArea_body_entered(_body):
	canShoot = false
	$NoGoTime.start()
