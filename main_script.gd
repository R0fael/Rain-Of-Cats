extends Control

var font := load("uid://c5c4xptpdbtbf")
var points: int = 0
var hp: int = 100

var msg_show_pos: int = 176.
var msg_away_pos: int = 700.

var cat_num: int = -1
var cat_max: int = 7

var cats_falling: bool = 0

var cats_floating_array: Array[int] = [-7]

var cat_fall_amounts: Array[float] = [
	0.,
	0.,
	0.,
	0.,
	0.,
	0.,
	0.,
	0.,
]
var difficulty_scalar: float = 2.
var fall_amount: float = 0.0
var float_amount: float = 6.

var storm_button_pos_initial: float = 128.
var storm_button_pos_away: float = 700.

var tutorial2_pos_show: float = 88.
var tutorial_pos_show: float = 538.
var tutorial_pos_away: float = 700.

func _init() -> void:
	pass
	

func _input(input) -> void:
	if cats_falling:
		adjust_cats_fall_pos()
		watch_cats_pos()
	
func adjust_cats_fall_pos():
	if cat_num > -1:
		for i: int in cat_num + 1:
			#print(i)
			cat_fall_amounts[cat_num] += fall_amount
			var cat : Control = %Control_Cats.find_child("Control_Cat_" + str(i))
			#print(cat)
			if cats_floating_array.has(i):
				cat.position.y -= float_amount
			if not cats_floating_array.has(i):
				cat.position.y += fall_amount
				
func watch_cats_pos():
	#print(cats_floating_array.find(cats_floating_array.back()))
	if cats_floating_array.find(cats_floating_array.back()) == cat_max + 1:
		if cat_fall_amounts[-1] >= 1600:
			tally_points()
			undo_float_n_fall()
			undo_cats()
		
	if not cats_floating_array == []:
		if not cats_floating_array.find(cats_floating_array.back()) == cat_max + 1:
			if cat_fall_amounts[-1] >= 5750:
				tally_points()
				undo_float_n_fall()
		
func undo_float_n_fall() -> void:
		cats_falling = 0
		cat_fall_amounts.fill(0.)
		cat_num = -1
		cats_floating_array = [-cat_max]
		
		
func show_button() -> void:
	%Button_Storm.position.y = storm_button_pos_initial
	%Button_Tutorial2.position.y = tutorial_pos_away
	undo_cats()
	
func away_button() -> void:
	%Button_Storm.position.y = storm_button_pos_away
	%Button_Tutorial2.position.y = tutorial_pos_away
	undo_cats()
	
	
#func _draw() -> void:
	#print("draw")
	#var pos := position
	#pos.x = 100
	#pos.y = 100
	#draw_string(font,pos,str(hp),0,-1,60)
	#
	
func tally_points() -> void:
	var cat_val: int = cat_max + 1
	var float_array_tally: int = cats_floating_array.find(cats_floating_array.back())
	var add_tally_points: int = float_array_tally - cat_val
	
	print("Points got: ",float_array_tally)
	print("HP Lost: ",add_tally_points * -1)
	
	for i in float_array_tally:
		if %TabBar_FLOAT.tab_count < 32:
			%TabBar_FLOAT.add_tab("0")
	
	for i in add_tally_points * -1:
		if %TabBar_DROP.tab_count < 32:
			%TabBar_DROP.add_tab("X")
	
	show_button()
	
	if %TabBar_FLOAT.tab_count >= 32:
		%Button_Msg_Win.position.y = msg_show_pos
		away_button()
		
		
	if %TabBar_DROP.tab_count >= 32:
		%Button_Msg_Lost.position.y = msg_show_pos
		away_button()
		
	if %TabBar_DROP.tab_count >= 32 and %TabBar_FLOAT.tab_count >= 32:
		%Button_Msg_Lost.position.y = msg_away_pos
		%Button_Msg_Win.position.y = msg_away_pos
		%Button_Msg_Draw.position.y = msg_show_pos
		
		away_button()
		
		
		
	
	#points += float_array_tally
	#hp -= add_tally_points
	
	#notification(NOTIFICATION_DRAW)
	
func undo_cats() -> void:
	for i: int in cat_max + 1:
		var cat : Control = %Control_Cats.find_child("Control_Cat_" + str(i))
		cat.position.y = 0

func _on_button_storm_button_down() -> void:
	%Button_Storm.position.y = storm_button_pos_away
	
	fall_amount += difficulty_scalar
	
	%Button_Tutorial.position.y = tutorial_pos_show
	%Button_Tutorial2.position.y = tutorial_pos_away
	
	for i in int(cat_max + 1):
		await gui_input
		#print("goodby")
		show_a_cat()
		
func show_a_cat() -> void:
	#print("showing a cat")
	if not cat_num >= cat_max:
		
		var rand_y: float = randf() * 300 + 300
		var rand_x: float = randf() * 600 + 300
		#print("X pos = ",rand_x)
		#print("Y pos = ",rand_y)
		if cat_num < cat_max:
			if not cats_falling:
				cats_falling = 1
				%Button_Tutorial.position.y = tutorial_pos_away
				%Button_Tutorial2.position.y = tutorial_pos_show
			cat_num += 1
			var cat : Control = %Control_Cats.find_child("Control_Cat_" + str(cat_num))
			cat.position.y = rand_y
			cat.position.x = rand_x


func _on_cat_0_button_down() -> void:
	if not cats_floating_array.has(0):
		cats_floating_array.push_back(0)

func _on_cat_1_button_down() -> void:
	if not cats_floating_array.has(1):
		cats_floating_array.push_back(1)

func _on_cat_2_button_down() -> void:
	if not cats_floating_array.has(2):
		cats_floating_array.push_back(2)

func _on_cat_3_button_down() -> void:
	if not cats_floating_array.has(3):
		cats_floating_array.push_back(3)

func _on_cat_4_button_down() -> void:
	if not cats_floating_array.has(4):
		cats_floating_array.push_back(4)

func _on_cat_5_button_down() -> void:
	if not cats_floating_array.has(5):
		cats_floating_array.push_back(5)
		
func _on_cat_6_button_down() -> void:
	if not cats_floating_array.has(6):
		cats_floating_array.push_back(6)

func _on_cat_7_button_down() -> void:
	if not cats_floating_array.has(7):
		cats_floating_array.push_back(7)
