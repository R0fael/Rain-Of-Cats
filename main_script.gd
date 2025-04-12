extends Control

var cat_num: int = -1
var cat_max: int = 5

var cats_falling: bool = 0

var cat_fall_amounts: Array = [
	0.,
	0.,
	0.,
	0.,
	0.,
	0.,
]
var difficulty_scalar: float = 1.
var fall_amount: float = 0.0
var float_amount: float = 1.

var storm_button_pos_initial: float = 464.
var storm_button_pos_away: float = 700.

func _init() -> void:
	print("h3llo")

func _input(input) -> void:
	if cats_falling:
		adjust_cats_pos()
		watch_cats_pos()
	
func adjust_cats_pos():
	if cat_num > -1:
		for i: int in cat_num + 1:
			#print(i)
			cat_fall_amounts[cat_num] += fall_amount
			var cat : Control = %Control_Cats.find_child("Control_Cat_" + str(i))
			#print(cat)
			cat.position.y += fall_amount
			
func watch_cats_pos():
	if cat_fall_amounts[-1] >= 3700:
		cats_falling = 0
		show_button()
		
		cat_fall_amounts.fill(0.)
		cat_num = -1
		
func show_button() -> void:
	%Button_Storm.position.y = storm_button_pos_initial
	

func _on_button_storm_button_down() -> void:
	print("it is")
	%Button_Storm.position.y = storm_button_pos_away
	
	fall_amount += difficulty_scalar
	
	for i in int(cat_max + 1):
		await gui_input
		#print("goodby")
		show_a_cat()
		
func show_a_cat() -> void:
	print("showing a cat")
	if not cat_num >= cat_max:
		
		var rand_y: float = randf() * 300 + 300
		var rand_x: float = randf() * 600 + 300
		#print("Y pos = ",rand_y)
		#print("X pos = ",rand_x)
		if cat_num < cat_max:
			if not cats_falling:
				cats_falling = 1
			cat_num += 1
			var cat : Control = %Control_Cats.find_child("Control_Cat_" + str(cat_num))
			cat.position.y = rand_y
			cat.position.x = rand_x
			
		
		
