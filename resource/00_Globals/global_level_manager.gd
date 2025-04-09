extends Node


signal TileMapBoundsChanged(bounds:Array[Vector2])
signal level_loaded
signal level_loaded_started

var cur_bounds: Array[Vector2]
var target_scene:String
var transition_area:String

func set_tile_map_bounds(bounds:Array[Vector2]):
	cur_bounds = bounds
	TileMapBoundsChanged.emit(bounds)

# 切换场景
func switch_scene(
	_target_scene:String,
	_transition_area:String
)->void:
		
	target_scene = _target_scene
	transition_area = _transition_area

	# 淡出
	await SceneTranslation.fade_out()
	get_tree().paused = true
	
	await get_tree().process_frame
	level_loaded_started.emit()
	
	await get_tree().process_frame
	get_tree().change_scene_to_file(target_scene)
	
	# 淡入
	await get_tree().process_frame
	get_tree().paused = false
	
	await get_tree().process_frame
	level_loaded.emit()
	
	# 淡入
	await SceneTranslation.fade_in()
	
# 加载场景
func load_scene (
	load_msg:Dictionary
)->void:
	
	target_scene = load_msg.scene_path 
	
	get_tree().paused = true
	await get_tree().process_frame
	
	# 发送场景切换开始信号
	level_loaded_started.emit()
	await get_tree().process_frame
	
	# 切换场景
	get_tree().change_scene_to_file(target_scene)
	# 更新角色血量信息
	PlayerManager.player._update_player_hp(load_msg.player.hp, load_msg.player.max_hp)
	# 更新角色位置信息
	PlayerManager.set_global_position(Vector2(load_msg.player.pos_x, load_msg.player.pos_y))
	
	await get_tree().process_frame
	
	get_tree().paused = false
	
	level_loaded.emit()
