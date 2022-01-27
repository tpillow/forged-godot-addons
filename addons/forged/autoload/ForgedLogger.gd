class_name ForgedLogger
extends Object

enum FLogLevel {
	NONE,
	TRACE,
	DEBUG,
	INFO,
	WARN,
	ERR,
}

var logLevel: int = FLogLevel.TRACE

func trace(msg: String):
	_genericLog(FLogLevel.TRACE, msg)
	
func debug(msg: String):
	_genericLog(FLogLevel.DEBUG, msg)
	
func info(msg: String):
	_genericLog(FLogLevel.INFO, msg)
	
func warn(msg: String):
	_genericLog(FLogLevel.WARN, msg)
	
func err(msg: String):
	_genericLog(FLogLevel.ERR, msg)

func _genericLog(level: int, msg: String):
	if level <= logLevel:
		print("[" + FLogLevel.keys()[level] + "] " + msg)
