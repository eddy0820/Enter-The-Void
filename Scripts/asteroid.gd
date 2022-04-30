extends MeshInstance

var z_offset = 0.0
var y_offset = 0.0

var random_radial_segments = 0
var random_rings = 0

var rotational_velocity_x = 0.0
var rotational_velocity_y = 0.0
var rotational_velocity_z = 0.0
var velocity = 0


var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	
	velocity = rng.randf_range(0.08,0.2)
	var scale_random = rng.randi_range(3,20)
	scale.x = scale_random
	scale.y = scale_random
	scale.z = scale_random
	
	z_offset = rng.randf_range(-128.0,128.0)
	y_offset = rng.randf_range(-64.0,64.0)
	
	translation.z += z_offset
	translation.y += y_offset
	
	
	rotational_velocity_x = rng.randf_range(-.002,.002)
	rotational_velocity_y = rng.randf_range(-.002,.002)
	rotational_velocity_z = rng.randf_range(0,.002)
	
	#Roll for asteroid type
	var asteroid_type = rng.randi_range(1,2)
	match asteroid_type:
		1:
			pass
		2:
			pass

func _process(delta):
	rotate_x(rotational_velocity_x)
	rotate_y(rotational_velocity_x)
	rotate_z(rotational_velocity_z)
	
	translation.x += velocity

	if translation.x >= 1024:
		queue_free()

