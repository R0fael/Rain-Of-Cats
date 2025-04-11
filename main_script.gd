extends Control

var cat_num: int = 0
var cat_max: int = 10

func _init() -> void:
	print("h3llo")



func _on_button_storm_button_down() -> void:
	for i in int(100):
		print("goodby")
		await gui_input
		show_a_cat()
		
func show_a_cat() -> void:
	var rand_y: float = randf() * 300 + 200
	var rand_x: float = randf() * 600 + 300
	#print("Y pos = ",rand_y)
	#print("X pos = ",rand_x)
	if cat_num < cat_max:
		cat_num += 1
		var cat := %Control_Cats.find_child("Button_Cat_" + str(cat_num))
		cat.position.y = rand_y
		cat.position.x = rand_x
		
	if cat_num >= cat_max:
		print("out of cats")
	
