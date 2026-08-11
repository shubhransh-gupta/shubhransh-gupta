#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
PORT="${1:-4173}"

echo "Starting local README preview on http://localhost:${PORT}"
echo "Press Ctrl+C to stop."
echo

cd "$ROOT"

if command -v python3 >/dev/null 2>&1; then
  python3 -m http.server "$PORT" &
elif command -v python >/dev/null 2>&1; then
  python -m SimpleHTTPServer "$PORT" &
else
  echo "Python is required to serve the preview." >&2
  exit 1
fi

SERVER_PID=$!
sleep 1

if command -v open >/dev/null 2>&1; then
  open "http://localhost:${PORT}"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "http://localhost:${PORT}"
fi

wait "$SERVER_PID"
