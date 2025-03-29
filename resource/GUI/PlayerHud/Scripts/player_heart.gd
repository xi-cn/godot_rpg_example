class_name PlayerHeart extends Control


func _ready() -> void:
	pass

func update_hear_gui(frame:int):
	$Sprite2D.frame = frame
