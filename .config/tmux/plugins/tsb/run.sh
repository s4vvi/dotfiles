#!/usr/bin/env bash

pane=$(tmux capture-pane -p -S '-' -J -t !)
pattern="❯❯ "
result=$(echo "$pane" | tac | tail -n +3 | sed "/$pattern/,\$d" | tac)

echo "$result" > /tmp/result
