# Stage 1: Build environment
FROM debian:slim AS builder

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    gcc-avr \
    avr-libc \
    dfu-programmer \
    dfu-util \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    libusb-dev \
    python3 \
    python3-pip \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Install QMK CLI
RUN pip3 install qmk

# Clone the QMK firmware repository
RUN git clone https://github.com/ricklon/qmk_firmware /qmk_firmware

# Update usbconfig.h with the desired configuration
RUN sed -i 's/#define USB_CFG_DMINUS_BIT.*/#define USB_CFG_DMINUS_BIT 3/' /qmk_firmware/quantum/usbconfig.h && \
    sed -i 's/#define USB_CFG_DPLUS_BIT.*/#define USB_CFG_DPLUS_BIT 2/' /qmk_firmware/quantum/usbconfig.h

# Stage 2: Runtime environment
FROM debian:slim

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install only necessary runtime dependencies
RUN apt-get update && apt-get install -y \
    gcc-avr \
    avr-libc \
    dfu-programmer \
    dfu-util \
    libusb-dev \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Copy QMK firmware and QMK CLI from the build stage
COPY --from=builder /qmk_firmware /qmk_firmware
COPY --from=builder /usr/local/bin/qmk /usr/local/bin/qmk
COPY --from=builder /usr/local/lib/python3.7/dist-packages/qmk /usr/local/lib/python3.7/dist-packages/qmk

WORKDIR /qmk_firmware

# Initialize QMK environment
RUN qmk setup -y

ENTRYPOINT ["qmk"]
CMD ["compile"]
