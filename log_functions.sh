#!/usr/bin/env bash


log_colors()
{
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    LIGHT_MAGENTA='\033[0;95m'
    LIGHT_CYAN='\033[0;96m'
    RESET='\033[0m'
}

log_it()
{
    local log_status=''
    local log_color=''
    local log_message="$*"

    log_colors

    case ${LOG_LEVEL_FUNCTION} in
        "OK")
            log_color=${GREEN}
            log_status='SUCCESS'
            ;;
        "WARNING")
            log_color=${YELLOW}
            log_status='WARNING'
            ;;
        "ERROR")
            log_color=${RED}
            log_status='ERROR'
            ;;
        "PROGRESS")
            log_color=${LIGHT_CYAN}
            log_status='PROGRESS'
            ;;
    esac

    DATE="$(date +"%Y-%m-%d %H:%M:%S")"
    if [ -n "${log_message}" ]; then
        printf "%b[ %s ] %s: %b%s\\n" "${log_color}" "${log_status}" "${DATE}" "${RESET}" "${log_message}"
    fi
}

log_ok() { LOG_LEVEL_FUNCTION="OK" ; log_it "$*"; }
log_warning() { LOG_LEVEL_FUNCTION="WARNING" ; log_it "$*"; }
log_error() { LOG_LEVEL_FUNCTION="ERROR" ; log_it "$*"; }
log_progress() { LOG_LEVEL_FUNCTION="PROGRESS" ; log_it "$*"; }


log_check_function()
{
    FUNC="${1}"

    if $FUNC; then
        log_ok "${FUNC}: OK"
    else
        log_error "${FUNC}: ERROR"
    fi
}
