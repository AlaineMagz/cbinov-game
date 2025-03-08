extends Node2D

@export_category("Trash Amounts")
@export var paperAmount : int = 1
@export var plasticAmount : int = 1
@export var metalAmount : int = 1

var totalTrash: int

@export_category("Spawn Boundaries")
@export var minXSpawn: int = -500
@export var maxXSpawn: int = 500
@export var minYSpawn: int = -250
@export var maxYSpawn: int = 250

@onready var manager = get_parent()
@onready var paperTrash = preload("res://Scenes/Prefabs/Minigame3/paper_trash.tscn")
@onready var plasticTrash = preload("res://Scenes/Prefabs/Minigame3/plastic_trash.tscn")
@onready var metalTrash = preload("res://Scenes/Prefabs/Minigame3/metal_trash.tscn")

func insertTrash(type : String):
	
	var randX = randi_range(minXSpawn, maxXSpawn)
	var randY = randi_range(minYSpawn, maxYSpawn)
	
	print("Spawning " + type + " at X = " + str(randX) + " and Y = " + str(randY) + " with the Z Index of " + str(totalTrash))
	
	var newTrash
	
	match type:
		
		"paper": newTrash = paperTrash.instantiate()
		"plastic": newTrash = plasticTrash.instantiate()
		"metal": newTrash = metalTrash.instantiate()
		
	
	newTrash.global_position = Vector2(randX, randY)
	newTrash.name = "pickable" + type + str(randX) + str(randY) + str(totalTrash)
	newTrash.rotation_degrees = randi_range(0,359)
	newTrash.z_index = totalTrash
	newTrash.manager = manager
	add_child(newTrash)
	manager.trashList.append(newTrash)
	

func spawnTrash():
	
	var rand = randi_range(1,3)
	
	if rand == 1 && paperAmount > 0:
		insertTrash("paper")
		paperAmount -= 1
	
	if rand == 2 && plasticAmount > 0:
		insertTrash("plastic")
		plasticAmount -= 1
	
	if rand == 3 && metalAmount > 0:
		insertTrash("metal")
		metalAmount -= 1
	

func _ready():
	
	manager.topIndex = totalTrash
	
	var done = false
	
	while !done:
		
		totalTrash = paperAmount + plasticAmount + metalAmount
		
		spawnTrash()
		
		if totalTrash <= 0:
			done = true
		
	
