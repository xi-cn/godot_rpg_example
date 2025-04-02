class_name ItemData extends Resource


@export var name:String
@export_multiline var description:String
@export var texture:Texture2D
@export var max_num_one_grid:int = 64

@export_category("Item Use Effect")
@export var effects:Array[ItemEffect] 

func use()->bool:
	if effects.size() == 0:
		return false
	
	for effect in effects:
		if effect:
			effect.use()
	return true
