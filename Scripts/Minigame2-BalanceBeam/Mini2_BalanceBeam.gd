extends RigidBody2D

@export var tiltSpeed: float = 1
@export var minTilt: float = -25
@export var maxTilt: float = 25

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.get_axis("left", "right"):
		rotation_degrees += tiltSpeed * Input.get_axis("left", "right")
	
	rotation_degrees = clampf(rotation_degrees, minTilt, maxTilt)
	
