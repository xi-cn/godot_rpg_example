@tool
class_name TreasureChest extends Node


@onready var item_sprite:Sprite2D = $ItemSprite2D
@onready var quantity_label:Label = $ItemSprite2D/Label
@onready var area2d:Area2D = $Area2D
@onready var animation_player:AnimationPlayer = $AnimationPlayer

var opened:bool = false
var chest_id:String


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
	if Engine.is_editor_hint():
		return
	
	set_item_texture(item)
	set_quantity(quantity)
	area2d.area_entered.connect(area_enter)
	area2d.area_exited.connect(area_exit)
	# 宝箱ID
	var scene_path = get_tree().current_scene.scene_file_path
	var treasure_name = name
	chest_id = scene_path + "/" + treasure_name
	# 连接场景切换信号
	LevelManager.level_loaded.connect(load_treasure_status)
	print(chest_id)

func area_enter(_a:Area2D):
	PlayerManager.player.Interacted.connect(open_treasure)
	
func area_exit(_a:Area2D):
	PlayerManager.player.Interacted.disconnect(open_treasure)

# 打开宝箱
func open_treasure():
	if opened:
		return
	opened = true
	animation_player.play("open")
	PauseManu.item_container.inventory_data.add_item(item, quantity)
	save_treasure_status()

func set_item_texture(value:ItemData):
	if item_sprite == null:
		item_sprite = $ItemSprite2D
	item_sprite.texture = value.texture

func set_quantity(value):
	if quantity_label == null:
		quantity_label = $ItemSprite2D/Label
	quantity_label.text = "x" + str(value)
	
# 保存宝箱状态
func save_treasure_status():
	SaveManager.add_persistence(chest_id)

# 加载宝箱状态
func load_treasure_status():
	if SaveManager.check_persistence_exist(chest_id):
		opened = true
		animation_player.play("opened")
		
