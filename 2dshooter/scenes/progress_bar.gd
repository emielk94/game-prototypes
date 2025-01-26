extends ProgressBar

@export var player : Player

func _ready() -> void:
	player.healthChanged.connect(update)
	update()

func update():
	value = player.hp * 100 / player.max_health
