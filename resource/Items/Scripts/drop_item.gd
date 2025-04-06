class_name DropItem extends Resource

@export var item:ItemData
@export_range(0, 100, 1) var probability:float
@export_range(1, 10, 1) var min_amount:int
@export_range(1, 10, 1) var max_amount:int

# 获取掉落物的数量
func get_count():
	if randf_range(0, 100) >= probability:
		return 0
	else:
		return randi_range(min_amount, max_amount)
