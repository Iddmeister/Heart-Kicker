extends Area2D

export var speed = 500

export var distance = 2000

var startPos:Vector2
	
func _physics_process(delta):
	
	position += Vector2(speed*delta, 0).rotated(rotation)
	
	if global_position.distance_to(startPos) > distance:
		destroy()
	
	pass
	
func destroy():
	
	queue_free()
	
	pass


func _on_Bullet_body_entered(body):
	
	if body.has_method("hit"):
		
		body.hit()
		
	destroy()
