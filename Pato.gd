extends KinematicBody2D
var lado = 1;
var vel = Vector2();
var speed = 100;
var queda = 1;

func _ready():
	# Randomizando movimentos
	randomize();
	$quack.wait_time = rand_range(0.8,2);
	$movimento.wait_time = rand_range(0.4,2);
	$anima.wait_time = rand_range(0.6,1);
	
func _process(delta):
	# Movimentação horizontal
	position.x += speed*lado*delta;
	
	# Movimentação vertical
	position.y -= 140*queda*delta;
	
	# Espelhamento da animação
	if lado < 0:
		$AnimatedSprite.flip_h = true;
	else:
		$AnimatedSprite.flip_h = false; 

# Função de aplicação do movimento no sprite
func _on_movimento_timeout():
	lado = lado*(-1);

# Função de animação do sprite
func _on_anima_timeout():
	if $AnimatedSprite.animation == 'cima':
		$AnimatedSprite.animation = 'lado';
	elif $AnimatedSprite.animation == 'lado':
		$AnimatedSprite.animation = 'cima';

# Função de animação da morte;
func mata():
	$AnimatedSprite.animation = 'susto';
	$morte.start();
	

func _on_morte_timeout():
	$quack.stop();
	$AnimatedSprite.animation = 'morte';
	queda = -1;
	lado = 0;


func _on_quack_timeout():
	$audio_Quack.play();
