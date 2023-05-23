extends CharacterBody2D
#1 = left 2 = right
var side = 0

var num

var bet = 0

var gravity = Data.gravity
var side2sidePullNums = Data.side2sidePullNums
var range = Data.range







func _process(delta):
	
	
	side2sidePull()
	
	velocity.y += gravity
	
	
	var collision_info = move_and_collide(velocity*delta)
	
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
		
		
		velocity.y /= randf_range(range[0], range[1])
			
		velocity.x /= randf_range(range[0], range[1])
		




func _on_area_2d_area_entered(area):
	if area.name == "leftSide":
		side = 1
	
	if area.name == "rightSide":
		side = 2

	
	
	

func side2sidePull():
	if side == 0:
		return
	if side == 1:
		velocity.x += side2sidePullNums
		return
	
	velocity.x -= side2sidePullNums




func _on_area_2d_2_area_entered(area):
	if area.name == "Area2D2":
		return
	queue_free()
