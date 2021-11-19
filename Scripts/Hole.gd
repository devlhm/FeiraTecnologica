class_name Hole
extends Area2D

export(
	int,
	"PET",
	"PEAD",
	"PEBD",
	"PVC",
	"PP",
	"PS"
) var item: int = ItemTypes.PET

onready var sprite: Sprite = ($Sprite as Sprite)

func _ready() -> void:
	add_to_group("hole")
	sprite.frame = randi() % sprite.hframes

func _input(event: InputEvent) -> void:
	var _overlappingBodies: Array = get_overlapping_bodies()
	
	if event.is_action_pressed("interact") and _overlappingBodies.size() > 0:
		(_overlappingBodies[0] as Player).interact(item)

	
