extends Control

func _ready():
	Music.playTrack(0)
	$CenterContainer/VBoxContainer/Time.text = "In %5.3f Seconds" % Globals.totalTime
	pass


func _on_Continue_pressed():
	Manager.changeScene("res://UI/Main/Main.tscn")
