extends Node2D

var currText = ""

func loadText(text: String):
	currText = "/-> " + text;

func _process(delta):
	if(currText.length() < $Control/ConsoleContainer/RichTextLabel.visible_characters):
		$Control/ConsoleContainer/RichTextLabel/Timer.stop()
	
func displayCurrText():
	$Control/ConsoleContainer/RichTextLabel.text = currText
	$Control/ConsoleContainer/RichTextLabel/Timer.start()
	
func _on_Timer_timeout():
	$Control/ConsoleContainer/RichTextLabel.visible_characters += 1
