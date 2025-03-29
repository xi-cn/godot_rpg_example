extends Node2D


func _ready() -> void:
	self.visible = false
	PlayerManager.set_global_position(self.global_position)
