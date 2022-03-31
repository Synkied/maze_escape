extends CanvasLayer

export (PackedScene) var Pickup

onready var items = $Items

func _input(event):
	if event.is_action_pressed('ui_select'):
		Global.new_game()

func _ready():
	$Items.hide()
	$ScoreNotice.text = "High Score: " + str(Global.highscore)
	spawn_items()


func spawn_items():
	for cell in items.get_used_cells():
		var id = items.get_cellv(cell)
		var type = items.tile_set.tile_get_name(id)
		var pos = items.map_to_world(cell) + items.cell_size / 2
		match type:
			'coin':
				var item = Pickup.instance()
				item.init(type, pos)
				add_child(item)

