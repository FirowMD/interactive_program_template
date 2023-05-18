module main

interface Command {
mut:
	name string
	description string
	aliases []string
	cmdhandler &CommandHandler
	print_help()
	run([]string) !
}

struct CommandEcho {
mut:
	name string = 'echo'
	description string = 'Prints the given text to the console.'
	aliases []string
	cmdhandler &CommandHandler
}

fn (c CommandEcho) print_help() {
	println('Usage: echo <text>')
}

fn (c CommandEcho) run(args []string) ! {
	for arg in args {
		print(arg)
		print(' ')
		flush_stdout()
	}
	println('')
}

struct CommandQuit {
mut:
	name string = 'quit'
	description string = 'Exits the program.'
	aliases []string = ['exit', 'q']
	cmdhandler &CommandHandler
}

fn (c CommandQuit) print_help() {
	println('Usage: quit')
}

fn (c CommandQuit) run(args []string) ! {
	exit(0)
}

struct CommandHelp {
mut:
	name string = 'help'
	description string = 'Prints the help message.'
	aliases []string = ['?', 'h']
	cmdhandler &CommandHandler
}

fn (c CommandHelp) print_help() {
	println('Usage: help [command]')
}

fn (mut c CommandHelp) run(args []string) ! {
	if args.len == 0 {
		commands := c.cmdhandler.get_command_list()
		println('Available commands:')
		for command in commands {
			println('  ' + command.name + ' - ' + command.description)
		}
	} else {
		mut command := c.cmdhandler.get_command(args[0]) or {
			println('Command not found: ${args[0]}')
			return
		}
		command.print_help()
	}
}