tool
extends Node2D


var platforms setget , get_platforms


func get_platforms() -> Array:
	return get_tree().get_nodes_in_group("platforms") if is_inside_tree() else []


func _ready():
	for platform in get_platforms():
		if platform.is_connected("changed", self, "_on_platform_changed"):
			platform.disconnect("changed", self, "_on_platform_changed")
		platform.connect("changed", self, "_on_platform_changed")
	
	reset()


func _on_platform_changed(platorm :Platform):
	reset()


func reset():
	$Tween.remove_all()
	
	for platform in get_platforms():
		platform.follow = Vector2.ZERO
		$Tween.interpolate_property(platform, "follow", \
			Vector2.ZERO, platform.offset * 16, platform.duration, \
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, platform.idle_time)
		$Tween.interpolate_property(platform, "follow", \
			platform.offset * 16, Vector2.ZERO, platform.duration, \
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, platform.duration + platform.idle_time * 2)
	
	$Tween.start()


func _physics_process(delta):
	for platform in get_platforms():
		platform = platform as Platform
		platform.update_position()
