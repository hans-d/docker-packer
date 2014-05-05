NAME=packer
REPO=hansd/$(NAME) 

ROOT:=$(shell pwd)

VOLUMES=
PORTS=


.PHONY: bash start build clean

all: build 

build:
	docker build -t $(REPO) .

start: clean
	docker run -d --name $(NAME) $(PORTS) $(VOLUMES) $(REPO) 

bash: CMD = bash 
bash: build run 

run:
	docker run -t -i $(VOLUMES) --rm $(REPO) $(CMD)


clean:
	docker stop $(NAME)
	docker rm $(NAME)
