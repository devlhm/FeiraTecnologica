class_name GameoverScreen
extends Control

onready var getScoreAPI : HTTPRequest = $getScore
onready var setScoreAPI : HTTPRequest = $setScore
onready var scoreboardLabel : Label = $Center/Container/Margin/Vertical/ScoreboardContainer/Scoreboard
onready var input : LineEdit = $Center/Container/Margin/Vertical/InputContainer/Input

func _ready() -> void:
	getScore()
	pass

func getScore() -> void:
	getScoreAPI.request("http://dreamlo.com/lb/619bfe718f40bb12787e2392/json/5")
	pass
	
func setScore(name: String, score: int) -> void:
	setScoreAPI.request("http://dreamlo.com/lb/KIe4ZhFPoUyl5pM4zm8b_w9Jbthb2Ug0Cn8kNqk4LQvg/add/" + name + "/" + String(score))
	pass


func _on_getScore_request_completed(result: int, response_code: int, headers: Array, body: PoolByteArray) -> void:
	scoreboardLabel.text = ""
	if (response_code == 200):
		var json : JSONParseResult = JSON.parse(body.get_string_from_utf8())
		var res : Dictionary = json.result
		if (res["dreamlo"]["leaderboard"]):
			var resScore = res["dreamlo"]["leaderboard"]["entry"]
			if (typeof(resScore) == 18):
				scoreboardLabel.text += resScore["name"] + " - " + resScore["score"] + "\n"
			elif (typeof(resScore) == 19):
				for score in resScore:
					scoreboardLabel.text += score["name"] + " - " + score["score"] + "\n"
		else:
			scoreboardLabel.text = "Envie o seu placar"
	else:
		scoreboardLabel.text = "Placar não disponível"


func _on_setScore_request_completed(result, response_code, headers, body) -> void:
	if (response_code == 200):
		scoreboardLabel.text = ""
		getScore()
	pass
	

func _on_Submit_pressed() -> void:
	if (input.text):
		setScore(input.text, int($"/root/GameController".score))
		input.text = ""
	pass


func _on_Quit_pressed() -> void:
	get_tree().quit()
	pass

func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainScene.tscn")
	pass
