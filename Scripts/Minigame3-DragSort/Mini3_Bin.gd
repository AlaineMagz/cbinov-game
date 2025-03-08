extends Area2D

@export_category("Bin Variables")
@export var bin : String = "null"
@export var midPoint : int = 0

func _on_body_entered(body):
	
	print("Detected")
	
	if body.name.contains("pickable"):
		body.binned = bin
		body.midPoint = midPoint
	

func _on_body_exited(body):
	
	if body.name.contains("pickable"):
		body.binned = null
		body.midPoint = null
	
