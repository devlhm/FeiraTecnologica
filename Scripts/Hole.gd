class_name Hole
extends Area2D

var icons_path : String = "res://Sprites/Icons/"

var item: int = ItemTypes.PEBD

onready var sprite: AnimatedSprite = ($Sprite as AnimatedSprite)
func _ready() -> void:
	if !is_in_group("hole"):
		add_to_group("hole")
	
	randomize()
	sprite.frame = randi() % 2
	
	
func set_type(type : int) -> void:
	item = type
	
	var icon_texture : Resource = load(icons_path + str(type + 2) + "gun.png")
	var icon_sprite: Sprite = ($Sign/Icon as Sprite)
	icon_sprite.texture = icon_texture

func _input(event: InputEvent) -> void:
	var _overlappingBodies: Array = get_overlapping_bodies()
	
	if event.is_action_pressed("interact") and _overlappingBodies.size() > 0:
		(_overlappingBodies[0] as Player).interact(item)

	
