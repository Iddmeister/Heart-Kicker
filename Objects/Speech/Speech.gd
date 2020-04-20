extends Control

signal done()

var amount:float = 0.1

func displayText(text:String, time:float):
	
	$Time.wait_time = time
	amount = 1.0/text.length()
	$CenterContainer/Text.text = text
	$CenterContainer/Text.percent_visible = 0
	$Time.start()
	
	pass

func _on_Time_timeout():
	$CenterContainer/Text.percent_visible += amount
	
	if $CenterContainer/Text.percent_visible >= 1:
		$Time.stop()
		emit_signal("done")
