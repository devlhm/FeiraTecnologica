extends Node

signal score_updated(new_score)

var score : int = 0
var lowering_duration_score = 3
signal lower_duration

func add_score() -> void:
	score += 1
	if score > lowering_duration_score:
		emit_signal("lower_duration")
		print("lower duration")
	emit_signal("score_updated", score)

func game_over() -> void:
	print("game over")
