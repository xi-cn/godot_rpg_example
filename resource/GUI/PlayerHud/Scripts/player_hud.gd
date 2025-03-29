class_name PlayerHud extends CanvasLayer

var heart_array:Array[PlayerHeart] = []

@onready var heart_container:HFlowContainer = $Control/HFlowContainer
@export var max_heart_num:int = 20

func _ready() -> void:
	var heart_scene = preload("res://resource/GUI/PlayerHud/PlayerHeart.tscn")
	# 实例化heart节点
	for i in range(max_heart_num):
		heart_container.add_child(heart_scene.instantiate())
	for child in heart_container.get_children():
		if child is PlayerHeart:
			child.visible = false
			heart_array.append(child)

# 更新hp
func update_hp(hp:int, max_hp:int):
	var heart_num = ceil(max_hp / 2.0)
	for idx in range(max_heart_num):
		if idx >= heart_num:
			heart_array[idx].visible = false
		else:
			heart_array[idx].visible = true
			heart_array[idx].update_hear_gui(clampi(hp - idx * 2, 0, 2))
			
		
	
