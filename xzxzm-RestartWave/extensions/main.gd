extends "res://main.gd"

const RESTARTWAVE_LOG = "xzxzm-RestartWave"

var _restart_wave_menu
var _restart_wave_timer: Timer

func _ready():
	ModLoaderLog.info("main ready", "RestartWave")
	_restart_wave_menu = preload("res://mods-unpacked/xzxzm-RestartWave/extensions/restartwave.tscn").instance()
	$UI.add_child(_restart_wave_menu)
	_restart_wave_timer = _restart_wave_menu.get_node("%Timer")
	_restart_wave_timer.connect("timeout", self, "_on_restart_wave_timer_timeout")
	_restart_wave_menu.hide()
	_restart_wave_menu.restart_wave_timer = _restart_wave_timer

	_restart_wave_menu.connect("confirm_restart_wave_button_pressed", self, "_on_confirm_restart_wave")
	_restart_wave_menu.connect("cancel_restart_wave_button_pressed", self, "_on_cancel_restart_wave")
	_restart_wave_menu.connect("restart_wave_cancel_by_input", self, "_on_restart_wave_cancel_by_input")
	
func _on_player_died(_p_player:Player)->void :
	if RunData.current_wave <= RunData.nb_of_waves:
		if RunData.current_wave > 1:
			pause_before_choose_restart_wave()
			ModLoaderLog.info("player is killed", "RestartWave")
			if not _restart_wave_menu.visible:
				_restart_wave_menu.show()
				_restart_wave_menu.reset()
				_restart_wave_timer.start(10)
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

func _on_confirm_restart_wave():
	if _restart_wave_menu.visible:
		_restart_wave_menu.hide()
	ModLoaderLog.info("confirm restart wave", "RestartWave")
	ProgressData.load_game_file()
	RunData.resume_from_state(ProgressData.current_run_state)
	var _error = get_tree().change_scene(MenuData.shop_scene)
	unpause_after_choose_restart_wave()

func _on_cancel_restart_wave():
	if _restart_wave_menu.visible:
		_restart_wave_menu.hide()
	ModLoaderLog.info("cancel restart wave", "RestartWave")
	unpause_after_choose_restart_wave()
	_player_life_bar.hide()
	_is_run_lost = true
	clean_up_room(false, _is_run_lost, _is_run_won)
	_end_wave_timer.start()
	ProgressData.reset_run_state()
	ChallengeService.complete_challenge("chal_rookie")
	
func _on_restart_wave_cancel_by_input():
	ModLoaderLog.info("restart wave cancel by input", "RestartWave")
	_on_cancel_restart_wave()

func _on_restart_wave_timer_timeout():
	ModLoaderLog.info("restart wave timeout", "RestartWave")
	_on_cancel_restart_wave()

func pause_before_choose_restart_wave():
	emit_signal("paused")
	# ProgressData.update_mouse_cursor(true)
	get_tree().paused = true

func unpause_after_choose_restart_wave():
	# ProgressData.update_mouse_cursor()
	get_tree().paused = false
	emit_signal("unpaused")
