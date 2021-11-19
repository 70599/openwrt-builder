set fish_color_command  normal
set fish_color_cwd_root normal
set fish_color_error    red
set fish_color_param    a4a4a4
set fish_greeting

# function fish_prompt
#	echo -n -s (set_color 888888) $USER (set_color normal) ' ' (prompt_pwd) ' ' (set_color green) '->' (set_color normal) ' '
# end

function fish_prompt
	set -l textcol    normal
	set -l bgcol_user 4c515a
	set -l bgcol      035f85
	set -l arrowcol   035f85

	# set_color $textcol -b $bgcol_user
	# echo -n ' '$USER' '

	set_color $textcol -b $bgcol_user
	echo -n ' '(prompt_hostname)' '

	set_color $textcol -b $bgcol
	echo -n ' '(prompt_pwd)' '

	set_color $arrowcol -b normal
	echo -n ''

	set_color normal -b normal
	echo -n ' '
end


function fish_right_prompt
	set -l duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
	echo -n -s (set_color 888888) $duration (set_color normal)
end

function 'apk add'
	apk add --no-cache $argv
end

function dco
	docker-compose $argv
end

function dex
	docker exec -ti $argv
end

function dim
	docker images $argv
end

function dlo
	docker logs $argv
end

function dps
	docker ps $argv
end

function dpu
	docker pull $argv
end
