#!/usr/bin/env bash

# Bash completion for pikman. Perhaps not the best yet 
  
commands=(
	"autoremove"
	"clean"
	"enter"
	"export"
	"init"
	"install"
	"list"
	"log"
	"purge"
	"run"
	"remove"
	"search"
	"show"
	"unexport"
	"update"
	"upgrade"
	"upgrades"
	"help"
) 
command_string="${commands[@]}"
complete -W "${command_string}" pikman
