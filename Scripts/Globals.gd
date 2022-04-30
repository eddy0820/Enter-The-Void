extends Node

var anomaly_active = true
var vision_active = false

var rng = RandomNumberGenerator.new()


func attemptScan(radarscreen):
	
	#Anomaly Detected
	if anomaly_active:
		print("Anomaly active, selection commencing")
		rng.randomize()
		var rollMass = rng.randi_range(80, 550) #Mass roll
		var rollVelocity = rng.randi_range(10, 80) #Velocity roll
		var rollGamma
		var rollgamma1 = rng.randi_range(0,1) #Gamma roll
		if rollgamma1 == 0:
			rollGamma = true
		else:
			rollGamma = false
			radarscreen.detectAnomaly(rollMass, rollVelocity, rollGamma)
	#No Anomaly Detected
	else:
		radarscreen.scanFail()
		print("Anomaly inactive, scan failed")
