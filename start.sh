#!/usr/bin/env sh
set -e
PORT=${PORT:-8080}
telegram-mcp serve --transport sse --addr 0.0.0.0:$PORT