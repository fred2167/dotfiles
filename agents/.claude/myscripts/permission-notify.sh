#!/usr/bin/env bash
# Yellow label in terminal, OSC 9 banner + two bells for extra urgency
printf '\033[33m[Claude: Approve required]\033[0m\n' >/dev/tty 2>/dev/null
printf '\033]9;⚠️ Approve required\a' >/dev/tty 2>/dev/null
printf '\a\a' >/dev/tty 2>/dev/null
exit 0
