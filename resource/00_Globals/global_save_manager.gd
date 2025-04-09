extends Node

const SAVE_PATH = "user://"

signal  game_loaded
signal  game_saved

var current_save:Dictionary = {
	scene_path = "",
	player = {
		hp = 1,
		max_hp = 1,
		pos_x = 0,
		pos_y = 0
	},
	items = [],
	persistence = [],
	quests = []
}

func save_game():
	# 更新当前游戏状态
	_update_status_to_file()
	# 写入文件
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.WRITE)
	var save_json = JSON.stringify(current_save)
	file.store_line(save_json)
	game_saved.emit()
	
func load_game():
	# 加载文件信息
	var file := FileAccess.open(SAVE_PATH + "save.sav", FileAccess.READ)
	if file == null:
		return
	# 转换为json对象
	var json:= JSON.new()
	json.parse(file.get_line())
	current_save = json.get_data() as Dictionary
	
	# 加载场景
	LevelManager.load_scene(
		current_save
	)
	# 加载道具信息
	PauseManu.item_container.load_from_json(current_save)

# 更新游戏状态到当前保存文件中
func _update_status_to_file():
	# 角色信息
	var player:Player = PlayerManager.player
	current_save.player.hp = player.hp
	current_save.player.max_hp = player.max_hp
	current_save.player.pos_x = player.global_position.x
	current_save.player.pos_y = player.global_position.y
	
	# 场景信息
	for c in get_tree().root.get_children():
		if c is Level:
			current_save.scene_path = c.scene_file_path
			
	# 道具信息
	current_save.items = PauseManu.item_container.inventory_data.get_json_data()
	

# 向持久化数据中添加项
func add_persistence(value):
	if not check_persistence_exist(value):
		current_save.persistence.append(value)

# 查看持久化数据中是否存在项
func check_persistence_exist(value:String):
	if current_save.persistence.has(value):
		return true
	else:
		return false
