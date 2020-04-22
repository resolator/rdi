#!/bin/bash
THEME_NAME=$1
USAGE=$(cat <<-END
Usage: set_theme.sh THEME_NAME
Switch files for selected theme for terminator, bash and tmux.

THEME_NAME can be "light" or "dark".
END
)

_set_theme() {
	cp "$HOME/.bashrc.$THEME_NAME" "$HOME/.bashrc"
	cp "$HOME/.tmux.conf.local.$THEME_NAME" "$HOME/.tmux.conf.local"
	cp "$HOME/.config/terminator/config.$THEME_NAME" "$HOME/.config/terminator/config"
}

if [ "$THEME_NAME" = "--help"  ] || [ "$THEME_NAME" = "-h"  ] || [ "$THEME_NAME" = "" ]
then
	echo "$USAGE"
elif [ "$THEME_NAME" = "light" ] || [ "$THEME_NAME" = "dark" ]
then
	_set_theme
	echo "Done! Don't forget to close all tmux and terminator instances."
else
	echo "Error: wrong THEME_NAME arg. See \"set_theme.sh --help\" for more information."
fi

