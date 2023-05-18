# Overview

Template for interactive programs, which will be written in V.

Includes a small amount of built-in features:

- Help message printing (just `help` and also `help <command>`)
- Aliases (for example you can use `q` instead of `quit`)

# Command creating
To create a new command follow the steps:

1. Create structure based on `Command` interface like existing one:

```v
struct CommandEcho {
mut:
	name string = 'echo'
	description string = 'Prints the given text to the console.'
	aliases []string
	cmdhandler &CommandHandler
}
```

2. Add `print_help` and `run` functions to your structure

3. Add created structure to `CommandHandler` (`init` function):

```v
fn (mut c CommandHandler) init() {
    // Put new commands here
	c.add_command(CommandEcho{ cmdhandler: &c })
	c.add_command(CommandQuit{ cmdhandler: &c })
	c.add_command(CommandHelp{ cmdhandler: &c })
}
```