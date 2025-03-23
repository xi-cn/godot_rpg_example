class_name Player_Base extends Node

static var player:CharacterBody2D
static var animation_player:AnimationPlayer
static var sprite:Sprite2D
static var audio:AudioStreamPlayer2D

# 优先级
var priority = 0

func is_motivated()->bool:
	return false

func enter():
	pass
	
func do( _delta : float ):
	pass
	
func exit():
	pass
