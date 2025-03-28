class_name PlayerStunState extends PlayerBaseState

var ani_name = "stun"
var animation_finished:bool
var knockback_direction:Vector2

@export var knockback_speed:float = 100
@export var speed_declay_rate = 2
@export var next_state:PlayerBaseState


func init():
	player.Damaged.connect(_on_damaged)

func enter():
	# 无敌
	player.invalunable = true
	# 连接动画结束信号
	animation_finished = false
	player.animation_player.animation_finished.connect(_on_animation_finished)
	# 击退速度
	player.velocity = knockback_direction * knockback_speed
	player.update_animation(ani_name)

func do(_delata)->PlayerBaseState:
	if animation_finished:
		return next_state
	player.velocity -= player.velocity * speed_declay_rate * _delata
	return null
		

func exit():
	# 取消无敌 取消连接
	player.invalunable = false
	player.animation_player.animation_finished.disconnect(_on_animation_finished)

func handle_input(event:InputEvent)->PlayerBaseState:
	return null
	
func _on_damaged(hurt_box:HurtBox):
	# 设置击退方向
	knockback_direction = -player.global_position.direction_to(hurt_box.global_position)
	state_machine.change_state(self)

func _on_animation_finished(ani_name):
	animation_finished = true
