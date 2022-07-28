build-bot:
	docker build -t bot-image -f Dockerfile . 

run-bot:
	docker run -e DISPLAY=host.docker.internal:0 --name bot -it --rm bot-image