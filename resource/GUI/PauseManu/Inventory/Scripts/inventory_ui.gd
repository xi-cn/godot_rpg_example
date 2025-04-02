extends Control

# 槽位场景
const INVENTORY_SLOT = preload("res://resource/GUI/PauseManu/Inventory/inventory_slot.tscn")
# 库存数据
@export var inventory_data:InventoryData

func _ready() -> void:
	# 连接展示和隐藏信号
	PauseManu.show.connect(update_inventory)
	PauseManu.hidden.connect(clear_inventory)
	# 清除子节点
	clear_inventory()

# 清除子节点
func clear_inventory():
	for c in get_children():
		c.queue_free()
		
# 更新库存数据
func update_inventory():
	# 根据库存数据添加槽位
	for c in inventory_data.slots:
		var new_slot = INVENTORY_SLOT.instantiate()
		# 设置槽位数据
		new_slot.call_deferred("set_slot_data", c)
		add_child(new_slot)
	
	get_child(0).call_deferred("grab_focus")
