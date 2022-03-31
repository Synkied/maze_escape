extends "res://characters/Character.gd"

signal moved
signal dead
signal grabbed_key
signal win
signal start

func _process(delta):
	if can_move:
		for dir in moves.keys():
			if Input.is_action_pressed(dir):
				if move(dir):
					$Footsteps.play()
					emit_signal('moved')


func _on_Player_area_entered(area):
	print(area)
	if area.is_in_group('enemies'):
		area.hide()
		$CollisionShape2D.set_deferred('disabled', true)
		set_process(false)
		$Lose.play()
		$AnimationPlayer.play("die")
		yield($Lose, 'finished')
		emit_signal('dead')
	if area.has_method('pickup'):
		area.pickup()
		if area.type == 'key_red':
			emit_signal('grabbed_key', area.type)
		if area.type == 'key_green':
			emit_signal('grabbed_key', area.type)
		if area.type == 'star':
			$Win.play()
			$CollisionShape2D.set_deferred('disabled', true)
			yield($Win, "finished")
			emit_signal('win')
	if area != null and is_instance_valid(area) and area.is_in_group('start'):
		Global.new_game()


func _ready():
	$Sprite.scale = Vector2(1, 1)
