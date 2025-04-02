extends CanvasLayer

signal show()
signal hidden()

var is_paused:bool = false

@onready var save_button:Button = $Control/VBoxContainer/Button_Save
@onready var load_button:Button = $Control/VBoxContainer/Button_Load
@onready var item_description:Label = $Control/ItemDescription

func _ready() -> void:
	is_paused = false
	visible = false
	item_description.text = ""
	# 连接按钮点击事件
	save_button.pressed.connect(save_scene)
	load_button.pressed.connect(load_scene)
	pass



# 处理点击"escape"
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		if is_paused:
			hide_pause_manu()
		else:
			show_pause_manu()
		get_viewport().set_input_as_handled()
		

# 展示暂停界面
func show_pause_manu():
	get_tree().paused = true
	visible = true
	is_paused = true
	show.emit()
	

# 隐藏暂停界面
func hide_pause_manu():
	visible = false
	is_paused = false
	get_tree().paused = false
	hidden.emit()

# 保存场景
func save_scene():
	SaveManager.save_game()
	hide_pause_manu()
	
# 加载场景
func load_scene():
	SaveManager.load_game()
	hide_pause_manu()

# 设置描述文本
func set_description(text:String):
	item_description.text = text
	
