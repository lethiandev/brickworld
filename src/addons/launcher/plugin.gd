tool
extends EditorPlugin

const CONTAINER_TARGET = EditorPlugin.CONTAINER_TOOLBAR
const SETTING_INSTANCES_NAME = "editor/launch_instances"
const SETTING_ARGUMENTS_NAME = "editor/launch_arguments"

var launch_button: ToolButton = null
var launch_pids: Array = []

func _enter_tree() -> void:
	launch_button = ToolButton.new()
	launch_button.text = "Launch Game"
	launch_button.connect("pressed", self, "_on_launch_button_pressed")
	add_control_to_container(CONTAINER_TARGET, launch_button)
	
	if not ProjectSettings.has_setting(SETTING_INSTANCES_NAME):
		ProjectSettings.set_setting(SETTING_INSTANCES_NAME, 2)
	if not ProjectSettings.has_setting(SETTING_ARGUMENTS_NAME):
		ProjectSettings.set_setting(SETTING_ARGUMENTS_NAME, PoolStringArray())

func _exit_tree() -> void:
	remove_control_from_container(CONTAINER_TARGET, launch_button)
	launch_button.queue_free()

func _process(p_delta: float) -> void:
	var interface = get_editor_interface()
	if not interface.is_playing_scene() and not launch_pids.empty():
		for pid in launch_pids:
			OS.kill(pid)
		launch_pids = []
		set_process(false)

func _on_launch_button_pressed() -> void:
	var interface = get_editor_interface()
	if interface.is_playing_scene():
		return
	
	var editor_exec = OS.get_executable_path()
	var instances = ProjectSettings.get_setting(SETTING_INSTANCES_NAME)
	var arguments = ProjectSettings.get_setting(SETTING_ARGUMENTS_NAME)
	
	for i in range(clamp(instances - 1, 1, 10)):
		var evalued = _compile_arguments(arguments, i)
		if evalued == null:
			printerr("Failed to prepare launch arguments")
			return
		var pid = OS.execute(editor_exec, evalued, false)
		launch_pids.push_back(pid)
		OS.delay_msec(200)
	
	interface.play_main_scene()
	set_process(true)

func _compile_arguments(p_arguments: Array, p_index: int):
	var compiled_args = PoolStringArray()
	compiled_args.resize(p_arguments.size())
	
	for arg in p_arguments:
		var cmdline = _compile_argument(arg, p_index)
		if cmdline == null:
			return null
		compiled_args.push_back(cmdline)
	
	return compiled_args

func _compile_argument(p_argument: String, p_index: int):
	var compiler = Expression.new()
	
	if not compiler.parse(p_argument, ["index"]) == OK:
		print("Failed to prepare %s argument" % p_argument)
		return null
	
	var result = compiler.execute([p_index])
	if compiler.has_execute_failed():
		print("Failed to compile %s argument" % p_argument)
		return null
	
	return result
