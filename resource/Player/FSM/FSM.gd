extends Player_Base

var current_state:Player_Base
var state_array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 初始化静态变量
	player = $".."
	animation_player = $"../AnimationPlayer"
	sprite = $"../Sprite2D"
	audio = $"../Audio/AudioStreamPlayer2D"
	# 子状态列表
	state_array = get_children()
	# 当前状态为闲置状态
	current_state = $Idle
	current_state.enter()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# 遍历查看是否有状态被激发
	for i in range(state_array.size()):
		# 优先级更高且被触发
		if state_array[i].priority > current_state.priority &&state_array[i].is_motivated():
			change_state(i)
			break
			
	current_state.do(delta)
	player.move_and_slide()

# 且换状态
func change_state(state_id:int):
	current_state.exit()
	current_state = state_array[state_id]
	current_state.enter()
