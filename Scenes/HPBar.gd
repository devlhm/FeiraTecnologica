class_name HPBar
extends HBoxContainer

func remove_heart() -> void:
	if get_child_count() > 0:
		get_children()[get_child_count() - 1].queue_free()
