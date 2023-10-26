# ... (previous content remains unchanged)

# =============================
# Build Stage for React Frontend
# =============================
FROM node:14 AS build-frontend

WORKDIR /app/frontend

# Adjusted to the new file structure: copy from "frontend/"
COPY ./frontend/package.json ./frontend/package-lock.json ./
RUN npm install
COPY ./frontend/ ./
RUN npm run build

# =============================
# Build Stage for Go Backend
# =============================
FROM golang:1.21.3 AS build-backend

WORKDIR /app/backend

# Adjusted to the new file structure: copy from "backend/"
COPY ./backend/go.mod ./backend/go.sum ./
RUN go mod download
COPY ./backend/ ./
RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# ... (following content remains unchanged)

# =============================
# Final Stage
# =============================
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

# Copy from previous stages, no changes needed here
COPY --from=build-backend /app/main .
COPY --from=build-frontend /app/build ./frontend/build

EXPOSE 8080
CMD ["./main"]
