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
ENV MCP_TRANSPORT=sse        # режим обмена с GenSpark
CMD ["/app/telegram-mcp", "serve", "--port", "${PORT}"]