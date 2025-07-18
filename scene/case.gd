extends Node2D

@onready var windows_email := $case
@onready var drag_area := windows_email.get_node("Area2D")

var dragging := false
var drag_offset := Vector2.ZERO

var chat_node

func _ready():
	drag_area.input_event.connect(_on_drag_area_input_event)
	chat_node = get_node("/root/Node2D/Chat")
	spawn_case("Manee", "Call Center", "ยังไม่เริ่ม","res://assets/img/demo_cilent_pic/2.svg",1)
	spawn_case("Arthit", "Phishing", "ยังไม่เริ่ม","res://assets/img/demo_cilent_pic/3.svg",1)
	spawn_case("Arthit", "Phishing", "ยังไม่เริ่ม","res://assets/img/demo_cilent_pic/3.svg",1)
	spawn_case("Arthit", "Phishing", "ยังไม่เริ่ม","res://assets/img/demo_cilent_pic/3.svg",1)
	spawn_case("Arthit", "Phishing", "ยังไม่เริ่ม","res://assets/img/demo_cilent_pic/3.svg",1)
	

func _on_drag_area_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_offset = windows_email.global_position - event.global_position
			# ป้องกันการกิน event ต่อ
			get_viewport().set_input_as_handled()
		else:
			dragging = false

func _input(event):
	if dragging and event is InputEventMouseMotion:
		windows_email.global_position = event.global_position + drag_offset
		
		


func _on_close_case_pressed() -> void:
	$windows.play("WindowsPopout")
	await $windows.animation_finished
	windows_email.hide()

var case_Is_active = false

func _on_case_app_pressed() -> void:
	$case.show()
	if case_Is_active == false:
		$case2.play("case_popup")
		await $case2.animation_finished
		case_Is_active = true


func _on_button_pressed() -> void:
	$case2.play("case_popout")
	await $case2.animation_finished
	$case.hide()
	case_Is_active = false
	
var ProblemScene := preload("res://scene/case_problem.tscn")

func spawn_case(name_text: String, problem_text: String, state_text: String, avatar_path: String ,case_animation: int):
	var case_instance = ProblemScene.instantiate()

	# ตั้งค่าข้อความ
	case_instance.get_node("name").text = "NAME : %s" % name_text
	case_instance.get_node("name/problem").text = "PROBLEM : %s" % problem_text
	case_instance.get_node("case_state_NinePatchRect/state").text = state_text

	# เปลี่ยน Avatar (TextureRect)
	var avatar_node = case_instance.get_node("Avatar")
	var new_texture = load(avatar_path)
	if avatar_node and new_texture:
		avatar_node.texture = new_texture
		
	# จัดการปุ่ม
	var button_node = case_instance.get_node("problem1_button")
	if button_node:
		button_node.pressed.connect(case_animation_play.bind(case_animation))

	$case/ScrollContainer/VBoxContainer.add_child(case_instance)

	# เพิ่มเข้า VBoxContainer
	$case/ScrollContainer/VBoxContainer.add_child(case_instance)

func case_animation_play(case_check: int):
	var case = case_check
	if case ==1:
		$case/ScrollContainer/VBoxContainer.hide()
		#$case/Case1.show()
		#$case2.play("case1")
		#await $case2.animation_finished
		
		
