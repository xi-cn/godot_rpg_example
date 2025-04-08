@tool

class_name TreasureChest extends Node


@onready var item_sprite:Sprite2D = $ItemSprite2D
@onready var quantity_label:Label = $ItemSprite2D/Label
@onready var area2d:Area2D = $Area2D
@onready var animation_player:AnimationPlayer = $AnimationPlayer
var opened:bool = false

@export var item:ItemData:
	set(value):
		item = value
		if Engine.is_editor_hint():
			set_item_texture(value)
		
@export var quantity:int:
	set(value):
		quantity = value
		if Engine.is_editor_hint():
			set_quantity(value)

func _ready() -> void:
	set_item_texture(item)
	set_quantity(quantity)
	area2d.area_entered.connect(area_enter)
	area2d.area_exited.connect(area_exit)

func area_enter(_a:Area2D):
	PlayerManager.player.Interacted.connect(open_treasure)
	
func area_exit(_a:Area2D):
	PlayerManager.player.Interacted.disconnect(open_treasure)

# 打开宝箱
func open_treasure():
	if opened:
		return
	opened = true
	animation_player.play("opened")
	PauseManu.item_container.inventory_data.add_item(item, quantity)

func set_item_texture(value:ItemData):
	item_sprite.texture = value.texture

func set_quantity(value):
	quantity_label.text = "x" + str(value)
