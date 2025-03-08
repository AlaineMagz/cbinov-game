extends Node

var trashList : Array[Node2D]
var hoveredTrash: Array[Node2D]

var topTrash: Node2D
var topIndex: int

var isDragging = false

var score : int = 0

@export var scoreLabel : Label

func _physics_process(_delta):
	
	scoreLabel.text = "Score: " + str(score)
	
	if Input.is_action_just_pressed("ui_text_delete"):
		get_tree().reload_current_scene()
	
	if !isDragging:
		getTopTrash()
	
	if Input.is_action_pressed("interact") && topTrash != null:
		isDragging = true
		topTrash.isPicked = true
		topTrash.z_index = topIndex + 1
		topIndex += 1
	else: if topTrash != null:
		isDragging = false
		topTrash.isPicked = false
	

func getTopTrash():
	
	hoveredTrash.clear()
	topTrash = null
	
	for trash in trashList:
		if trash.isHovered:
			hoveredTrash.append(trash)
	
	for trash in hoveredTrash:
		
		if topTrash == null:
			topTrash = trash
		
		if trash.z_index > topTrash.z_index:
			topTrash = trash
		
	
	for trash in trashList:
		
		if trash == topTrash:
			trash.goOutline()
		else:
			trash.noOutline()
	

func addScore(value):
	score += value
	
	if score < 0:
		score = 0
	
