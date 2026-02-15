extends CanvasLayer
func _process(delta: float) -> void:
	$CoinsNumber.text = str(Globals.coins) 
