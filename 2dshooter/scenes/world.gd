extends Node2D

@onready var spawner = $spawner
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawner.spawn_multiple(10)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
