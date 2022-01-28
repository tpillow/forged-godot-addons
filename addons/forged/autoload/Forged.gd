extends Node

var Log: ForgedLogger = ForgedLogger.new()
var Util: ForgedUtil = ForgedUtil.new()
var GroupUtil: ForgedGroupUtil = ForgedGroupUtil.new()
var SceneManager: FSceneManager = FSceneManager.new()
var Preloads: ForgedPreloads = ForgedPreloads.new()

func _ready():
	SceneManager.initialize(get_tree())
