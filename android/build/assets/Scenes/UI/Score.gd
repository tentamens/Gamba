extends LineEdit

var currentScore = 0
var score = Score.score

var tween 


func _process(delta):
	
	score = Score.score
	
	if score == currentScore:
		return
	
	self.text = str(score)
	currentScore = score
	
	
	


func loseAnimation():
	var label = get_parent().get_node("gain")
	
	tween = create_tween()
	
	
	label.position = Vector2(198,-1)
	label.modulate.a = 1.0
	
	tween.tween_property(label, "position", Vector2(198,-20), 0.2)
	tween.tween_property(label, "modulate:a", 0, 0.2)
	
	
	




