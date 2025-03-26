extends CharacterBody2D

@onready var player_sprite = $player_sprite

const speed = 300.0
var direction 

func _process(delta: float) -> void:
	direction = Input.get_vector("left","right","up","down")
	var mouse_pos = get_global_mouse_position()
	
	if direction:
		player_sprite.play("walk")
	else:
		player_sprite.play("idle")
		
	if mouse_pos.x > global_position.x:
		player_sprite.flip_h = true
	else:
		player_sprite.flip_h = false
		
func _physics_process(delta: float) -> void:
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		
	move_and_slide()
