extends "res://ui/menus/run/end_run.gd"

func _on_RetryButton_pressed()->void :
    if retry_button_pressed:
        return 
    
    retry_button_pressed = true
    ProgressData.load_game_file()
    RunData.resume_from_state(ProgressData.current_run_state)
    var _error = get_tree().change_scene(MenuData.shop_scene)
