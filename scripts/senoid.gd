extends Node2D

export var frequencia = 2
export var amplitude = 4

onready var pos = position
var t = 0.0

func _process(delta):
	t += delta * frequencia
	position = pos + Vector2.UP * sin(t) * amplitude
