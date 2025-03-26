class_name PlayerCamera extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.TileMapBoundsChanged.connect(update_camera_limit)
	update_camera_limit(LevelManager.cur_bounds)

# 更新相机限制
func update_camera_limit(bounds:Array[Vector2]):	
	if bounds.size() != 2:
		return
		
	limit_left = bounds[0].x
	limit_top = bounds[0].y
	limit_right = bounds[1].x
	limit_bottom = bounds[1].y
