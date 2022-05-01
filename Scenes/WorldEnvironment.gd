extends WorldEnvironment


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func rotateSkyRight():
	get_environment().background_sky_rotation_degrees.y += 15

func rotateSkyLeft():
	get_environment().background_sky_rotation_degrees.y -= 15

func setAmbientLight(newValue):
	get_environment().ambient_light_energy = newValue
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
