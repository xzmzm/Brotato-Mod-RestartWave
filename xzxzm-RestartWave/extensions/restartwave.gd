class_name RestartWaveConfirm
extends PanelContainer

signal cancel_respawn_button_pressed
signal confirm_respawn_button_pressed
signal respawn_cancel_by_input

var respawn_timer: Timer
var timer_label:Label
var current_color:Color


func reset():
	$VBoxContainer/Buttons/ConfirmButton.grab_focus()
	current_color = timer_label.modulate

func _input(event):
	if self.visible && event.is_action_pressed("ui_cancel") :
		emit_signal("respawn_cancel_by_input")
		

# Called when the node enters the scene tree for the first time.
func _ready():
	timer_label  = $VBoxContainer/Buttons/TimerLabel
	reset()

func _on_ConfirmButton_pressed():
	emit_signal("confirm_respawn_button_pressed")
	
	

func _on_CancelButton_pressed():
	emit_signal("cancel_respawn_button_pressed")

func _process(_delta:float)->void :
	if not self.visible:
		return
	if respawn_timer != null and is_instance_valid(respawn_timer):
		timer_label.text = str(ceil(respawn_timer.time_left))
		
		if respawn_timer.time_left <= 5 && current_color != Color.red:
			current_color = Color.red
			timer_label.modulate = current_color
		elif respawn_timer.time_left > 5 && current_color != Color.white:
			current_color = Color.white
			timer_label.modulate = current_color
