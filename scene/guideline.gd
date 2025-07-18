extends Node2D

@onready var windows_email := $guidline
@onready var drag_area := windows_email.get_node("Area2D")

var dragging := false
var drag_offset := Vector2.ZERO

func _ready():
	drag_area.input_event.connect(_on_drag_area_input_event)

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
		

func _on_close_guideline_pressed() -> void:
	$guidline.hide()


func _on_guidelineapp_pressed() -> void:
	$guidline.show()
