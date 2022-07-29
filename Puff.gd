extends Node2D


func _ready():
	$CPUParticles2D.emitting = true


func _process(delta):
	if not $CPUParticles2D.emitting:
		queue_free()
