extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
func _on_body_entered(b_:Node2D):
	if b_ is PushStatue:
		b_.set_direction(PlayerManager.player.direction)
		
func _on_body_exited(b_:Node2D):
	if b_ is PushStatue:
		b_.set_direction(Vector2.ZERO)
