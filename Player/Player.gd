extends KinematicBody2D

export var maxSpeed = 400

export var acceleration = 20
export var deceleration = 0.2

export var gravity = 10
export var jumpPower = 300

export var puntPower = 50
export var pullPower = 1200

export var wallFriction = 15

export var wallJumpPower = Vector2(800, 600)

var velocity = Vector2()

var UP = Vector2(0, -1)

var heart:Heart

var kickable = []

enum {LEFT=-1, RIGHT=1, NONE=0}

var kicking = false

var PlayerBody = preload("res://Player/PlayerBody.tscn")

var dead = false

signal death()

func _draw():
	
	if heart:
		
		draw_arc(Vector2(0, 0), $PuntArea/CollisionShape2D.shape.radius, 0, deg2rad(360), 100, Color(1, 1, 1 ,0.5), 3, false)
		draw_line(Vector2(0, 0), to_local(get_global_mouse_position()).clamped($PuntArea/CollisionShape2D.shape.radius), Color(1, 1, 1, 0.5), 3, false)
		
		
		pass
	
	pass

func _ready():
	Globals.player = self
	pass
	
func _physics_process(_delta):
	
	if not dead:
		
		movement()
		actions()
		animations()
	
	if global_position.y > Globals.deathHeight:
		if not dead:
			hit()
		pass
		
	update()
	
	pass
	
func actions():
	
	if Input.is_action_just_pressed("punt"):
		
		if heart:
			
			heart.punt(puntPower, (get_global_mouse_position()-global_position).angle())
			kicking = true
			$KickTime.start()
			if (get_global_mouse_position() - global_position).x < 0:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
			
			pass
			
		if not kickable.empty():
			
			kickable[0].kick(puntPower, (get_global_mouse_position()-global_position).angle())
			
			kicking = true
			$KickTime.start()
			if (get_global_mouse_position() - global_position).x < 0:
				$Sprite.flip_h = true
			else:
				$Sprite.flip_h = false
			
			pass
			
			
		pass
		
		
	if Input.is_action_pressed("pull"):
		
		if Globals.heart.delivered or Globals.heart.dead:
			Globals.heart.pulling = false
			$Pull.stop()
			$Space/Bond.visible = false
			return
		
		if not $Pull.playing:
			$Pull.play()
		
		Globals.heart.applied_force = Vector2(pullPower, 0).rotated((global_position-Globals.heart.global_position).angle())
		Globals.heart.pulling = true
		$Space/Bond.visible = true
		$Space/Bond.set_point_position(0, global_position)
		$Space/Bond.set_point_position(1, Globals.heart.global_position-Vector2(30, 0).rotated((get_angle_to(Globals.heart.global_position))))
		
	else:
		$Pull.stop()
		$Space/Bond.visible = false
		Globals.heart.applied_force = Vector2(0, 0)
		Globals.heart.pulling = false
	
	pass
	
func movement():
	
	velocity.y += gravity
	
	if Input.is_action_pressed("left"):
		
		velocity.x = max(-maxSpeed, velocity.x-acceleration)
		
	elif Input.is_action_pressed("right"):
		
		velocity.x = min(maxSpeed, velocity.x+acceleration)
		
	else:
		
		velocity.x = lerp(velocity.x, 0, deceleration)
		
		
	if is_on_floor():
		
		
		if Input.is_action_pressed("jump"):
			
			velocity.y = -jumpPower
			$Jump.pitch_scale = 1+rand_range(-0.2, 0.2)
			$Jump.play()
			
			pass
			
			
	if not getSide() == 0:
		
		if velocity.y > 0:
			velocity.y -= wallFriction
		
		pass
		
		
		if Input.is_action_just_pressed("jump"):
			
			velocity.x = wallJumpPower.x*getSide()*-1
			velocity.y = -wallJumpPower.y
			$Jump.pitch_scale = 1+rand_range(-0.2, 0.2)
			$Jump.play()
			
			pass
			
			
	velocity = move_and_slide(velocity, UP)
	
	pass
	
func animations():
	
	if kicking:
		playAnim("kick")
		return
	
	if is_on_floor():
		
		if abs(velocity.x) > 10:
			
			playAnim("run")
			
		else:
			
			playAnim("default")
			
			
	elif getSide() == 0:
		
		if velocity.y > 0:
			
			playAnim("down")
			
		else:
			
			playAnim("up")
			
	else:
		
		playAnim("wall")
		
	match getSide():
		
		1:
			$Sprite.flip_h = true
			
		-1:
			$Sprite.flip_h = false
			
			
		_:
			
			if velocity.x > 0:
				
				$Sprite.flip_h = false
				
			else:
				
				$Sprite.flip_h = true
	
	
	pass
	
func hit():
	if dead:
		return
	dead = true
	visible = false
	pause_mode = Node.PAUSE_MODE_PROCESS
	$Death.play()
	call_deferred("die")
	emit_signal("death")
	
	pass
	
func die():
	
	var body = PlayerBody.instance()
	get_parent().add_child(body)
	body.global_position = global_position
	body.apply_central_impulse(Vector2(300, 0).rotated(deg2rad(rand_range(0, 360))))
	body.apply_torque_impulse(1000)
	
	pass
	
func playAnim(anim:String):
	
	if not $Sprite.animation == anim:
		$Sprite.play(anim)
	
	pass
	
func getSide() -> int:
	
	if $Rays/Left.is_colliding():
		return LEFT
	elif $Rays/Right.is_colliding():
		return RIGHT
	else:
		return NONE
	
	pass


func _on_PuntArea_body_entered(pbody):
	
	if pbody.is_in_group("Heart"):
		
		heart = pbody
	
	if pbody.is_in_group("Kickable"):
		
		kickable.append(pbody)
		
		pass

func _on_PuntArea_body_exited(pbody):
	
	if pbody.is_in_group("Heart"):
		
		heart = null
		
	if pbody.is_in_group("Kickable"):
		
		kickable.erase(pbody)
		
		pass


func _on_KickTime_timeout():
	kicking = false
