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

# включаем SSE-транспорт для GenSpark
ENV MCP_TRANSPORT=sse   

# запускаем, подставляя порт от Railway
CMD /app/telegram-mcp serve --port ${PORT:-8080}