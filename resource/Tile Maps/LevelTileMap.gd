class_name LevelTileMap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	LevelManager.set_tile_map_bounds(get_tilemap_bound())

# 获取地图边界
func get_tilemap_bound()->Array[Vector2]:
	var bounds:Array[Vector2] = [
		Vector2(get_used_rect().position * rendering_quadrant_size),
		Vector2(get_used_rect().end * rendering_quadrant_size)
	]
	
	return bounds
