extends Node2D

var score: int = 0

@export var scoreLabel: Label

func _ready():
	
	if Input.is_action_just_pressed("ui_text_delete"):
		get_tree().reload_current_scene()
	
	scoreLabel.text = "Score: " + str(score)
	

func _physics_process(delta):
	
	if Input.is_action_just_pressed("ui_text_delete"):
		get_tree().reload_current_scene()
	
	scoreLabel.text = "Score: " + str(score)
	


func _on_interior_left_body_entered(body):
	
	if body.name.contains("collectible"):
		
		if body.name.contains("paper") || body.name.contains("plastic") || body.name.contains("metal") || body.name.contains("glass"):
			score += 10
		else:
			score = maxi(0, score - 10)
		
		body.queue_free()
	


func _on_interior_right_body_entered(body):
	
	if body.name.contains("collectible"):
		
		if body.name.contains("organic"):
			score += 10
		else:
			score = maxi(0, score - 10)
		
		body.queue_free()
	
