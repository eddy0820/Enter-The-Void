extends MeshInstance

var rotational_velocity_x = 0.0
var rotational_velocity_y = 0.0
var rotational_velocity_z = 0.0

var info_mass: int
var info_velocity: int
var react_to_gamma: bool


var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()

	
	rotational_velocity_x = rng.randf_range(-.002,.002)
	rotational_velocity_y = rng.randf_range(-.002,.002)
	rotational_velocity_z = rng.randf_range(0,.002)
	

func _process(delta):
	#Globals.anomaly_active = true
	rotate_x(rotational_velocity_x)
	rotate_y(rotational_velocity_x)
	rotate_z(rotational_velocity_z)
