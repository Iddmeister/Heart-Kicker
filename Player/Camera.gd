extends Camera2D

export var accuracy = 5

export var minDist = 200

export var maxDist = 500

export var maxZoom = Vector2(5, 5)

export var minZoom = Vector2(1.2, 1.2)

var both = true

func _ready():
	
	call_deferred("reset")
	Globals.camera = self
	
	pass
	
func reset():
	
	global_position = get_parent().get_parent().global_position+((Globals.heart.global_position-get_parent().get_parent().global_position)/2)
	
	pass
	
func _physics_process(_delta):
	
	if both:
	
		movement()
		
		zooming()
		
	else:
		
		global_position = get_parent().get_parent().global_position
	
func movement():
	
	var point = get_parent().get_parent().global_position+((Globals.heart.global_position-get_parent().get_parent().global_position)/2)
	
	if global_position.distance_to(point) > accuracy:
		
		global_position = global_position.linear_interpolate(point, 0.1)
	
	pass
	
func zooming():
	
	var dist = (get_parent().get_parent().get_global_transform_with_canvas().origin-Globals.heart.get_global_transform_with_canvas().origin).length()
	
	if dist > maxDist:
		
		if not zoom >= maxZoom:
		
			zoom += Vector2(0.015, 0.015)
		
	elif dist < minDist:
		
		if not zoom <= minZoom:
		
			zoom -= Vector2(0.015, 0.015)
	
	
	pass
