class_name EnemyStunState extends EnemyBaseState

@export var ani_name = "stun"
@export var knockback_speed:float = 50
@export var speed_declay_rate = 2
@export var next_state:EnemyBaseState

var animation_finished:bool = false
var knockback_direction:Vector2

func init():
	# 连接信号
	enemy.Damaged.connect(_on_enemy_damaged)
	pass

func enter():
	# 无敌状态
	enemy.invalunable = true
	
	animation_finished = false
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	
	enemy.velocity = knockback_direction * knockback_speed
	enemy.update_animation(ani_name)


func do(_delta)->EnemyBaseState:
	if animation_finished:
		return next_state
	enemy.velocity -= enemy.velocity * speed_declay_rate * _delta
	return null

func exit():
	enemy.animation_player.animation_finished.disconnect(_on_animation_finished)
	# 取消无敌状态
	enemy.invalunable = false
	
func _on_enemy_damaged(hurt_box:HurtBox):
	# 击退速度
	knockback_direction = -enemy.global_position.direction_to(hurt_box.global_position)
	state_machine.change_state(self)

func _on_animation_finished(_ani_name):
	animation_finished = true
