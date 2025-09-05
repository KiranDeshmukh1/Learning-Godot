extends Node3D


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_from_vector(event.relative * 0.005)
		
		
# Called when the node enters the scene tree for the first time.
func rotate_from_vector(vec: Vector2):
	if vec.length() == 0: return
	rotation.y -= vec.x
	rotation.x -= vec.y
	rotation.x = clamp(rotation.x, -0.1, 0.3)


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
