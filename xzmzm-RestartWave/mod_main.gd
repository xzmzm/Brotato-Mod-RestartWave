extends Node

const RESTARTWAVE_LOG = "xzmzm-RestartWave"
const RESTARTWAVE_MOD_DIR = "xzmzm-RestartWave/"
var dir = ""

func _init(modLoader = ModLoader):
	name = "RestartWave"
	ModLoaderLog.info("Init", RESTARTWAVE_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + RESTARTWAVE_MOD_DIR
	ModLoaderMod.install_script_extension(dir + "extensions/main.gd")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.en.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.fr.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.zh.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.ja.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.ko.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.zh_TW.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.ru.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.pl.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.es.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.pt.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.de.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.tr.translation")
	ModLoaderMod.add_translation(dir + "translations/restart_wave_translations.it.translation")

func _ready():
	ModLoaderUtils.log_info("Mod RestartWave ready.", RESTARTWAVE_LOG)
