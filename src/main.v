module main
import os

fn main() {
	mut cmd_handler := create_command_handler()
	cmd_handler.init()

	println('Interactive program. Type "help" to see available commands.')
	println('Type "quit" to exit.')

	for {
		cmdline := os.input('> ')
		cmd_handler.handle(cmdline)!
	}
}