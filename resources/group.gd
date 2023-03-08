extends Resource
class_name  Group

@export var id: String: 
	set(p_val):
		id = p_val
		emit_changed()
@export var name: String: 
	set(p_val):
		name = p_val
		emit_changed()
@export var players: Array[Player] = []

func _init(p_id: String = "", p_name: String = "", p_players: Array[Player] = []):
	id = p_id
	name = p_name.to_upper()
	players = p_players
	
func add_player(p_player: Player):
	players.append(p_player)
	emit_changed()

func remove_player(p_player: Player):
	players.erase(p_player)
	emit_changed()
	
func reset_indices():
	sort_players()
	for i in players.size():
		players[i].index = i
		
func sort_players():
	players.sort_custom(func(a, b): return a.index < b.index)
	
func save():
	ResourceSaver.save(self, Consts.SAVE_GROUPS_DIR + id + ".tres")
