extends Sprite2D


var prompt = $RichTextLabel
var prompt_text = $RichTextLabel.bbcode_text

var active_enemy = null
var current_letter_index: int = -1

func find_new_active_enemy():
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and not event.is_pressed():
		var typed_event = event as InputEventKey 
		var key_typed = typed_event.unicode
