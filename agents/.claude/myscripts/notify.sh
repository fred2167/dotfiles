#!/usr/bin/env bash
# Green label in terminal, single OSC 9 notification banner
printf '\033[32m[Claude: Task done]\033[0m\n' >/dev/tty 2>/dev/null
printf '\033]9;✅ Task done\a' >/dev/tty 2>/dev/null
exit 0
