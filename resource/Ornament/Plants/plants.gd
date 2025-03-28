class_name Plants extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$HitBox.Damaged.connect(TakeDamage)


func TakeDamage(hurt_box:HurtBox)->void:
	queue_free()
