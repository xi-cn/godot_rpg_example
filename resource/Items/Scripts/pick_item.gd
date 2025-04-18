@tool

class_name PickItem extends CharacterBody2D



@onready var sprite2d:Sprite2D = $Sprite2D
@onready var area2d:Area2D = $Area2D

@export var item:ItemData:
	set(value):
		item = value
		if Engine.is_editor_hint():
			update_texture(value)
		else:
			update_texture(value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_texture(item)
	# 连接用户靠近信号
	area2d.body_entered.connect(_on_body_entered)


# 更新图片材质
func update_texture(value:ItemData):
	if sprite2d == null:
		sprite2d = $Sprite2D
	sprite2d.texture = value.texture


# 玩家靠近
func _on_body_entered(body:Node2D):
	# 捡起掉落物
	if PauseManu.pick_up_item(item):
		self.call_deferred("queue_free")
	else:
		pass
		
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	velocity -= velocity * delta * 4
