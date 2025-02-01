extends CharacterBody2D
class_name Player

var pistol = preload("res://scenes/pistol.tscn")
var shotgun = preload("res://scenes/shotgun.tscn")
var minigun = preload("res://scenes/minigun.tscn")

@onready var anim_sprite = $AnimatedSprite2D
@onready var gun = $gun_pos.get_child(0)
@onready var gun_pos = $gun_pos

var speed = 300.0
var hp = 100
var max_health = 100
var is_dead = false
var inventory = []
signal healthChanged

func _ready() -> void:
	# Add weapons to inventory
	inventory.append(pistol)
	inventory.append(shotgun)
	inventory.append(minigun)
	# Instantiate the first weapon and add it to gun_pos
	#var new_weapon = inventory[0].instantiate()
	#gun_pos.add_child(new_weapon)
	#gun_pos.get_child(0).set_owner(self)
	#gun = gun_pos.get_child(0)
	#
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
			
		if Input.is_action_pressed("shoot"):
			gun.shoot()
		if Input.is_action_just_pressed("weapon_slot_1"):
			equip_weapon(0)
		if Input.is_action_just_pressed("weapon_slot_2"):
			equip_weapon(1)
		if Input.is_action_just_pressed("weapon_slot_3"):
			equip_weapon(2)

		move_and_slide()
		
func is_instance_of_scene(instance: Node, scene: PackedScene) -> bool:
	return instance.get_meta("scene_path", "") == scene.resource_path
	
func equip_weapon(index):
	gun_pos.get_child(0).queue_free()
	await get_tree().process_frame
	var new_weapon = inventory[index].instantiate()
	gun_pos.add_child(new_weapon)
	gun_pos.get_child(0).set_owner(self)
	gun = gun_pos.get_child(0)

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
