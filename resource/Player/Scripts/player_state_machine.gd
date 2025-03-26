class_name PlayerStateMachine extends Node

var cur_state:PlayerBaseState
var state_array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = PROCESS_MODE_DISABLED
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	change_state(cur_state.do(delta))


func initialize(_player:Player):
	state_array = get_children()
	
	if state_array.size() == 0:
		return
	
	for state in state_array:
		state.player = _player
		state.state_machine = self
		state.init()
	cur_state = state_array[0]
	cur_state.enter()
	process_mode = PROCESS_MODE_INHERIT

func change_state(state:PlayerBaseState):
	if state == null:
		return
	if state == cur_state:
		return 
	
	cur_state.exit()
	cur_state = state
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	change_state(cur_state.handle_input(event))
