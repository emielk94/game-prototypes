extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var sprite = $AnimatedSprite2D
@onready var melee_hitbox = $melee_hitbox
@onready var melee_collision = $melee_hitbox/melee_collision

var direction : Vector2
var already_flipped = true

func _process(delta):
	if player:
		direction = player.global_position - global_position
	
	if direction.x < 0:
		if not already_flipped:
			sprite.flip_h = false
			melee_collision.position.x *= -1
			already_flipped = true
	else:
		if already_flipped:
			sprite.flip_h = true
			melee_collision.position.x *= -1
			already_flipped = false
		
func _physics_process(delta):
	velocity = direction.normalized() * 40
	move_and_collide(velocity * delta)


func _on_animated_sprite_2d_animation_finished() -> void:
		if sprite.animation == "attack":
		#sprite.play("attack") # Replace with function body.
			for body in melee_hitbox.get_overlapping_bodies():
				if body.name == "player":
					body.take_damage(10) # Replace with function body.
			if direction.length() < 30:  # Replace with your damage logic
				sprite.play("attack")
