extends Player_Base

var is_attacking = false

@export var attack_sound:AudioStream
@export_range(1, 20, 0.5) var decelerate_speed : float = 5.0
@onready var animation_attack:AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"
@onready var hurt_box:HurtBox = $"../../Sprite2D/AttackHurtBox"

func _ready() -> void:
	# 设置优先级
	priority = 2

func is_motivated()->bool:
	# 点击攻击
	return Input.is_action_pressed("attack")

func enter():
	# 播放动画
	var dir = player.direction
	animation_player.play("attack_" + dir)
	animation_attack.play("attack_" + dir)
	# 播放声音
	audio.stream = attack_sound
	audio.pitch_scale = randf_range(0.9, 1.1)
	audio.play()
	# 连接动画结束信号
	animation_player.animation_finished.connect(EndAttack)
	is_attacking = true
	
	await get_tree().create_timer(0.075).timeout
	hurt_box.monitoring = true

func do( _delta : float ):
	# 动画结束 切换闲置
	if is_attacking == false:
		$"..".change_state(0)
	# 更新速度
	player.velocity -= player.velocity * decelerate_speed * _delta

func exit():
	# 断开连接
	animation_player.animation_finished.disconnect(EndAttack)
	hurt_box.monitoring = false

func EndAttack( _newAnimName : String ):
	is_attacking = false
