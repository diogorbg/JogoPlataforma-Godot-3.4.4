extends Area2D


onready var anim = $anim

func _on_moeda_body_entered(body):
	anim.play("coletar")
	yield(anim, "animation_finished") # aguarda a animação finalizar
	queue_free() # destruição da moeda
	print("destruido")
