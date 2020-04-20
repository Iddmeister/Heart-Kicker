extends Control

func _ready():
	setMusic(Globals.music)
	setFull(OS.window_fullscreen)
	pass
	
func setMusic(d:bool):
	
	Music.mute(not d)
	
	if d:
		$CenterContainer/VBoxContainer/Music.text = "Music: On"
	else:
		$CenterContainer/VBoxContainer/Music.text = "Music: Off"
	
	$CenterContainer/VBoxContainer/Music.pressed = d
	
	pass
	
func setFull(d:bool):
	
	if d:
		$CenterContainer/VBoxContainer/Fullscreen.text = "Fullscreen: On"
	else:
		$CenterContainer/VBoxContainer/Fullscreen.text = "Fullscreen: Off"
		
	$CenterContainer/VBoxContainer/Fullscreen.pressed = d
	
	pass

func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed
	setFull(button_pressed)


func _on_Music_toggled(button_pressed):
	Globals.music = button_pressed
	setMusic(button_pressed)


func _on_Back_pressed():
	Manager.changeScene("res://UI/Main/Main.tscn")
