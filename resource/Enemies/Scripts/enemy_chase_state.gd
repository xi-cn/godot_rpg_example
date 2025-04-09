class_name EnemyChaseState extends EnemyBaseState

@export var ani_name = "chase"
@export var chase_speed:float = 100
@export_category("AI")
@export var chase_time:float = 1.5
@export var next_state:EnemyBaseState

@onready var vision_area:Area2D = $"../../VisionArea"

var _timer:float 
var _see_player:bool

func init():
	_see_player = false
	vision_area.body_entered.connect(_body_enter)
	vision_area.body_exited.connect(_body_exit)
	pass

func enter():
	# 追随时间
	_timer = chase_time
	# 进入追随状态
	enemy.update_animation(ani_name)

	

func do(_delta)->EnemyBaseState:
	
	if not _see_player:
		_timer -= _delta
		if _timer <= 0:
			return next_state
	else:
		# 重置追随时间
		_timer = chase_time
	
	# 设置角色方向
	var chase_dir = enemy.global_position.direction_to(PlayerManager.player.global_position).normalized()	
	var dir_id:int = int(round((chase_dir + enemy.direction * 0.1).angle() / TAU * enemy.DIR_4.size()))
	if enemy.set_direction(dir_id):
		# 方向改变 更新动画
		enemy.update_animation(ani_name)
	
	# 追随速度
	var chase_vel = (chase_dir +  enemy.direction * 2).normalized() * chase_speed
	enemy.velocity = chase_vel
	
	return null

func exit():
	pass

func _body_enter(_b:Node2D):
	_see_player = true
	state_machine.change_state(self)
	
func _body_exit(_b:Node2D):
	_see_player = false
