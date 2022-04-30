extends MeshInstance


var rotational_velocity_x = 0.0
var rotational_velocity_y = 0.0
var rotational_velocity_z = 0.0


var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()

	
	rotational_velocity_x = rng.randf_range(-.0001,.0001)
	rotational_velocity_y = rng.randf_range(-.0001,.0001)
	rotational_velocity_z = rng.randf_range(0,.0001)
	

func _process(delta):
	rotate_x(rotational_velocity_x)
	rotate_y(rotational_velocity_x)
	rotate_z(rotational_velocity_z)
