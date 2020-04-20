tool

extends Node2D

var failed = false
var complete = false

export var nextLevel:int

var time:float = 0

var started = false

func _draw():
	
	if Engine.is_editor_hint():
		
		draw_line(Vector2(0, 1200), Vector2(10000, 1200), Color(1, 0, 0, 1), 10)
		
		pass
	
	pass

func _ready():
	$UI/DeathScreen.connect("retry", self, "restart")
	$UI/DeathScreen.connect("menu", self, "menu")
	$Pipe.connect("levelComplete", self, "levelComplete")
	$Objects/HeartDispenser.connect("opened", self, "startTime")
	pass
	
func _process(delta):
	
	if Input.is_action_just_pressed("quit"):
		Manager.changeScene("res://UI/Main/Main.tscn")
	
	if Input.is_action_just_pressed("restart"):
		Manager.restart()
		
	if started:
		
		time += delta
		$UI/RunTime.setTime(time)
	
func levelFail():
	
	if failed or complete:
		return
		
	started = false
	
	$UI/RunTime.visible = false
		
	failed = true
		
	#yield(get_tree().create_timer(0.2), "timeout")
		
	get_tree().paused = true
	
	$UI/DeathScreen.visible = true
	
	$UI/DeathScreen/Animation.play("Show")
	
	pass
	
func restart():
	
	Manager.restart()
	
	pass
	
func menu():
	
	Manager.changeScene("res://UI/Main/Main.tscn")
	
	pass


func levelComplete():
	Globals.totalTime += time
	complete = true
	$UI/CompleteScreen.visible = true
	started = false
	$UI/RunTime.finished()
	$LevelDelay.start()


func _on_LevelDelay_timeout():
	Manager.goToLevel(nextLevel)
	
func startTime():
	
	if not failed:
		
		started = true
		$UI/RunTime.visible = true
	
	pass

