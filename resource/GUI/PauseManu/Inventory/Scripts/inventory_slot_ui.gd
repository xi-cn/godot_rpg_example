class_name InventorySlotUi extends Button

var slot_data:SlotData
var item_index:int

signal item_used(index:int)

@onready var texture_rect:TextureRect = $TextureRect
@onready var label:Label = $Label
@onready var inventory_ui:InventoryUi = $".."


func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)
	pressed.connect(_on_pressed)

# 设置槽位ui数据
func set_slot_data(value:SlotData, index):
	item_index = index
	
	if value == null:
		return
	
	slot_data = value
	texture_rect.texture = value.item.texture
	label.text = str(value.quantity)


# 聚焦
func _on_focus_entered():
	# 设置描述文本
	if slot_data:
		PauseManu.set_description(slot_data.item.description)
	# 更新聚焦索引
	inventory_ui.focus_index = item_index
	

func _on_focus_exited():
	PauseManu.set_description("")
	
# 按下按钮使用
func _on_pressed():
	if slot_data and slot_data.item:
		if slot_data.item.use():
			slot_data.quantity -= 1
			item_used.emit(item_index)
