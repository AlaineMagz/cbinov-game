extends Sprite2D

var hue: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	self_modulate = Color.from_hsv(hue, 0.05, 0.9, 1)
	
	if hue >= 1.0:
		hue = 0
	else:
		hue += 0.001
	
