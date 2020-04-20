extends Node

var levels = {
	
	-2:"res://UI/End/End.tscn",
	-1:"res://Levels/Levels/Intermission.tscn",
	1:"res://Levels/Levels/Level1.tscn",
	2:"res://Levels/Levels/Level2.tscn",
	3:"res://Levels/Levels/Level3.tscn",
	4:"res://Levels/Levels/Level4.tscn",
	5:"res://Levels/Levels/Level5.tscn",
	6:"res://Levels/Levels/Level6.tscn",
	7:"res://Levels/Levels/Level7.tscn",
	8:"res://Levels/Levels/Level8.tscn",
	9:"res://Levels/Levels/Level9.tscn",
	10:"res://Levels/Levels/Level10.tscn",
	11:"res://Levels/Levels/Level11.tscn",
	12:"res://Levels/Levels/Level12.tscn",
	
	
}

var firstTry = true

func goToLevel(level:int):
	
	changeScene(levels[level])
	
	pass
	
func restart():
	
	firstTry = false
	$Animation.play("FadeIn")
	yield($Animation, "animation_finished")
	get_tree().paused = true
	get_tree().reload_current_scene()
	get_tree().paused = false
	$Animation.play("FadeOut")
	yield($Animation, "animation_finished")

func changeScene(path:String):
	firstTry = true
	$Animation.play("FadeIn")
	yield($Animation, "animation_finished")
	get_tree().paused = true
	get_tree().change_scene(path)
	get_tree().paused = false
	$Animation.play("FadeOut")
	yield($Animation, "animation_finished")
	
	pass
