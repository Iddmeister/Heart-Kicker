extends Control

func setTime(time:float):
	
	$MarginContainer/Time.text = "%5.3f" % time
	
	pass
	
func finished():
	
	$Animation.play("Flash")
	
	pass
