class_name BarredDoor extends Node2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func open_door():
	animation_player.play("open")
	
func close_door():
	animation_player.play("close")


func _on_pressure_plate_plate_activaed() -> void:
	open_door()


func _on_pressure_plate_plate_deactivaed() -> void:
	close_door()
