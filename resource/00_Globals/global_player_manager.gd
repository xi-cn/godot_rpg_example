extends Node


var player:Player

func _ready():
	add_player_instance()

# 添加玩家节点
func add_player_instance():
	var player_scene =  preload("res://resource/Player/player.tscn")
	player = player_scene.instantiate()
	add_child(player)

# 设置父节点
func set_parent(node:Node):
	if player.get_parent():
		player.get_parent().remove_child(player)
	node.call_deferred("add_child", player)

# 设置全局位置
func set_global_position(position:Vector2):
	player.global_position = position

# 取消父节点
func un_parent(node:Node):
	node.remove_child(player)
