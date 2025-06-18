# ---- build stage ----
# используем стабильный Go 1.23.6
FROM golang:1.23.6-alpine AS build
WORKDIR /app
COPY . .
RUN go build -o telegram-mcp .

# ---- run stage ----
FROM alpine:3.20
WORKDIR /app
COPY --from=build /app/telegram-mcp .
ENV PORT=${PORT:-8080}
CMD ["/app/telegram-mcp","serve","--transport","sse","--addr","0.0.0.0:${PORT}"]