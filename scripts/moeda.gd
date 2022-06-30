extends Area2D


onready var anim = $anim

func _on_moeda_body_entered(_body):
	set_deferred("monitoring", false) # não colidir mais de 1x (o personagem possui 2 colisores)
	$sfx.play()
	anim.play("coletar")
	yield(anim, "animation_finished") # aguarda a animação finalizar
	queue_free() # destruição da moeda
	#print("destruido")
