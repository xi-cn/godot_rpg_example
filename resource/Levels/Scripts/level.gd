class_name Level extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.y_sort_enabled = true
	PlayerManager.set_parent(self)
	# 连接切换场景信号
	LevelManager.level_loaded_started.connect(_on_level_loaded_started)
	# 连接场景切换完成信号
	LevelManager.level_loaded.connect(_on_level_loaded)
	
func _on_level_loaded_started():
	# 将玩家节点从场景节点中移除
	PlayerManager.un_parent(self)
	# 删除自身场景
	queue_free()
	

func _on_level_loaded():
	var transition_areas = $TranstionArea.get_children()
	for transition_area in transition_areas:
		transition_area.place_player()
