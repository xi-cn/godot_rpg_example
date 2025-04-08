class_name PlayerIdleState extends PlayerBaseState

var ani_name = "idle"

@onready var walk_state:PlayerBaseState = $"../WalkState"
@onready var attack_state:PlayerBaseState = $"../AttackState"

func enter():
	player.velocity = Vector2.ZERO
	player.update_animation(ani_name)

func do(_delata)->PlayerBaseState:
	# 方向
	var horizontal_dir = Input.get_action_strength("right") - Input.get_action_strength("left")
	var vertical_dir = Input.get_action_strength("down") - Input.get_action_strength("up")
	# 跳转到行走动画
	if horizontal_dir != 0 || vertical_dir != 0:
		player.set_direction(Vector2(horizontal_dir, vertical_dir))
		return walk_state
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
	
