set -g fish_term24bit						1
set -g fish_color_command  			normal
set -g fish_color_cwd_root 			normal
set -g fish_color_error    			red
set -g fish_color_param    			foreground
set -g fish_color_autosuggestion	brblack
set -g fish_greeting

function fish_prompt
	echo -ne -s (set_color brblue) '┌ ' (set_color brblack) (prompt_hostname) (set_color brblue) ' ' (prompt_pwd) '\n' (set_color brblue) '└─ ϟ' (set_color normal) ' '
end

# function fish_prompt
# 	set -l textcol    normal
# 	set -l bgcol_user 4c515a
# 	set -l bgcol      035f85
# 	set -l arrowcol   035f85

# 	# set_color $textcol -b $bgcol_user
# 	# echo -n ' '$USER' '

# 	set_color $textcol -b $bgcol_user
# 	echo -n ' '(prompt_hostname)' '

# 	set_color $textcol -b $bgcol
# 	echo -n ' '(prompt_pwd)' '

# 	set_color $arrowcol -b normal
# 	echo -n ''

# 	set_color normal -b normal
# 	echo -n ' '
# end


function fish_right_prompt
	set -l duration (echo "$CMD_DURATION 1000" | awk '{printf "%.3fs", $1 / $2}')
	echo -n -s (set_color brblack) $duration (set_color normal)
end

function 'apk add'
	apk add --no-cache $argv
end

function dco
	docker-compose $argv
end

function 'dco-reset'
	docker-compose stop $argv[1] && docker-compose rm $argv[1] -f && docker-compose build --no-cache $argv[1] && docker-compose up $argv[1] -d
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
