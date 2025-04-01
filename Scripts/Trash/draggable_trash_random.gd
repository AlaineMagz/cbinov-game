extends Node2D

@onready var shader = preload("res://Shaders/OutlineShaderMat.tres")
@onready var sprite = get_child(0)
@onready var collision = get_child(1)
var manager

@export_category("Level Bounds")
@export var topBound : int = -250
@export var bottomBound : int = 150
@export var leftBound : int = -500
@export var rightBound : int = 500

@export_category("Variants")
@export var trashSprites : Array[Texture2D]
@export var trashCollision : Array[CollisionPolygonRes]

var isHovered = false
var isPicked = false

var offset = null

var binned = null
var midPoint = null

var trashState = 0

func _ready():
	
	var num = randi_range(0, trashSprites.size() - 1)
	
	sprite.texture = trashSprites[num]
	
	if trashCollision.size() > 0:
		collision.polygon = trashCollision[num].polygon
	

func _physics_process(delta):
	
	if trashState == 0:
		
		if isPicked:
			
			if offset == null:
				offset = get_global_mouse_position() - global_position
			
			position = get_global_mouse_position() - offset
			
			snapToBounds()
			
		else:
			offset = null
		
		if !isPicked && binned != null:
			trashState = 1
		
	
	if trashState == 1:
		
		position = position.lerp(Vector2(midPoint, bottomBound), 5.0 * delta)
		
		if position.distance_to(Vector2(midPoint, bottomBound)) < 10:
			trashState = 2
		
	
	if trashState == 2:
		
		position = position.lerp(Vector2(midPoint, bottomBound + 300), 2.0 * delta)
		
		if position.distance_to(Vector2(midPoint, bottomBound + 150)) < 10:
			
			manager.trashList.erase(self)
			
			if name.contains(binned):
				manager.addScore(10)
			else:
				manager.addScore(-20)
			
			self.queue_free()
			
		
	

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
