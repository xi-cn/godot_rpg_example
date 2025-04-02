class_name ItemEffectHeal extends ItemEffect

@export var heal_amount:int = 1
@export var sound:AudioStream

func use():
	PlayerManager.player._update_hp(heal_amount)
	PauseManu.play_sound(sound)
