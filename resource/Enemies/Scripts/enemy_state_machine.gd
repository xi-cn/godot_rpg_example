class_name EnemyStateMachine extends EnemyBaseState

var current_state:EnemyBaseState
var state_array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(current_state.do(delta))

func initialize(_enemy:Enemy):
	enemy = _enemy
	state_array = get_children()
	# 初始化子状态
	for state in state_array:
		state.enemy = _enemy
		state.state_machine = self
		state.init()
	# 更当前状态
	if state_array.size() > 0:
		current_state = state_array[0]
		process_mode = PROCESS_MODE_INHERIT
	current_state.enter()

# 切换状态
func change_state(state:EnemyBaseState):
	if state == null || state == current_state:
		return
	
	if current_state != null:
		current_state.exit()
	
	current_state = state
	current_state.enter()
