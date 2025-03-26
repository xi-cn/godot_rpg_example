class_name PlayerAttackState extends PlayerBaseState

var ani_name = "attack"
var animation_finished:bool = false

@onready var idle_state:PlayerBaseState = $"../IdleState"
@onready var walk_state:PlayerBaseState = $"../WalkState"
@onready var attack_effect_animation_player:AnimationPlayer = $"../../Sprite2D/AttackEffectSprite/AnimationPlayer"

@export var speed_declay_rate = 5
@export var attack_sound:AudioStream


func enter():
	animation_finished = false
	player.update_animation(ani_name)
	# 播放动画
	player.animation_player.animation_finished.connect(_on_animation_finished)
	attack_effect_animation_player.play(ani_name + "_" + player.animation_direction())
	# 播放音效
	player.audio.stream = attack_sound
	player.audio.pitch_scale = randf_range(0.9, 1.1)
	player.audio.play()
	
	
func do(_delata)->PlayerBaseState:
	player.velocity -= player.velocity * speed_declay_rate * _delata
	if !animation_finished:
		return null
	
	# 方向
	var horizontal_dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_dir = Input.get_action_strength("down") - Input.get_action_strength("up")
	# 跳转到行走动画
	if horizontal_dir != 0 || vertical_dir != 0:
		player.set_direction(Vector2(horizontal_dir, vertical_dir))
		return walk_state
	else:
		return idle_state

func exit():
	player.animation_player.animation_finished.disconnect(_on_animation_finished)

func handle_input(event:InputEvent)->PlayerBaseState:
	# 点击攻击
	if event.is_action_pressed("attack"):
		player.update_animation(ani_name)
	return null

func _on_animation_finished(ani_name):
	animation_finished = true
