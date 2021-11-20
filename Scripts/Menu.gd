extends Control

func _ready() -> void:
	pass



func _on_Play_pressed() -> void:
	get_tree().change_scene("res://Scenes/MainScene.tscn")
	pass

func _on_Options_pressed() -> void:
	pass

func _on_Quit_pressed() -> void:
	get_tree().quit()
	pass
