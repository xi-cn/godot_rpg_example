extends CharacterBody2D

# 方向
var direction:String = "down"
var vec_direction:Vector2 = Vector2.DOWN
@onready var plaer_interaction_host:PlayerInteractionHost = $Interactions


func update_direction(dir:Vector2):
	# 什么都不做
	if dir == Vector2.ZERO:
		return 
	
	if vec_direction == Vector2.LEFT || vec_direction == Vector2.RIGHT:
		# 没有改变
		if vec_direction.x == dir.x:
			return
		elif dir.x != 0:
			vec_direction.x = dir.x
		else:
			vec_direction = dir
	else:
		if vec_direction.y == dir.y:
			return
		elif dir.y != 0:
			vec_direction.y = dir.y
		else:
			vec_direction = dir
	
	match vec_direction:
		Vector2.LEFT:
			direction = "side"
		Vector2.RIGHT:
			direction = "side"
		Vector2.UP:
			direction = "up"
		Vector2.DOWN:
			direction = "down"
	
	$Sprite2D.scale.x = -1 if vec_direction == Vector2.LEFT else 1
	plaer_interaction_host.update_direction(vec_direction)
