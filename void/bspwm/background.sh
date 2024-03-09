#!/bin/env bash
#
# set desktop background and change it after a some time
# background image is taken from given input (or default directory)
# default interval is 240s, but may change through input

help() {
        cat <<END
        Available options are:
         -d <dir>       set images directory
         -t <time>      set time interval to change wallpaper
         -h             display this help message
END
}

while getopts :d:th ARG; do
    case "${ARG}" in
        d) wallpaper_dir=${OPTARG:='~/walls'};;
        t) interval=${OPTARG:=240};;
        h) help && exit 1;;
        *) echo "Wrong Arguments!" && help && exit 1;;
    esac
done
# setting default values
# TODO: find a better way to do this
[[ -z "${interval}" ]] && interval=240
[[ -z "${wallpaper_dir}" ]] && wallpaper_dir='~/walls'
readonly interval
readonly wallpaper_dir

# signals should be sent to sleep's PID
trap 'set_background' 10
trap 'set_background' 12

while true; do
        image_file=$(ls -a "${wallpaper_dir}" | shuf | sed 1q)
        feh --no-fehbg --bg-scale "${wallpaper_dir}"/"${image_file}"
        sleep "${interval}"
done

