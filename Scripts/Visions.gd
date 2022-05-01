extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func clearVision():
	for i in get_child_count():
		get_child(i).hide()

func triggerCrystals():
	$Crystals.show()
