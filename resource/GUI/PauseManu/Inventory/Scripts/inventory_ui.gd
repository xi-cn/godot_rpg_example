class_name InventoryUi extends Control

# 槽位场景
const INVENTORY_SLOT = preload("res://resource/GUI/PauseManu/Inventory/inventory_slot.tscn")
# 库存数据
@export var inventory_data:InventoryData

var focus_index:int = 0

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
	for i in inventory_data.slots.size():
		var new_slot = INVENTORY_SLOT.instantiate()
		# 设置槽位数据
		new_slot.call_deferred("set_slot_data", inventory_data.slots[i], i)
		# 连接物品用完信号
		call_deferred("connect_item_used", new_slot)
		add_child(new_slot)

	get_child(focus_index).call_deferred("grab_focus")

# 连接物品用完信号
func connect_item_used(slot:InventorySlotUi):
	slot.item_used.connect(_on_item_used)

# 用完物品
func _on_item_used(item_index:int):
	if inventory_data.slots[item_index].quantity == 0:
		inventory_data.slots[item_index] = null
	clear_inventory()
	await get_tree().process_frame
	update_inventory()
