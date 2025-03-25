class_name EnemyIdleState extends EnemyBaseState

@export var ani_name = "idle"
@export_category("AI")
@export var state_duration_min:float = 0.5
@export var state_duration_max:float = 1.5
@export var next_state:EnemyBaseState

var _timer:float

func init():
	pass

func enter():
	enemy.velocity = Vector2.ZERO
	enemy.update_animation(ani_name)
	_timer = randf_range(state_duration_min, state_duration_max)


func do(_delta)->EnemyBaseState:
	_timer -= _delta
	# 时间到 停止状态
	if _timer >= 0:
		return null
	else:
		return next_state

func exit():
	pass
