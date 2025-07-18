extends Node2D

var first_talk = 0 
var phone_is_Active = false

func _ready():
	$chat_screen/Chat.hide()
	$chat_screen/Backbutton.hide()
	spawn_chat("ลูก","res://assets/img/demo_cilent_pic/1.svg","แชทลูก")
	spawn_chat("พ่อ","res://assets/img/demo_cilent_pic/2.svg","แชทพ่อ")
	spawn_chat("แม่","res://assets/img/demo_cilent_pic/3.svg","แชทแม่")

func _on_button_pressed() -> void:
	$AnimationPlayer.play("Chat_popout")
	await $AnimationPlayer.animation_finished
	phone_is_Active = false


func _on_chat_app_pressed() -> void:
	$chat_screen/boss_chat.hide()
	$chat_screen/all_chat2.hide()
	if phone_is_Active == false:
		#$chat_screen/all_chat2.show()
		$chat_screen/boss_chat/boss_chat_VBoxContainer.hide()
		$AnimationPlayer.play("Chat_popup")
		await $AnimationPlayer.animation_finished
		phone_is_Active = true


func _on_boss_chat_card_pressed() -> void:
	$chat_screen/all_chat2.hide()
	$chat_screen/boss_chat/boss_chat_VBoxContainer.show()
	if first_talk == 0:
		$AnimationPlayer.play("boss_chat")
		await $AnimationPlayer.animation_finished
		$chat_screen/boss_chat/boss_chat_VBoxContainer/Choice.show()
		first_talk = 1


func _on_yes_button_c_1_pressed() -> void:
	$chat_screen/boss_chat/boss_chat_VBoxContainer/Choice.hide()
	$AnimationPlayer.play("boss_chat1_yes")
	await $AnimationPlayer.animation_finished


func _on_no_button_c_1_pressed() -> void:
	$chat_screen/boss_chat/boss_chat_VBoxContainer/Choice.hide()
	$AnimationPlayer.play("boss_chat1_no")
	await $AnimationPlayer.animation_finished
	
	
var ProblemScene := preload("res://scene/chat_icon_template.tscn")

func spawn_chat(name_text: String, avatar_path: String, chat_detail: String):
	var case_instance = ProblemScene.instantiate()

	# ตั้งค่าข้อความ
	case_instance.get_node("Label").text = name_text

	# เปลี่ยน Avatar (TextureRect)
	var avatar_node = case_instance.get_node("TextureRect")
	var new_texture = load(avatar_path)
	if avatar_node and new_texture:
		avatar_node.texture = new_texture
		
	# จัดการปุ่ม
	var button_node = case_instance.get_node("Button")
	if button_node:
		button_node.pressed.connect(show_chat.bind(chat_detail))

	# เพิ่มเข้า VBoxContainer
	$chat_screen/ScrollContainer/VBoxContainer.add_child(case_instance)
	
func show_chat(chat_detail: String):
	$chat_screen/ScrollContainer.hide()
	$chat_screen/Chat.show()
	$chat_screen/Backbutton.show()
	$chat_screen/Label.text = "Chat"
	$chat_screen/Chat/VBoxContainer/TextureRect/chat_detail.text = chat_detail
	
func _on_backbutton_pressed() -> void:
	$chat_screen/ScrollContainer.show()
	$chat_screen/Chat.hide()
	$chat_screen/Label.text = "Chat Headed"
	$chat_screen/Backbutton.hide()
