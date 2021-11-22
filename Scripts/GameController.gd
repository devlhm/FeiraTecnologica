extends Node

signal score_updated(new_score)
signal game_over

var score : int = 0
var lowering_duration_score = 3
signal lower_duration

func _ready() -> void:
	set_hole_types()

func set_hole_types() -> void:
	var holes : Array = get_tree().get_nodes_in_group("hole")
	
	var types = ItemTypes.Types.values()
	for hole in holes:
		randomize()
		var i = randi() % types.size() if types.size() > 1 else 0
		var type = types[i]
		types.remove(i)
		
		hole.set_type(type)
		i += 1
		pass

func add_score() -> void:
	score += 1
	if score > lowering_duration_score:
		emit_signal("lower_duration")
		print("lower duration")
	emit_signal("score_updated", score)

func game_over() -> void:
	emit_signal("game_over")
	
