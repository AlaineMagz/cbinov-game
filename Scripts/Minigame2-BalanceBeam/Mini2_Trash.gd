extends Node2D

@export var lowestPos = 750

func _physics_process(_delta):
	
	if global_position.y > lowestPos:
		self.queue_free()
	
