extends Node

export var trailLength = 10
export var trailSpeed = 0.5

export var targetPath:NodePath

func _ready():
	
	for _i in range(trailLength):
		$Line.add_point(get_node(targetPath).global_position)
	
	pass
	
func _physics_process(_delta):
	drawTrail()

func drawTrail():
	
	for point in range(trailLength):
		
		if not point == 0:
			$Line.set_point_position(point, $Line.get_point_position(point).linear_interpolate($Line.get_point_position(point-1), trailSpeed*Engine.time_scale))
		else:
			$Line.set_point_position(0, get_node(targetPath).global_position)
		pass
	
	pass
