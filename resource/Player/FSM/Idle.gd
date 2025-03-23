extends Player_Base

func enter():
	# 方向
	var dir = player.direction
	animation_player.play("idle_" + dir)
	# 速度重置
	player.velocity = Vector2.ZERO

func do( _delta : float ):
	pass

func exit():
	pass
