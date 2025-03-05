extends Node2D

@export_category("Gameplay Variables")
@export var spawnSpeed: float = 1
@export var paperTrashWeight: int = 1
@export var plasticTrashWeight: int = 1
@export var metalTrashWeight: int = 1
@export var minXSpawn: int = -500
@export var maxXSpawn: int = 500
@export var ySpawn: int = -600

@export_category("Node Variables")
@export var timer: Timer

@onready var paperTrash = preload("res://Scenes/Prefabs/Minigame1/paper_trash.tscn")
@onready var plasticTrash = preload("res://Scenes/Prefabs/Minigame1/plastic_trash.tscn")
@onready var metalTrash = preload("res://Scenes/Prefabs/Minigame1/metal_trash.tscn")


func pickTrash():
	
	var totalWeight = paperTrashWeight + plasticTrashWeight + metalTrashWeight
	
	var rand = randi_range(1, totalWeight)
	
	if rand <= paperTrashWeight:
		return "paper"
	else: if rand > paperTrashWeight && rand <= paperTrashWeight + plasticTrashWeight:
		return "plastic"
	else:
		return "metal"
	

func spawnTrash():
	
	var trash = pickTrash()
	
	var xPos = randi_range(minXSpawn, maxXSpawn)
	
	var newTrash
	
	match trash:
		
		"paper": newTrash = paperTrash.instantiate()
		"plastic": newTrash = plasticTrash.instantiate()
		"metal": newTrash = metalTrash.instantiate()
		
	
	newTrash.global_position = Vector2(xPos, ySpawn)
	newTrash.name = "collectible" + trash + str(xPos) + str(randf_range(-100.0, 100.0))
	newTrash.rotation_degrees = randi_range(0,359)
	get_parent().add_child(newTrash)
	

func _on_timer_timeout() -> void:
	
	spawnTrash()
	timer.start(spawnSpeed)
	
