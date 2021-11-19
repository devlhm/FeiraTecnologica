class_name Player
extends KinematicBody2D

enum States { FREE, ACTION }

export (int) var speed = 200

var velocity : Vector2 = Vector2()
var state: int = States.FREE

var itemType: int = -1

onready var interactionTimer: Timer = ($InteractionTimer as Timer)
onready var sprite: AnimatedSprite = ($Sprite as AnimatedSprite)
onready var itemSprite: Sprite = ($ItemSprite as Sprite)

func get_input() -> void:
	var _inputVector = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	velocity = _inputVector.normalized() * speed

func _physics_process(_delta: float) -> void:
	match state:
		States.FREE:
			get_input()
			animate()
			
			velocity = move_and_slide(velocity)
			
		States.ACTION:
			sprite.play("Action")
			velocity = Vector2()

func interact() -> void:
	state = States.ACTION
	
	interactionTimer.start()
	yield(interactionTimer, "timeout")
	
	itemSprite.show()
	state = States.FREE

func animate() -> void:
	if velocity != Vector2.ZERO:
		sprite.play("Walk")
		
		if velocity.x != 0:
			sprite.flip_h = (velocity.x > 0)
	else:
		sprite.play("Idle")
