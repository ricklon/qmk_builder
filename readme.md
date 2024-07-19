# QMK Firmware Docker Environment

This repository sets up a Docker environment for compiling QMK firmware with custom configurations. It uses multi-stage builds to minimize the final image size and supports different key mappings and features.

## Prerequisites

- Docker
- Docker Compose

## Setup

1. **Clone the Repository**

   Clone the QMK firmware repository:
   ```bash
   git clone https://github.com/ricklon/qmk_firmware
   cd qmk_firmware
   ```

2. **Create the Docker Image**

   Build the Docker image using `docker-compose`:
   ```bash
   docker-compose build
   ```

## Usage

### Compile Firmware

To compile the firmware with a specific keyboard and keymap, use the provided bash script `build_firmware.sh`.

1. **Make the Script Executable**

   ```bash
   chmod +x build_firmware.sh
   ```

2. **Run the Script**

   Run the script with the desired keyboard and keymap as arguments:
   ```bash
   ./build_firmware.sh <keyboard> <keymap>
   ```

   For example:
   ```bash
   ./build_firmware.sh planck/rev6 default
   ```

## Environment Variables

- `KEYBOARD`: The keyboard to compile firmware for (e.g., `planck/rev6`).
- `KEYMAP`: The keymap to compile firmware for (e.g., `default`).

## Dockerfile

The `Dockerfile` sets up a multi-stage build environment to compile the QMK firmware. It includes the necessary dependencies and the QMK CLI.

## docker-compose.yml

The `docker-compose.yml` file defines the service to build the Docker image and run the container. It uses environment variables to pass the keyboard and keymap.

## build_firmware.sh

The `build_firmware.sh` script sets the environment variables and runs `docker-compose up --build` to compile the firmware.

## Troubleshooting

### No Space Left on Device

If you encounter a "No space left on device" error, clean up your Docker system to free up space:

```bash
docker system prune -a --volumes
```

### Docker Permissions

If you encounter permission issues with Docker, ensure your user is added to the Docker group:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

### Check Disk Space

Ensure you have sufficient disk space on your host machine:

```bash
df -h
```

## License

This project is licensed under the Apache 2.0 License.
```
