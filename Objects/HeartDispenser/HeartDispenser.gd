extends StaticBody2D

export var openOnStart:bool = true

signal opened()

func _ready():
	
	if openOnStart:
		open()

func open():
	
	$Beep.play()
	yield($Beep, "finished")
	$Open.play()
	$Animation.play("Open")
	emit_signal("opened")
	
	pass

