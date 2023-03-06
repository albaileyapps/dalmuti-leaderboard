extends Resource
class_name  Group

@export var id: int
@export var name: String
@export var players: Array[Player] = []

func _init(p_id: int = 0, p_name: String = "", p_players: Array[Player] = []):
	id = p_id
	name = p_name
	players = p_players
	
func add_player(p_player: Player):
	players.append(p_player)

func remove_player(p_player: Player):
	players.erase(p_player)
