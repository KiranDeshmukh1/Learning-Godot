extends CharacterBody3D

@export var base_speed: float = 5.0

var movement_input = Vector2.ZERO
@onready var camera = $CameraController/Camera3D

func _physics_process(_delta: float) -> void:
	movement_input = Input.get_vector("left", "right", "forward", "backward").rotated(-camera.global_rotation.y)
	velocity = Vector3(movement_input.x, 0, movement_input.y) * base_speed
	print(camera.global_rotation.y)
	move_and_slide()
