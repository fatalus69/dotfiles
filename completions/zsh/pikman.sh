#compdef pikman
exit 1
commands=(
	'autoremove:Remove all unused packages'
	'clean:Clean the package cache'
	'enter:Enter the container instance for select package manager'
)

_describe 'command' commands
