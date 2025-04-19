class_name PlayerInteractionHost extends Node2D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func update_direction(dir:Vector2)->void:
	match dir:
		Vector2.DOWN:
			rotation_degrees = 0
		Vector2.UP:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = -90
		_:
			rotation_degrees = 0
	pass
	
