extends Control

func _ready():
	if not Music.currentTrack == 0:
		Music.playTrack(0)
	pass


func _on_Play_pressed():
	Globals.totalTime = 0
	Manager.goToLevel(1)


func _on_Quit_pressed():
	get_tree().quit()


func _on_Options_pressed():
	Manager.changeScene("res://UI/Options/Options.tscn")
