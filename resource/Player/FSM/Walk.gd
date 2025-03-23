extends Player_Base

# 移动速度
@export var speed = 200

var horizontal_dir = 0
var vertical_dir = 0


func _ready() -> void:
	# 设置优先级
	priority = 1

func is_motivated()->bool:
	# 更新方向
	update_direction()
	return horizontal_dir != 0 || vertical_dir != 0
	

func enter():
	var flip = false
	# 更新角色方向 垂直优先
	if vertical_dir > 0:
		player.direction = "down"
	elif vertical_dir < 0:
		player.direction = "up"
	elif horizontal_dir > 0:
		player.direction = "side"
	elif horizontal_dir < 0:
		player.direction = "side"
		flip = true
	else:
		return
		
	# 翻转动画
	if flip:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
		
	# 播放动画
	animation_player.play("walk_"+player.direction)


func do( _delta : float ):
	# 判断方向是否改变
	if update_direction():
		# 更新方向和动画
		enter()
	# 结束行走
	if horizontal_dir == 0 && vertical_dir == 0:
		$"..".change_state(0)
		return	
		
	# 更新速度
	player.velocity = Vector2(horizontal_dir, vertical_dir)
	if horizontal_dir == 0 || vertical_dir == 0:
		player.velocity *= speed
	else:
		player.velocity *= speed / 1.414
	
	

func exit():
	pass

# 更新方向
func update_direction():
	# 水平
	var h_dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	var v_dir = Input.get_action_strength("down") - Input.get_action_strength("up")
	# 方向是否改变 垂直优先
	var dir_changed = false
	if v_dir != vertical_dir:
		dir_changed = true
	elif v_dir == 0 && h_dir != horizontal_dir:
		dir_changed = true
	
	# 更新方向
	horizontal_dir = h_dir
	vertical_dir = v_dir
	return dir_changed
		
