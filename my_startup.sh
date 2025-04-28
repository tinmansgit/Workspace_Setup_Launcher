#!/bin/bash
# change workspace names and numbers as needed
# modify delay time between commands as needed 
# change programs with program launch paths to fit your setup

DEBUG_LOG="~/bin/Bash/Startups/log_my-startup_debug.log"
ERROR_LOG="~/bin/Bash/Startups/log_my-startup_error.log"

log_debug() {echo "$(date '+%Y-%m-%d %H:%M:%S') [DEBUG] $1" >> "$DEBUG_LOG"}

log_error() {echo "$(date '+%Y-%m-%d %H:%M:%S') [ERROR] $1" >> "$ERROR_LOG"}

run_command() {
    local cmd="$1"
    log_debug "Running: $cmd"
    eval "$cmd"
    local exit_code=$?
    if [ $exit_code -ne 0 ]; then
        log_error printf"%s [ERROR] Command failed: "%s"\n Exit code: %s\n" "(date′+cmd" "exitc​ode">>"ERROR_LOG"
    fi
    return $exit_code
}

sleep_debug() {
    local delay="$1"
    log_debug "Sleeping for ${delay}s..."
    sleep "$delay"
}

# Workspace 1 (set_desktop starts workspace numbering at 0, set_desktop 0 = Workspace 1)
run_command "/usr/bin/xdotool set_desktop 0 &"
sleep_debug 3 # time in seconds to delay before executing the next command
run_command "/usr/bin/thunar /home/ &"
sleep_debug 15
run_command "/usr/bin/protonvpn-app &"
sleep_debug 20
run_command "/usr/bin/evolution &"
sleep_debug 15
log_debug "Workspace 1 setup complete"

# Workspace 2
run_command "/usr/bin/xdotool set_desktop 1 &"
sleep_debug 3
run_command "/usr/bin/qjackctl &"
sleep_debug 15
run_command "/usr/bin/calfjackhost -l /Saved-Presets/Video-Comp &"
sleep_debug 15
log_debug "Workspace 2 setup complete"

# Workspace 3
run_command "/usr/bin/xdotool set_desktop 2 &"
sleep_debug 3
run_command "/usr/bin/firefox &"
sleep_debug 15
log_debug "Workspace Code setup complete"

# Workspace 4
run_command "/usr/bin/xdotool set_desktop 3 &"
sleep_debug 3
run_command "/usr/bin/lowriter -o /path/to/your/file.odt &" # opens a specified file in LibreOffice Writer
sleep_debug 15
run_command "cd ~/bin/Python/Countdown_Timer && python3 countdown-timer.py &"
sleep_debug 15
log_debug "Workspace 4 setup complete"

# return to Workspace 1
run_command "/usr/bin/xdotool set_desktop 0 &"
log_debug "Startup script completed."

exit 0
