extends CharacterBody3D

@export var base_speed: float = 5.0
@export var run_speed: float = 5.0

@export var jump_height: float
@export var jump_time_to_peak: float
@export var jump_time_to_descent: float


@onready var jump_velocity: float = (2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity: float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity: float = (2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)


var movement_input = Vector2.ZERO
@onready var camera = $CameraController/Camera3D

func _physics_process(delta: float) -> void:
	#velocity = Vector3(movement_input.x, 0, movement_input.y) * base_speed
	move_logic(delta)
	jump_logic(delta)
	move_and_slide()

func move_logic(delta: float):
	movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-camera.global_rotation.y)
	var vel_2d = Vector2(velocity.x, velocity.z)
	var is_running: bool = Input.is_action_pressed("run")

	if movement_input != Vector2.ZERO:
		var speed = run_speed if is_running else base_speed
		vel_2d += movement_input * speed * delta
		vel_2d = vel_2d.limit_length(speed)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y
	else:
		vel_2d = vel_2d.move_toward(Vector2.ZERO, base_speed * 5.0 * delta)
		velocity.x = vel_2d.x
		velocity.z = vel_2d.y


func jump_logic(delta: float) -> void:
	if Input.is_action_just_pressed("jump") && is_on_floor():
		jump()
	var gravity = get_the_gravity()
	velocity.y -= gravity * delta


func get_the_gravity() -> float:
	return jump_gravity if velocity.y > 0.0 else fall_gravity


func jump():
	velocity.y = jump_velocity