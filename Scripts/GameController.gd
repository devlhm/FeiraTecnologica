extends Node

signal score_updated(new_score)

var score : int = 0

func add_score() -> void:
	score += 1
	emit_signal("score_updated", score)
