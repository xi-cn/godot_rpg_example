class_name InventorySlotUi extends Button

var slot_data:SlotData

@onready var texture_rect:TextureRect = $TextureRect
@onready var label:Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	
	focus_entered.connect(_on_focus_entered)
	focus_exited.connect(_on_focus_exited)

# 设置槽位ui数据
func set_slot_data(value:SlotData):
	slot_data = value
	texture_rect.texture = value.item.texture
	label.text = str(value.quantity)

# 设置描述文本
func _on_focus_entered():
	PauseManu.set_description(slot_data.item.description)

func _on_focus_exited():
	PauseManu.set_description("")
	
