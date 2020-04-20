extends Particles2D


func _on_Time_timeout():
	queue_free()
