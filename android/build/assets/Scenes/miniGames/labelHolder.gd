extends VBoxContainer

@onready var label = preload("res://Scenes/UI/preloads/label.tscn")

func _physics_process(delta):
	await get_tree().create_timer(0.2).timeout
	
	var array = Server.newScoreUpdate
	
	for i in array:
		var newInstance = label.instantiate()
		add_child(newInstance)
		Server.newScoreUpdate.erase(i)
		if array[0] > 0:
			newInstance.self_modulate = Color.FOREST_GREEN
			newInstance.text = (str(array[1]) + "  : +" + str(array[0]))
			return
		
		newInstance.self_modulate = Color.FOREST_GREEN
		newInstance.text = (str(array[1]) + "  : +" + str(array[0]))
