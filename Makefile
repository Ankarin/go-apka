# simple makefile for a go project

# build the application
all: build

build:
	@echo "building..."

	@go build -o main cmd/api/main.go

# run the application
run:
	@go run cmd/api/main.go

# test the application
test:
	@echo "testing..."
	@go test ./tests -v

# clean the binary
clean:
	@echo "cleaning..."
	@rm -f main

# live reload
watch:
	@if command -v air > /dev/null; then \
	    air; \
	    echo "watching...";\
	else \
	    read -p "go's 'air' is not installed on your machine. do you want to install it? [y/n] " choice; \
	    if [ "$$choice" != "n" ] && [ "$$choice" != "n" ]; then \
	        go install github.com/cosmtrek/air@latest; \
	        air; \
	        echo "watching...";\
	    else \
	        echo "you chose not to install air. exiting..."; \
	        exit 1; \
	    fi; \
	fi

.phony: all build run test clean

docker-build:
	@echo "building docker image..."
	@docker build -t app .


# run docker container with live reload
docker-run:
	@echo "running docker container..."
	@docker run -p 8080:8080 -v $(shell pwd):/app app
