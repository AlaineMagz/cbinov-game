extends Node2D

@onready var shader = preload("res://Shaders/OutlineShaderMat.tres")
@onready var sprite = get_child(0)
var manager

@export_category("Level Bounds")
@export var topBound : int = -250
@export var bottomBound : int = 250
@export var leftBound : int = -500
@export var rightBound : int = 500

var isHovered = false
var isPicked = false

var offset = null

func _physics_process(delta):
	
	if isPicked:
		
		if offset == null:
			offset = get_global_mouse_position() - global_position
		
		position = get_global_mouse_position() - offset
		
		snapToBounds()
		
	else:
		offset = null
	

func snapToBounds():
	
	if position.y < topBound:
		position.y = topBound
	
	if position.y > bottomBound:
		position.y = bottomBound
	
	if position.x < leftBound:
		position.x = leftBound
	
	if position.x > rightBound:
		position.x = rightBound
	

func goOutline():
	sprite.material = shader

func noOutline():
	sprite.material = null

func _on_mouse_entered():
	isHovered = true

func _on_mouse_exited():
	isHovered = false
