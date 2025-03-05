extends CharacterBody2D

@export_category("Gameplay Variables")
@export var SPEED = 500

@export_category("Bin Sprites")
@export var PaperBin: Node2D
@export var PlasticBin: Node2D
@export var MetalBin: Node2D

## Animation State #0 is Idle, #1 is Down, and #2 is Up
var animationState = 0
var binChanged = false
@export_category("Animation Variables")
@export var animPlayer: AnimationPlayer
@export var animTree: AnimationTree

## Bin #0 is Paper, Bin #1 is Plastic, and Bin #2 is Metal
var activeBin = 0

func _physics_process(delta: float) -> void:
	
	velocity.x = Input.get_axis("left", "right") * SPEED
	
	if Input.is_action_just_pressed("interact") && animationState == 0:
		if activeBin == 2:
			activeBin = 0
			binChanged = true
		else:
			activeBin += 1
			binChanged = true
	
	if Input.is_action_just_pressed("alt_interact") && animationState == 0:
		if activeBin == 0:
			activeBin = 2
			binChanged = true
		else:
			activeBin -= 1
			binChanged = true
	
	if(binChanged && animationState == 0):
		animTree.down = true
		animationState = 1
	
	move_and_slide()

func changeActiveBin(newBin): 
	
	if newBin == 0:
		PlasticBin.visible = false
		MetalBin.visible = false
		PaperBin.visible = true
	else: if newBin == 1:
		PaperBin.visible = false
		MetalBin.visible = false
		PlasticBin.visible = true
	else: if newBin == 2:
		PaperBin.visible = false
		PlasticBin.visible = false
		MetalBin.visible = true
	

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	
	if anim_name == "Minigame1/BinDown":
		animationState = 2
		changeActiveBin(activeBin)
		animTree.down = false
		binChanged = false
	
	if anim_name == "Minigame1/BinUp":
		animationState = 0
	
