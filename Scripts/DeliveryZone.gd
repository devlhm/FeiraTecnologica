class_name DeliveryZone
extends Area2D

export (ItemTypes.Types) var type: int = 0
export (float, 0.05, 1, 0.05) var request_chance
export (float) var request_base_interval = 7
export var request_interval_rand : float = 2
export (float) var request_duration = 10
export (float) var request_min_duration = 5
export var request_duration_subtrahend : float = .2

var requesting : bool = false
var lower_duration : bool = false

signal item_received
signal delivery_timeout

var player : Player
var hp_bar : HPBar

func _ready() -> void:
	hp_bar = get_tree().get_nodes_in_group("hp_bar")[0]
	player = get_tree().get_nodes_in_group("player")[0]
	
	connect_signals()
	
	$DeliveryTimeBar.max_value = request_duration
	$DeliveryTimeBar.value = request_duration
	
	request_coroutine()
	
func connect_signals() -> void:
	connect("body_entered", self, "on_body_entered")
	connect("item_received", self, "on_item_received")
	connect("delivery_timeout", player, "lose_life")
	connect("delivery_timeout", hp_bar, "remove_heart")
	GameController.connect("lower_duration", self, "on_lower_duration")
	
func on_body_entered(body: Node) -> void:
	var _bodyTyped = (body as Player)
	var itemType = _bodyTyped.get_item_type()
	
	if itemType == type and requesting:
		_bodyTyped.empty_item()
		emit_signal("item_received")
	else:
		# error sound or something like that
		pass
		
func on_lower_duration():
	lower_duration = true
	
func lower_duration():
	var new_request_duration = request_duration - request_duration_subtrahend
	if(new_request_duration <= request_min_duration):
		lower_duration = false
		new_request_duration = request_min_duration
		
	request_duration = new_request_duration
	
	print(request_duration)

func request_coroutine():
	var request_interval = request_base_interval + rand_range(request_interval_rand * -1, request_interval_rand)
	
	if lower_duration:
		lower_duration()
	yield(get_tree().create_timer(request_interval), "timeout")
	if randf() < request_chance:
		print("request: " + str(type))
		start_request()
		
		yield(self, "item_received")
		
	#loop
	request_coroutine()

func start_request():
	requesting = true
	$RightSFX.play()
	$RightSFX.pitch_scale = rand_range(0.9, 1.1)
	$Exclamation.show()
	$DeliveryTimeBar.show()
	$DeliveryTimeTween.interpolate_property($DeliveryTimeBar, "value", $DeliveryTimeBar.value, 0, request_duration)
	$DeliveryTimeTween.start()

func _on_delivery_timeout(_object: Object, _key: NodePath) -> void:
	emit_signal("delivery_timeout")
	requesting = false
	
	yield(get_tree().create_timer(1.0), "timeout")
	
	reset_request()
	
func reset_request() -> void:
	$Exclamation.hide()
	$DeliveryTimeBar.hide()
	$DeliveryTimeBar.value = $DeliveryTimeBar.max_value
	$DeliveryTimeTween.stop_all()
	

func on_item_received() -> void:
	requesting = false
	print("item received")
	$Exclamation.hide()
	$DeliveryTimeBar.hide()
	$DeliveryTimeBar.value = $DeliveryTimeBar.max_value
	$DeliveryTimeTween.stop_all()
	
	#	-- Placeholder until other items sprites:
	GameController.add_score()
