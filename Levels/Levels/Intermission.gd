extends Control

onready var speech = $Speech

export var nextLevel:int

func _ready():
	
	Music.playTrack(1)
	
	speech.displayText("You have Successfully Completed Heart Delivery Training", 0.05)
	yield(speech, "done")
	yield(get_tree().create_timer(1), "timeout")
	speech.displayText("You are now eligible for Proper Missions", 0.05)
	yield(speech, "done")
	yield(get_tree().create_timer(1), "timeout")
	speech.displayText("Good Luck", 0.05)
	yield(speech, "done")
	yield(get_tree().create_timer(1), "timeout")
	Manager.goToLevel(nextLevel)
	
	pass
