class_name EnemyWalkState extends EnemyBaseState

@export var ani_name = "walk"
@export var speed:float = 50
@export_category("AI")
@export var state_repeat_min:int = 1
@export var state_repeat_max:float = 3
@export var next_state:EnemyBaseState

var repeat_num:int

func init():
	pass

func enter():
	repeat_num = randi_range(state_repeat_min, state_repeat_max)
	# 随机选择方向
	var dir_id = randi_range(0, 3)
	enemy.set_direction(dir_id)
	enemy.velocity = enemy.direction * speed
	enemy.update_animation(ani_name)
	# 连接动画结束信号
	enemy.animation_player.animation_finished.connect(_animation_finished)

func do(_delta)->EnemyBaseState:
	if repeat_num > 0:
		enemy.update_animation(ani_name)
		return null
	else:
		return next_state

func exit():
	enemy.animation_player.animation_finished.disconnect(_animation_finished)

func _animation_finished(_ani_name):
	repeat_num -= 1
