extends KinematicBody2D

export (int) var speed = 200

var velocity : Vector2 = Vector2()

var hole : Area2D = null
var carried_item : int = -1

func _ready():
	for hole in get_tree().get_nodes_in_group("hole"):
		hole.connect("area_entered", self, "on_hole_entered", [hole])
		hole.connect("area_exited", self, "on_hole_exited", [hole])
	
func get_input() -> void:
	velocity = Vector2()
	if Input.is_action_pressed("right"):
		velocity.x += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed

func _input(event):
	if event.is_action_pressed("interact") && hole != null:
		interact_with_hole()

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func on_hole_entered(area : Area2D, _hole : Area2D) -> void:
	print("hole entered")
	hole = _hole
	
func on_hole_exited(area : Area2D, _hole : Area2D) -> void:
	print("hole exited")
	hole = null

func interact_with_hole() -> void:
	if carried_item < 0:
		carried_item = hole.item
		print (carried_item)


func _on_DeliveryZone_area_entered(area : Area2D):
	if carried_item >= 0:
		carried_item = -1
		get_parent().add_score()
		print(carried_item)
