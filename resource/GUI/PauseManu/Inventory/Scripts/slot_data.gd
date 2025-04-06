class_name SlotData extends Resource

@export var item:ItemData
@export var quantity:int = 0

# 将槽内物品转化为保存的json格式
func parse_slot_to_json():
	var result = {item=null, quaitity=0}
	if item == null:
		return result
	
	result.item = item.resource_path
	result.quantity = quantity
	return result
