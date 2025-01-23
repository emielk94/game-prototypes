extends Gun

@onready var sprite = $Sprite2D
@onready var raycast = $RayCast2D
@onready var audioplayer = $AudioStreamPlayer2D
# Called when the node enters the scene tree for the first time.
func _ready():
	draw_offset = 20 # Replace with function body.
	range = 1000
	damage = 5
	knockback_str = 10
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	
	var raycast_global_target = global_position + direction * 1000
	raycast.target_position = raycast.to_local(raycast_global_target)
	
	rotation = (mouse_pos - global_position).angle()
	
	if mouse_pos.x > owner.global_position.x:
		sprite.flip_v = false
	else:
		sprite.flip_v = true
	
func _physics_process(delta):
	pass
	
func shoot():
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - global_position).normalized()
	audioplayer.play()
	
	if raycast.is_colliding():
		var collider = raycast.get_collider()
		if collider && collider.is_in_group("enemies"):
			collider.take_damage(damage)
			#collider.apply_knockback(direction, knockback_str)
