extends StaticBody2D

signal levelComplete()

export var gravVec = Vector2(1, 0)

func _ready():
	$Grav.gravity_vec = gravVec
	pass
	
func _on_End_body_entered(body):
	emit_signal("levelComplete")
	body.delivered()
	$Delivered.play()
