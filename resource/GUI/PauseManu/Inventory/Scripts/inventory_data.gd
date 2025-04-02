class_name InventoryData extends Resource

@export var slots:Array[SlotData]

func add_item(item:ItemData)->bool:
	# 查看是否有相同的物品
	for slot in slots:
		if slot and slot.item.name == item.name and slot.quantity < slot.item.max_num_one_grid:
			slot.quantity += 1
			return true
	# 查看是否有null
	for index in slots.size():
		if slots[index] == null:
			slots[index] = SlotData.new()
			slots[index].item = item
			slots[index].quantity = 1
			return true
	
	return false
