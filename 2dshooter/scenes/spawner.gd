extends Node2D

var ogre_scene = preload("res://scenes/ogre.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_multiple(number):
	for i in range(number):
		spawn()

func spawn():
	var ogre_instance = ogre_scene.instantiate()
	ogre_instance.position.x = 100
	ogre_instance.position.y = randf_range(-46, 500)
	var random = int(randf_range(1,3))
	
	if random == 2:
		ogre_instance.position.x = 950
	
	if ogre_instance:
		get_tree().current_scene.add_child(ogre_instance)
	else:
		print("Failed to instantiate ogre scene!")
