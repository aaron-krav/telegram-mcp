# ---- build stage ----
FROM golang:1.23.6-alpine AS build
WORKDIR /app
COPY . .
RUN go mod tidy
RUN go build -o telegram-mcp .

# ---- run stage ----
FROM alpine:3.20
WORKDIR /app
COPY --from=build /app/telegram-mcp .

# включаем SSE-транспорт
ENV MCP_TRANSPORT=sse

# запускаем, слушая тот порт, который задаёт Railway
# (Docker-shell подставит значение $PORT)
CMD /app/telegram-mcp serve --addr 0.0.0.0:${PORT:-8080}