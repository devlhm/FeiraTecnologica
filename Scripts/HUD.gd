extends Control

onready var scoreLabel: Label = ($Margin/ScoreLabel as Label)

func _ready() -> void:
	GameController.connect("score_updated", self, "on_score_updated")

func on_score_updated(new_score: int) -> void:
	scoreLabel.text = str(new_score)
