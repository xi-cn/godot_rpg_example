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


# 获取库存数据的json格式
func get_json_data():
	var result = []
	for slot in slots:
		if slot == null:
			result.append(null)
		else:
			result.append(slot.parse_slot_to_json())
	return result
	
# 加载json数据到库存数据
func load_from_json(load_data:Dictionary):
	var items = load_data.items
	slots.clear()
	slots.resize(items.size())
	for i in range(slots.size()):
		if items[i] == null or items[i].item == null:
			continue
		var new_slot:SlotData = SlotData.new()
		new_slot.item = load(items[i].item)
		new_slot.quantity = items[i].quantity

		slots[i] = new_slot
