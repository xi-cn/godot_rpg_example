class_name Enemy extends CharacterBody2D

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

var direction:Vector2 = Vector2.DOWN
var enemy:Enemy
var invalunable:bool = false

signal Damaged(hurt_box:HurtBox)
signal Destroyed(hurt_box:HurtBox)

@export var hp:int = 5

@onready var animation_player:AnimationPlayer = $AnimationPlayer
@onready var sprite:Sprite2D = $Sprite2D
@onready var state_machine:EnemyStateMachine = $EnemyStateMachine
@onready var hit_box:HitBox = $HitBox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 初始化状态机
	state_machine.initialize(self)
	# 连接受击信号
	hit_box.Damaged.connect(take_damage)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()
	
# 设置方向
func set_direction(id:int):
	direction = DIR_4[id]
	if direction == Vector2.LEFT:
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
		
# 获取动画方向
func animation_direction()->String:
	if direction == Vector2.DOWN:
		return "down"
	elif direction == Vector2.UP:
		return "up"
	else:
		return "side"

# 更新动画
func update_animation(state:String):
	animation_player.play(state + "_" + animation_direction())

# 受伤
func take_damage(hurt_box:HurtBox):
	if invalunable:
		return
	hp += hurt_box.damage
	if hp > 0:
		Damaged.emit(hurt_box)
	else:
		Destroyed.emit(hurt_box)
