@tool
class_name LevelTransition extends Area2D

@onready var sprite:Sprite2D = $Sprite2D
@onready var collision_shape:CollisionShape2D = $CollisionShape2D

# 目标场景
@export_file("*.tscn") var level
# 目标传送门
@export var target_transition_area:String  = "LevelTransition"
@export var teleport_target_offset: Vector2 = Vector2.ZERO:
	set(v):
		teleport_target_offset = v
		if Engine.is_editor_hint():
			update_landing_position(v)

# 修改检测区域大小
@export var transition_size:Vector2 = Vector2(1, 1) :
	set(v):
		transition_size = v.max(Vector2(1, 1))
		if Engine.is_editor_hint():
			update_transition_size(v)


func _ready() -> void:
	update_landing_position(teleport_target_offset)
	update_transition_size(transition_size)
	body_entered.connect(on_body_entered)
	sprite.visible = false

func update_landing_position(v:Vector2):
	if not is_instance_valid(sprite):
		sprite = $Sprite2D
	sprite.position = v * 16

func update_transition_size(v:Vector2):
	if not is_instance_valid(collision_shape):
		collision_shape = $CollisionShape2D
	collision_shape.shape.size = v * 32

func on_body_entered(body:Node2D):
	# 切换场景
	LevelManager.switch_scene(level, target_transition_area)
	pass

func place_player():
	if name == LevelManager.transition_area:
		# 设置玩家传送地点
		PlayerManager.set_global_position(get_offset())

func get_offset()->Vector2:
	return self.global_position + sprite.position
