extends Resource
class_name  Group

@export var id: int: 
	set(p_val):
		id = p_val
		emit_changed()
@export var name: String: 
	set(p_val):
		name = p_val
		emit_changed()
@export var players: Array[Player] = []

func _init(p_id: int = 0, p_name: String = "", p_players: Array[Player] = []):
	id = p_id
	name = p_name
	players = p_players
	
func add_player(p_player: Player):
	players.append(p_player)
	emit_changed()

func remove_player(p_player: Player):
	players.erase(p_player)
	emit_changed()
