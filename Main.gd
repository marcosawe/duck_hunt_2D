extends Node2D

# Definindo variáveis dos patos
var patosNaTela;
var pato = preload("res://Pato.tscn");
var flyAway = 0;
var capturados = 0;

func _ready():
	$gerapato.start();

# Definindo o segmento do alvo sobre o mause
func _process(delta):
	$HUD/Label.text = str(capturados);
	$Alvo.position.x = get_local_mouse_position().x;
	$Alvo.position.y = get_local_mouse_position().y;

#Inicializando os patos no plano (x y)
func nasce():
	var novoPato = pato.instance();
	add_child(novoPato);
	novoPato.position.x = rand_range(50,700);
	novoPato.position.y = 700;

func _on_gerapato_timeout():
	patosNaTela = int(rand_range(1,6));
	for n in patosNaTela:
		nasce();

func _on_espera_timeout():
	$novo_turno.play();
	$gerapato.start();

# Pato rocou no céu e fugiu
func _on_topo_body_entered(body):
	$fly_away.play();
	flyAway = 1;
	patosNaTela -= 1;
	atualizaTurno();

# Pato tocou no chão e sua pontuação almentou
func _on_chao_body_entered(body):
	$fly_away.play();
	capturados += 1;
	patosNaTela -=1;
	atualizaTurno();


func atualizaTurno():
	if(patosNaTela == 0):
		$espera.start();
		if(flyAway == 1):
			$cao.play("rindo");
			$cao_rindo.play();
			flyAway = 0;
			capturados = 0;
		else:
			$cao.play("captura");
			$cao_captura.play();
			
