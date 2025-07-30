#!/bin/bash

if [ $# -ne 2 ];then
    echo "Usage: wlogout-helper <command>"
    echo "Commands: 'lock' | 'logout' | 'reboot' | 'suspend' | 'hibernate' |  'shutdown'"
    echo "Example: wlogout-helper logout"

fi

terminate_clients() {
  TIMEOUT=5
  # Get a list of all client PIDs in the current Hyprland session
  client_pids=$(hyprctl clients -j | jq -r '.[] | .pid')

  # Send SIGTERM (kill -15) to each client PID and wait for termination
  for pid in $client_pids; do
    echo ":: Sending SIGTERM to PID $pid"
    kill -15 $pid
  done

  start_time=$(date +%s)
  for pid in $client_pids; do
    # Wait for the process to terminate
    while kill -0 $pid 2>/dev/null; do
      current_time=$(date +%s)
      elapsed_time=$((current_time - start_time))

      if [ $elapsed_time -ge $TIMEOUT ]; then
        echo ":: Timeout reached."
        return 0
      fi

      echo ":: Waiting for PID $pid to terminate..."
      sleep 1
    done

    echo ":: PID $pid has terminated."
  done
}

if [[ "$1" == "logout" ]]; then
  echo "Logging out..."
  terminate_clients
  sleep 0.5
  hyprctl dispatch exit
  sleep 2
fi

if [[ "$1" == "lock" ]]; then
  echo "Locking the system..."
  sleep 0.5
  hyprlock
fi

if [[ "$1" == "reboot" ]]; then
  echo "Rebooting..."
  terminate_clients
  sleep 0.5
  systemctl reboot
fi

if [[ "$1" == "shutdown" ]]; then
  echo "Shooting down the system..."
  terminate_clients
  sleep 0.5
  systemctl poweroff
fi

if [[ "$1" == "suspend" ]]; then
  echo "Suspending the system..."
  sleep 0.5
  systemctl suspend
fi

if [[ "$1" == "hibernate" ]]; then
  echo "Hibernating the system..."
  sleep 1
  systemctl hibernate
fi
