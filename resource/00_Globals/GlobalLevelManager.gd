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
