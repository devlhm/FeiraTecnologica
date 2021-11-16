extends Node2D

var score : int = 0

func add_score() -> void:
	score += 1
	
	update_hud()
	
func update_hud() -> void:
	$HUD/ScoreLabel.text = String(score)
