extends Button

@onready var admob = $AdMob
@onready var label = preload("res://Scenes/UI/preloads/label.tscn")



func _ready():
	await get_tree().create_timer(1).timeout
	admob.load_rewarded_video()
	var newInstance = label.instantiate()
	$VBoxContainer.add_child(newInstance)
	newInstance.text = str(admob.failed)


func _on_pressed():
	admob.show_rewarded_video()
	if admob.is_rewarded_video_loaded() == true:
		admob.show_rewarded_video()
		var newInstance = label.instantiate()
		$VBoxContainer.add_child(newInstance)
		newInstance.text = "started"
	var newInstance = label.instantiate()
	$VBoxContainer.add_child(newInstance)
	newInstance.text = "failed"


func _on_ad_mob_rewarded_video_loaded():
	var newInstance = label.instantiate()
	$VBoxContainer.add_child(newInstance)
	newInstance.text = str("loaded")


func _on_ad_mob_rewarded_video_failed_to_load(error_code):
	var newInstance = label.instantiate()
	$VBoxContainer.add_child(newInstance)
	newInstance.text = str(error_code)
