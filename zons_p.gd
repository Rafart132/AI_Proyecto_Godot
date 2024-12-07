extends Node3D

@onready var enemy_scene = preload("res://Ai/enemigo.tscn")  # Carga la escena del enemigo
@onready var spawn_timer = $Timer  # Nodo Timer en la escena

func _ready():
	# Inicia el temporizador (se generará al iniciar la escena)
	spawn_timer.one_shot = true
	spawn_timer.start()

# Se llama cuando el temporizador se agota

func _on_timer_timeout() -> void:
	# Generar el enemigo en la posición deseada
	var enemy_instance = enemy_scene.instantiate()
	enemy_instance.global_position = Vector3(.3, 0.3, 1.3)  # Ajusta la posición del enemigo
	add_child(enemy_instance)
