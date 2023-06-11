extends Node

var path = "user://playerState.name"

var gravity
var side2sidePullNums
var range


func storeID(id):
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(id)

func retrieveID():
	var file = FileAccess.open(path, FileAccess.READ)
	if file == null:
		print(null)
		return null
	var content = file.get_as_text()
	var id = str_to_var(content)
	return id
