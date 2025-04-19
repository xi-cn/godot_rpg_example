class_name PushStatue extends RigidBody2D


@export var push_speed:float = 30.0

var push_direction : Vector2 = Vector2.ZERO
var push_audio: AudioStream

@onready var audio_player : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	push_audio = preload("res://resource/Interactions/dungeon/push_stone.wav")
	linear_velocity = Vector2.ZERO
	audio_player.stream = push_audio

func _physics_process(delta: float) -> void:
	linear_velocity = push_direction * push_speed


func set_direction(dir:Vector2):
	push_direction = dir
	if dir != Vector2.ZERO:
		audio_player.play()
	else:
		audio_player.stop()
