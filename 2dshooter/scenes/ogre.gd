extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var sprite = $AnimatedSprite2D

var direction : Vector2
var already_flipped = true

func _process(delta):
	if player:
		direction = player.global_position - global_position
	
	if direction.x < 0:
		if not already_flipped:
			sprite.flip_h = false
			#melee_collision.position.x *= -1
			already_flipped = true
	else:
		if already_flipped:
			sprite.flip_h = true
			#melee_collision.position.x *= -1
			already_flipped = false
		
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)
