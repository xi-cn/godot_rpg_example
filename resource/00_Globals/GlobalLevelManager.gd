extends Node


signal TileMapBoundsChanged(bounds:Array[Vector2])
var cur_bounds: Array[Vector2]

func set_tile_map_bounds(bounds:Array[Vector2]):
	cur_bounds = bounds
	TileMapBoundsChanged.emit(bounds)
