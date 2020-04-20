extends Control

signal retry()

signal menu()

func _on_Retry_pressed():
	emit_signal("retry")


func _on_Menu_pressed():
	emit_signal("menu")


func _on_Animation_animation_finished(_anim_name):
	get_tree().paused = true
