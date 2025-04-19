class_name PressurePlate extends Node2D

@onready var sprite_2d:Sprite2D = $Sprite2D
@onready var area_2d:Area2D = $Area2D
@onready var audio_player:AudioStreamPlayer2D = $AudioStreamPlayer2D

signal plate_activaed
signal plate_deactivaed

var body_num:int
var audio_activated:AudioStream = preload("res://resource/Interactions/dungeon/lever-01.wav")
var audio_deactivated:AudioStream = preload("res://resource/Interactions/dungeon/lever-02.wav")


func _ready() -> void:
	body_num = 0
	
	area_2d.body_entered.connect(_on_body_entered)
	area_2d.body_exited.connect(_on_body_exited)
	
func _on_body_entered(a_):
	print("enter")
	body_num += 1
	
	if body_num == 1:
		sprite_2d.frame = 0
		audio_player.stream = audio_activated
		audio_player.play()
		plate_activaed.emit()
	

func _on_body_exited(a_):
	body_num -= 1
	if body_num == 0:
		sprite_2d.frame = 1
		audio_player.stream = audio_deactivated
		audio_player.play()
		plate_deactivaed.emit()
