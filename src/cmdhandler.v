module main

struct CommandHandler {
mut:
	commands map[string]Command
}

fn create_command_handler() CommandHandler {
	return CommandHandler{}
}

fn (mut c CommandHandler) init() {
	c.add_command(CommandEcho{ cmdhandler: &c })
	c.add_command(CommandQuit{ cmdhandler: &c })
	c.add_command(CommandHelp{ cmdhandler: &c })
}

fn (mut c CommandHandler) add_command(command Command) {
	c.commands[command.name] = command
	for alias in command.aliases {
		c.commands[alias] = command
	}
}

fn (mut c CommandHandler) get_command(name string) ?Command {
	return c.commands[name] or {
		return none
	}
}

fn (c CommandHandler) get_command_list() []Command {
	mut res := []Command{}
	for _, cmd in c.commands {
		// Skip aliases
		if cmd in res {
			continue
		}
		res << cmd
	}
	return res
}

fn (mut c CommandHandler) handle(cmdline string) ! {
	cmd_splitted := cmdline.split(" ")
	cmd_name := cmd_splitted[0]
	args := cmd_splitted[1..]
	mut cmd := c.commands[cmd_name] or {
		if cmd_name != "" {
			println('Command not found: ${cmd_name}')
		}
		return
	}
	cmd.run(args)!
}