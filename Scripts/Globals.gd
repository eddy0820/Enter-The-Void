extends Node

onready var main_scene = preload("res://Scenes/Main.tscn")

var anomaly_active = true
var vision_active = false
var off_course = false


var rng = RandomNumberGenerator.new()


func attemptScan(radarscreen):
	
	#Anomaly Detected
	if anomaly_active:
		print("Anomaly active, selection commencing")
		rng.randomize()
		var rollMass = rng.randi_range(86, 500) #Mass roll
		var rollVelocity = rng.randi_range(15, 70) #Velocity roll
		var rollGamma
		var rollgamma1 = rng.randi_range(0,1) #Gamma roll
		if rollgamma1 == 0:
			rollGamma = true
		else:
			rollGamma = false
			
			
		var anomaly_type
		#Determine what kind of anomaly it is
		if (rollMass >= 331 && rollMass <= 539) && (rollVelocity >= 8 && rollVelocity <= 34):
			anomaly_type = "Planetary"
		elif (rollMass >= 104 && rollMass <= 487) && (rollVelocity >= 38 && rollVelocity <= 69) && rollGamma == false:
			anomaly_type = "Debritus"
		elif (rollMass >= 86 && rollMass <= 324) && (rollVelocity >= 12 && rollVelocity <= 80) && rollGamma == true:
			anomaly_type = "Alien"
		else:
			anomaly_type = "Unknown"
		
		radarscreen.detectAnomaly(rollMass, rollVelocity, rollGamma, anomaly_type)
		
	#No Anomaly Detected
	else:
		radarscreen.scanFail()
		print("Anomaly inactive, scan failed")

