extends Gun

@onready var sprite = $Sprite2D
@onready var raycast = $RayCast2D
@onready var fire_cd = $fire_cd_timer
# Called when the node enters the scene tree for the first time.
func _ready():
	draw_offset = 20 # Replace with function body.
	range = 1000
	damage = 10
	fire_rate = 0.05
	fire_cd.wait_time = fire_rate
	knockback_str = 200
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	var raycast_global_target = global_position + direction * 1000
	raycast.target_position = raycast.to_local(raycast_global_target)
	
	rotation = (mouse_pos - global_position).angle()
	if mouse_pos.x > owner.global_position.x:
		sprite.flip_v = false
	else:
		sprite.flip_v = true
	
func shoot():
	if can_shoot:
		can_shoot = false
		fire_cd.start()
		var mouse_pos = get_global_mouse_position()
		var direction = (mouse_pos - global_position).normalized()
		play_audio()
		
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			if collider && collider.is_in_group("enemies"):
				collider.take_damage(damage)
				collider.knockback_force = knockback_str
				#collider.apply_knockback(direction, knockback_str)
func play_audio():
	var audio_player = AudioStreamPlayer2D.new()
	audio_player.global_position = global_position
	audio_player.volume_db = -20
	audio_player.stream = preload("res://sfx/gunshot.ogg")
	get_tree().current_scene.add_child(audio_player)
	audio_player.play()

func _on_fire_cd_timer_timeout() -> void:
	can_shoot = true # Replace with function body.
