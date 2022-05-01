extends Spatial

onready var screen_radar = $Ship/Console/Screen/GUI/ScannerConsole
onready var screen_nav = $Ship/Console/Screen/GUI/NavigationScreenConsole
onready var screen_power = $Ship/Console/Screen/GUI/EnergyDisplayConsole
onready var screen_message = $Ship/Console/Screen/GUI/MessageScreenConsole
onready var blackscreen = $Ship/Console/Screen/GUI/blackscreen

var current_message: String
var message_intro = "Mission: Enter the Void\nThe Bootes void has been ominously present in our solar mappings as of recently. You're on the outskirts of the void in a neighboring galaxy's asteroid belt. Your job is to keep the ship navigated on course and scan the area for any anomalies.\nNavigation controls can be found to your left, Radar controls in the middle. Gamma Pulse will scan the nearby area for any anomalies. Any unidentified or wrongly identified anomalies could be potentially dangerous, so make haste. Using Gamma Pulse costs power, so it's best to use your eyes and look for anomalies before scanning.\nAs you enter the asteroid belt, take a look at your surroundings and familiarize yourself with the asteroids you'll see in this belt in order to further your ability to detect anomalies. Initiate Warp Speed to start your mission.\nGood luck."


var rng = RandomNumberGenerator.new()
var last_screen
var console_on = true
var console_working = true

func _ready():
	last_screen = screen_radar
	screen_message.loadText(message_intro)
	current_message = message_intro

func _process(_delta):
	if Input.is_action_just_pressed("fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Globals.off_course:
		$Ship/Console/Navigation_Noti/nav_light.set_color(Color.red)
	else:
		$Ship/Console/Navigation_Noti/nav_light.set_color(Color.green)
		$Ship/Console/Navigation_Noti/nav_light/AnimationPlayer.seek(0)
		

func push(button_name):
	if console_working:
		match button_name:
			"Toggle Lights":
				if $Ship/Console/SpotLight.visible:
					$Ship/Console/SpotLight.visible = false
				else:
					$Ship/Console/SpotLight.visible = true
			"Switch to Radar":
				screen_nav.hide()
				screen_power.hide()
				screen_message.hide()
				screen_radar.show()
				$Ship/Console/ScreenLight.show()
				last_screen = screen_radar
				if !console_on:
					console_on = true
			"Switch to Navigation":
				screen_nav.show()
				screen_power.hide()
				screen_message.hide()
				screen_radar.hide()
				$Ship/Console/ScreenLight.show()
				last_screen = screen_nav
				if !console_on:
					console_on = true
			"Switch to Power":
				screen_nav.hide()
				screen_power.show()
				screen_message.hide()
				screen_radar.hide()
				$Ship/Console/ScreenLight.show()
				last_screen = screen_power
				if !console_on:
					console_on = true
			"Toggle Console":
				if console_on:
					screen_nav.hide()
					screen_power.hide()
					screen_message.hide()
					screen_radar.hide()
					blackscreen.show()
					$Ship/Console/ScreenLight.hide()
					console_on = false
				else:
					screen_nav.hide()
					screen_power.hide()
					screen_message.hide()
					screen_radar.hide()
					blackscreen.hide()
					last_screen.show()
					$Ship/Console/ScreenLight.show()
					console_on = true
			"Turn Right 15°":
				if screen_nav.visible:
					screen_nav.rotateRight(15)
					$Env/WorldEnvironment.rotateSkyRight()
					$Env/DirectionalLight.rotation_degrees.y += 15
			"Turn Left 15°":
				if screen_nav.visible:
					screen_nav.rotateLeft(15)
					$Env/WorldEnvironment.rotateSkyLeft()
					$Env/DirectionalLight.rotation_degrees.y -= 15
			"Recieve Transmission":
				screen_message.loadText(current_message)
				screen_nav.hide()
				screen_power.hide()
				screen_message.show()
				screen_radar.hide()
			"Gamma Pulse":
				if !screen_radar.selecting && console_on:
					screen_radar.ping()
					screen_power.useEnergy(10)
					$Audio/sonar_pulse.play()
			"Identify as Planetary Mass":
				if screen_radar.selecting:
					print("Selecting Planetary Mass")
					screen_radar.identifyAnomaly("Planetary") # Pass the chosen type - check if correct in Globals
				else:
					pass
			"Identify as Debritus":
				if screen_radar.selecting:
					print("Selecting Debritus")
					screen_radar.identifyAnomaly("Debritus") 
				else:
					pass
			"Identify as Alien Organism":
				if screen_radar.selecting:
					print("Selecting Alien Organism")
					screen_radar.identifyAnomaly("Alien")
				else:
					pass
			"Identify as Unknown":
				if screen_radar.selecting:
					print("Selecting Unknown")
					screen_radar.identifyAnomaly("Unknown") 
				else:
					pass
	else:
		pass

func triggerBlackFog():
	$blackfog_mid.emitting = true
	$blackfog_L.emitting = true
	$blackfog_R.emitting = true
	screen_nav.hide()
	screen_power.hide()
	screen_message.hide()
	screen_radar.hide()
	blackscreen.hide()
	$Ship/Console/Screen/GUI/Static.show()
	$Audio/console_glitch.play()
	$Env/WorldEnvironment.setAmbientLight(1)
	$Env/DirectionalLight/AnimationPlayer.play("dim")

func triggerRenavigate():
	if Globals.off_course:
		pass #Player loses the game (crash animation?)
	else:
		Globals.off_course = true
		$Ship/Console/Navigation_Noti/nav_light/AnimationPlayer.play("light_flicker")
		rng.randomize()
		var navDegreeRoll = ((rng.randi_range(1,10)) * 15)
		var forDirectionRoll = rng.randi_range(0,1)
		var directionRoll = false
		if forDirectionRoll == 0:
			directionRoll = true
		else:
			directionRoll = false
		screen_nav.setNavEvent(navDegreeRoll, directionRoll)

func energyRestore():
	screen_power.restoreEnergy(15)
	
func visionCrystals():
	$Visions/Crystals.show()

func clearAnomalies():
	for anomaly in get_tree().get_nodes_in_group("anomaly"):
		anomaly.queue_free()
	Globals.anomaly_active = false

func _on_powertick_timeout():
	if console_on:
		screen_power.useEnergy(1)
	if $Ship/Console/SpotLight.visible:
		screen_power.useEnergy(1)
	$powertick.start()
