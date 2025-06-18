# ---------- build ----------
FROM golang:1.23.6-alpine AS build
WORKDIR /app
COPY . .
RUN go mod tidy
RUN go build -o telegram-mcp .

# ---------- run ------------
FROM alpine:3.20
WORKDIR /app
COPY --from=build /app/telegram-mcp .

# включаем SSE-транспорт
ENV MCP_TRANSPORT=sse

# Railway передаёт переменную PORT → сервер сам её увидит
CMD ["/app/telegram-mcp","serve","--sse"]