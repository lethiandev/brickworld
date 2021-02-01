extends LineEdit

const name_list = [
	"Sau",
	"Leann",
	"Gus",
	"Abel",
	"Jacinto",
	"Natisha",
	"Kattie",
	"Floyd",
	"Eilene",
	"Tamala",
]

func _ready() -> void:
	randomize()
	text = _get_random_name()

func _get_random_name() -> String:
	var idx = randi() % name_list.size()
	return name_list[idx]
