class_name EnemyDestroyState extends EnemyBaseState

@export var ani_name = "destroy"

@onready var hurt_box:HurtBox = $"../../HurtBox"
@onready var collision_shape:CollisionShape2D = $"../../CollisionShape2D"

func init():
	# 连接信号
	enemy.Destroyed.connect(_on_enemy_destroyed)
	pass

func enter():
	enemy.animation_player.animation_finished.connect(_on_animation_finished)
	enemy.velocity = Vector2.ZERO
	enemy.update_animation(ani_name)
	# 禁用攻击箱和碰撞箱
	hurt_box.monitoring = false
	collision_shape.queue_free()
	# 添加掉落物
	enemy.throw_items()


func do(_delta)->EnemyBaseState:
	return null

func exit():
	pass
	
func _on_enemy_destroyed(hurt_box:HurtBox):
	state_machine.change_state(self)

func _on_animation_finished(_ani_name):
	enemy.call_deferred("queue_free")
