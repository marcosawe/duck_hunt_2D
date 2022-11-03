extends Area2D
var patoAtual;
 
func _ready():
	pass


func _on_Alvo_body_entered(body):
	patoAtual = body;
	
func _input(event):
	if Input.is_action_just_pressed("atirar"):
		$AudioStreamPlayer2D.play();
		if patoAtual == null:
			print("Sem patos");
		else:
			patoAtual.mata();
