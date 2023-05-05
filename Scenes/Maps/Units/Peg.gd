extends StaticBody2D

var tween




func _on_area_2d_area_entered(area):
	tween = get_tree().create_tween()
	$PegOutline.scale = Vector2(0.04,0.04)
	tween.tween_property($PegOutline, 'scale', Vector2(0.2,0.2), 0.1,)
	$PegOutline.modulate.a = 0.5
	tween.tween_property($PegOutline, 'modulate:a', 0, 0.18,)
	
	
