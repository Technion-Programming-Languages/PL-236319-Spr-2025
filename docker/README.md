# Dockerized Slides

## Install Docker

### Windows

Follow the instructions [here](https://docs.docker.com/desktop/windows/install/)

You will install both the docker engine and an easy to use gui for it (Docker Desktop)

### Ubuntu

Follow the instructions [here](https://docs.docker.com/engine/install/ubuntu/)

## Usage

### Start the container

The following command pulls the image and runs it interactively.

Fire up powershell (windows) or bash (linux) and execute it (you may need to use `sudo` on linux)

```bash
docker run --pull="always" -p 127.0.0.1:16788:16788 -p 127.0.0.1:16789:16789 -it twyair/safot-revealjs:latest bash
```

### In the container

Run:

```bash
source start.sh
```

### Open slides

go to <http://127.0.0.1:16788/slides>
