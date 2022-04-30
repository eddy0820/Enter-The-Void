extends Node2D

export var initialEnergy = 100
export var lowEnergyThreshold = 35
var currEnergy = 0
var lowEnergy = false



func _ready():
	currEnergy = initialEnergy
	
	$Control/VBoxContainer/HBoxContainer/CenterContainer/TextureProgress.value = currEnergy
	$Control/VBoxContainer/HBoxContainer/VBoxContainer/Label2.text = str(currEnergy) + "%"
	
func _process(delta):
	if(Input.is_action_just_pressed("move_forward")):
		useEnergy(5)

	
	if(currEnergy <= lowEnergyThreshold && !lowEnergy):
		$Control/VBoxContainer/CenterContainer/Timer.start()
		lowEnergy = true
	
func useEnergy(energy: int):
	currEnergy -= energy
	if(currEnergy < 0):
		currEnergy = 0
	
	$Control/VBoxContainer/HBoxContainer/CenterContainer/TextureProgress.value = currEnergy
	$Control/VBoxContainer/HBoxContainer/VBoxContainer/Label2.text = str(currEnergy) + "%"
	
func cutPower():
	currEnergy = 0


func _on_Timer_timeout():
	$Control/VBoxContainer/CenterContainer/Label.visible = !($Control/VBoxContainer/CenterContainer/Label.visible)
