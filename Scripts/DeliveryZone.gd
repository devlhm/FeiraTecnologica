class_name DeliveryZone
extends Area2D

export (int) var type: int = 0

func _ready() -> void:
	connect("body_entered", self, "on_body_entered")
	
func on_body_entered(body: Node) -> void:
	var _bodyTyped = (body as Player)
	
#	-- Placeholder until other items sprites:
	_bodyTyped.itemSprite.hide()
	GameController.add_score()
