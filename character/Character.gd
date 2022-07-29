extends KinematicBody2D
class_name Character


onready var state_manager = $StateManager
onready var anim_sprite = $AnimatedSprite
onready var anim_player = $AnimationPlayer

var velocity := Vector2.ZERO
var gravity := Vector2.DOWN * 9.81
export (int, 50, 200) var h_mvt = 120
var snap := Vector2.ZERO
var on_ground := false setget set_on_ground

signal hurt()


func set_on_ground(value):
	snap = Vector2.DOWN * 8 if value else Vector2.ZERO
	on_ground = value


func _ready():
	state_manager.init(self)


func _unhandled_input(event):
	state_manager.input(event)


func _physics_process(delta):
	state_manager.physics_process(delta)
