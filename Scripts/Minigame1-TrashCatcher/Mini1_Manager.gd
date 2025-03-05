extends Node

var score: int = 0

@export var bins: Node2D
@export var scoreLabel: Label

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_text_delete"):
		get_tree().reload_current_scene()
	
	scoreLabel.text = "Score: " + str(score)
	
	print(bins.activeBin)
	


func _on_interior_area_body_entered(body):
	
	if body.name.contains("collectible"):
		
		if body.name.contains("paper") && bins.activeBin == 0:
			score += 10
		else: if body.name.contains("paper"):
			score = maxi(0, score - 30)
		
		if body.name.contains("plastic") && bins.activeBin == 1:
			score += 10
		else: if body.name.contains("plastic"):
			score = maxi(0, score - 30)
		
		if body.name.contains("metal") && bins.activeBin == 2:
			score += 10
		else: if body.name.contains("metal"):
			score = maxi(0, score - 30)
		
		body.queue_free()
	
