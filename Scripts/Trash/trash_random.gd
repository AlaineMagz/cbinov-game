extends Node2D

@export var sprite : Sprite2D
@onready var collision = get_child(1)

@export var trashSprites : Array[Texture2D]
@export var trashCollision : Array[CollisionPolygonRes]

@export var lowestPos : int = 750

func _ready():
	
	var num = randi_range(0, trashSprites.size() - 1)
	
	sprite.texture = trashSprites[num]
	
	if trashCollision.size() > 0:
		collision.polygon = trashCollision[num].polygon
	

func _physics_process(_delta):
	
	if global_position.y > lowestPos:
		self.queue_free()
	
