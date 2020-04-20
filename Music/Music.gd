extends Node

var tracks = {
	
	0:"res://Music/Brainmelt.wav",
	1:"res://Music/Barge.wav",
	
}

var currentTrack:int

func _ready():
	playTrack(0)
	pass
	
func playTrack(t:int):
	
	var track = load(tracks[t])
	
	currentTrack = t
	
	$Audio.stream = track
	
	$Audio.play()
	
	pass
	
func mute(d:bool):
	
	if d:
		$Audio.volume_db = -80
	else:
		$Audio.volume_db = 0.6
	
	pass
	


func _on_Audio_finished():
	playTrack(currentTrack)
