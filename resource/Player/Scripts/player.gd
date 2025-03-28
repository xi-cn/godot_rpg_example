class_name Player extends CharacterBody2D

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var cardinal_direction:Vector2
var direction:Vector2 = Vector2.DOWN
var invalunable:bool =false

signal Damaged(hurt_box:HurtBox)

@onready var sprite:Sprite2D = $Sprite2D
@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var state_machine:PlayerStateMachine = $PlayerStateMachine
@onready var audio:AudioStreamPlayer2D = $Audio/AudioStreamPlayer2D
@onready var hit_box:HitBox = $HitBox
@onready var hurt_box:HurtBox = $Sprite2D/AttackHurtBox

@export var hp:int = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.player = self
	# 初始化状态机
	state_machine.initialize(self)
	# 连接受伤信号
	hit_box.Damaged.connect(_on_damaged)
	# 关闭攻击检测
	hurt_box.monitoring = false
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	move_and_slide()

# 更新方向 方向改变则返回true
func set_direction(dir:Vector2)->bool:
	cardinal_direction = dir
	if dir == Vector2.ZERO:
		return false
	
	var dir_id:int = int(round((dir + direction * 0.1).angle() / TAU * DIR_4.size()))
	var new_dir = DIR_4[dir_id]
	
	if new_dir == direction:
		return false
	
	direction = new_dir
	if direction.x < 0:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
		
	return true

func animation_direction():
	if direction == Vector2.UP:
		return "up"
	elif direction == Vector2.DOWN:
		return "down"
	else:
		return "side"
	
func update_animation(state):
	animation_player.play(state + "_" + animation_direction())

func _on_damaged(hurt_box:HurtBox):
	if invalunable:
		return
	hp -= hurt_box.damage
	if hp > 0:
		Damaged.emit(hurt_box)
