extends Node2D

export var frequencia = 2
export var amplitude = 4

onready var pos;

func _ready():
	pos = position;

func _process(delta):
	var t = OS.get_ticks_msec() / 1000.0
	position = pos + Vector2.UP * sin(t * frequencia) * amplitude
