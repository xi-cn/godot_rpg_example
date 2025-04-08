class_name PlayerWalkState extends PlayerBaseState

var ani_name = "walk"
@onready var attack_state:PlayerBaseState = $"../AttackState"
@onready var idle_state:PlayerBaseState = $"../IdleState"

@export var speed:float = 200

func enter():
	var dir = (player.direction + player.cardinal_direction * 0.5).normalized()
	player.velocity = dir * speed
	player.update_animation(ani_name)

func do(_delata)->PlayerBaseState:
	# 方向
	var horizontal_dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_dir = Input.get_action_strength("down") - Input.get_action_strength("up")
	# 跳转闲置
	if horizontal_dir == 0 && vertical_dir == 0:
		return idle_state
	# 更新方向
	if player.set_direction(Vector2(horizontal_dir, vertical_dir)):
		player.update_animation(ani_name)
	# 更新速度
	var dir = (player.direction + player.cardinal_direction * 0.5).normalized()
	player.velocity = dir * speed
	return null

func exit():
	pass

func handle_input(event:InputEvent)->PlayerBaseState:
	# 点击攻击
	if event.is_action_pressed("attack"):
		return attack_state
	if event.is_action_pressed("interact"):
		player.Interacted.emit()
	return null
