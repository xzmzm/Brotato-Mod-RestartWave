extends Node

const RESTARTWAVE_LOG = "xzxzm-RestartWave"
const RESTARTWAVE_MOD_DIR = "xzxzm-RestartWave/"
var dir = ""

func _init(modLoader = ModLoader):
	name = "RestartWave"
	ModLoaderLog.info("Init", RESTARTWAVE_LOG)
	dir = ModLoaderMod.get_unpacked_dir() + RESTARTWAVE_MOD_DIR
	ModLoaderMod.install_script_extension(dir + "extensions/main.gd")

func _ready():
	ModLoaderUtils.log_info("Mod RestartWave ready.", RESTARTWAVE_LOG)
