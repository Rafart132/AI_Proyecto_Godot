extends CharacterBody3D

@export var speed: float = 2.5
@export var jump_force: float = 7.0
@export var gravity: float = 20.0

var is_jumping = false
var last_direccion = "ilde_D"

@onready var anim:AnimatedSprite3D = $AnimatedSprite3D

func _ready():
	pass

func _physics_process(_delta: float) -> void:
	handle_movement(_delta)
	handle_jump()
	apply_gravity(_delta)
	move_and_slide()

	update_animation()  # Actualiza la animación según el estado actual

func handle_movement(_delta: float) -> void:
	var direction = Vector3.ZERO

	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.z = Input.get_axis("ui_up", "ui_down")

	if direction != Vector3.ZERO:
		direction = direction.normalized()
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = 0
		velocity.z = 0

func handle_jump() -> void:
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force
		is_jumping = true

func apply_gravity(_delta: float) -> void:
	if !is_on_floor() or is_jumping:
		velocity.y -= gravity * _delta
	else:
		velocity.y = 0
		is_jumping = false


func update_animation() -> void:
	# Cambia la animación según la dirección de movimiento y guardando la ultima direccion
	if velocity.length() > 0.1 and is_on_floor():
		if abs(velocity.z) > abs(velocity.x):
			if velocity.z > 0:
				anim.play("walk_D")
				last_direccion = "ilde_D"
			else:
				anim.play("walk_U")
				last_direccion = "ilde_U"
		else:
			if velocity.x > 0:
				anim.play("walk_R")
				last_direccion = "ilde_R"
			else:
				anim.play("walk_L")
				last_direccion = "ilde_L"
	else:
		anim.play(last_direccion)
