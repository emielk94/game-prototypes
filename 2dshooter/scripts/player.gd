extends CharacterBody2D
class_name Player

@onready var anim_sprite = $AnimatedSprite2D
@onready var gun = $gun_pos.get_child(0)

var speed = 300.0
var hp = 100
var max_health = 100
var is_dead = false

signal healthChanged

func _physics_process(delta):
	if !is_dead:
		var direction = Input.get_vector("left","right","up","down")
		var mouse_pos = get_global_mouse_position()
		
		if direction:
			anim_sprite.play("walk")
			velocity = direction * speed
		else:
			anim_sprite.play("idle")
			velocity = Vector2.ZERO
			
		if mouse_pos.x > global_position.x:
			anim_sprite.flip_h = true
		else:
			anim_sprite.flip_h = false
			
		if Input.is_action_just_pressed("shoot"):
			gun.shoot()

		move_and_slide()

func take_damage(damage):
	if !is_dead:
		hp -= damage
		if hp <= 0:
			hp = 0
			healthChanged.emit()
			is_dead = true
			anim_sprite.visible = false
			gun.visible = false
		else:
			healthChanged.emit()
