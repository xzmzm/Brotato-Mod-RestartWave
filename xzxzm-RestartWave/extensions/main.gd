extends "res://main.gd"

const RESTARTWAVE_LOG = "xzxzm-RestartWave"

var _respawn_menu
var _respawn_timer: Timer

func _ready():
	ModLoaderLog.info("main ready", "RestartWave")
	_respawn_menu = preload("res://mods-unpacked/xzxzm-RestartWave/extensions/restartwave.tscn").instance()
	$UI.add_child(_respawn_menu)
	_respawn_timer = _respawn_menu.get_node("%Timer")
	_respawn_timer.connect("timeout", self, "_on_respawn_timer_timeout")
	_respawn_menu.hide()
	_respawn_menu.respawn_timer = _respawn_timer
	
	_respawn_menu.connect("confirm_respawn_button_pressed", self, "_on_confirm_respawn")
	_respawn_menu.connect("cancel_respawn_button_pressed", self, "_on_cancel_respawn")
	_respawn_menu.connect("respawn_cancel_by_input", self, "_on_respawn_cancel_by_input")

func _on_player_died(_p_player:Player)->void :
	if RunData.current_wave <= RunData.nb_of_waves:
		if RunData.current_wave > 1:
			pause_before_choose_respawn()
			ModLoaderLog.info("player is killed", "RestartWave")
			if not _respawn_menu.visible:
				_respawn_menu.show()
				_respawn_menu.reset()
				_respawn_timer.start(10)
			return
		else:
			_player_life_bar.hide()
			_is_run_lost = true
	else:
		_player_life_bar.hide()
		_is_run_won = true
	clean_up_room(false, _is_run_lost, _is_run_won)
	_end_wave_timer.start()
	ProgressData.reset_run_state()
	ChallengeService.complete_challenge("chal_rookie")

func _on_respawn_timer_timeout():
	ModLoaderLog.info("respawn timeout", "RestartWave")
	_on_cancel_respawn()

func _on_confirm_respawn():
	if _respawn_menu.visible:
		_respawn_menu.hide()
		_respawn_timer.stop()
	ModLoaderLog.info("confirm respawn", "RestartWave")
	ProgressData.load_game_file()
	RunData.resume_from_state(ProgressData.current_run_state)
	var _error = get_tree().change_scene(MenuData.shop_scene)
	unpause_after_choose_respawn()

func _on_cancel_respawn():
	if _respawn_menu.visible:
		_respawn_menu.hide()
		_respawn_timer.stop()
	ModLoaderLog.info("cancel respawn", "RestartWave")
	unpause_after_choose_respawn()
	_player_life_bar.hide()
	_is_run_lost = true
	clean_up_room(false, _is_run_lost, _is_run_won)
	_end_wave_timer.start()
	ProgressData.reset_run_state()
	ChallengeService.complete_challenge("chal_rookie")
	
func _on_respawn_cancel_by_input():
	ModLoaderLog.info("respawn cancel by input", "RestartWave")
	_on_cancel_respawn()

func pause_before_choose_respawn():
	emit_signal("paused")
	# ProgressData.update_mouse_cursor(true)
	get_tree().paused = true

func unpause_after_choose_respawn():
	# ProgressData.update_mouse_cursor()
	get_tree().paused = false
	emit_signal("unpaused")
