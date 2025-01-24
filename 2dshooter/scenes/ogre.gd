extends CharacterBody2D

@onready var player = get_parent().find_child("player")
@onready var sprite = $AnimatedSprite2D
@onready var melee_hitbox = $melee_hitbox
@onready var melee_collision = $melee_hitbox/melee_collision
@onready var damage_numbers_origin = $DamageNumbersOrigin

var hp = 100
var direction : Vector2
var already_flipped = true
var knockback_force = 0
var knockback_decay_speed = 30

func _process(delta):
	if player:
		direction = player.global_position - global_position
	
	if direction.x < 0:
		if not already_flipped:
			sprite.flip_h = false
			melee_hitbox.position.x *= -1
			already_flipped = true
	else:
		if already_flipped:
			sprite.flip_h = true
			melee_hitbox.position.x *= -1
			already_flipped = false
		
func _physics_process(delta):
	if knockback_force <= 0:
		velocity = direction.normalized() * 40
	else:
		velocity = -direction.normalized() * knockback_force
		knockback_force -= knockback_decay_speed
	move_and_collide(velocity * delta)


func _on_animated_sprite_2d_animation_finished() -> void:
		if sprite.animation == "attack":
			if direction.length() < 30:  
				sprite.play("attack")


func _on_animated_sprite_2d_frame_changed() -> void:
	if sprite.animation == "attack":
		if sprite.frame == 3:
			for body in melee_hitbox.get_overlapping_bodies():
				if body.name == "player":
					body.take_damage(10)

func take_damage(damage):
	hp -= damage
	DamageNumbers.display_number(damage, damage_numbers_origin.global_position)
	if hp <= 0:
		queue_free()
