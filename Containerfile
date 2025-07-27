FROM ubuntu:latest

ARG USER=klippy
ARG HOME=/home/${USER}
ARG DEVICE_GROUP=uccp
ARG DEVICE_GID=986

ENV container=podman

# This Podman Containerfile will prepare a container to work with kiauh to install klipper and its extensions using Mainsail as the web interface. 
# The generated image will be less than 5GB, but you need to ensure that there is 50 GB of space available in /var/tmp, or link /var/tmp somewhere with enough space.
# The required files are current as of:
# 2025-07-27


# Use DEBIAN_FRONTEND=noninteractive to avoid prompts during apt-get operations
# Install systemd, systemd-sysv, and other necessary packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        systemd \
        systemd-sysv \
        supervisor \
        sudo \
        vim \
        apt-utils \
        curl \
        gpiod \
        iproute2 \
        libcurl4-openssl-dev \
        libjpeg-dev \
        liblmdb-dev \
        libopenjp2-7 \
        libsodium-dev \
        libssl-dev \
        locales \
        rsync \
        zlib1g-dev \
        adduser && \
    apt-get autoremove -y && \
    apt-get clean -y

# Install kiuah required software
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
        git \
        dialog \
        python3 \
		virtualenv \
		python3-virtualenv \
		libusb-dev \
		libnewlib-arm-none-eabi \
		python3-dev \
        unzip \
        avrdude \
        stm32flash \
        wget \
        gcc-arm-none-eabi \
        pkg-config \
        libncurses-dev \
        libffi-dev \
        build-essential \
        gcc-avr \
        avr-libc \
        binutils-avr \
        dfu-util \
        packagekit \
        wireless-tools \
        nginx \
        libevent-2.1-7t64 \
        libevent-core-2.1-7t64 \
        libevent-extra-2.1-7t64 \
        libevent-openssl-2.1-7t64 \
        libevent-pthreads-2.1-7t64 \
        libmd-dev \
        cron \
        libv4l-0t64 \
        libv4l2rds0t64 \
        libv4lconvert0t64 \
        binutils-arm-none-eabi && \
    apt-get autoremove -y && \
    apt-get clean -y

# Install required software for kiuah extensions that I use.
# G-Code Shell Command, Klipper-Backup, Obico for klipper, PrettyGCode for klipper
# If you need to add something after an update, run kiuah.sh and take note of any requirements that need to be installed, then add them here.
# if you get an error about dpkg 

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \ 
        python3-iniparse \
        python3-pip \
		ffmpeg \
        adwaita-icon-theme \
        alsa-topology-conf \
        alsa-ucm-conf \
        at-spi2-common \
        at-spi2-core \
        dconf-gsettings-backend \
        dconf-service \
        fontconfig \
        gsettings-desktop-schemas \
        gtk-update-icon-cache \
        hicolor-icon-theme \
        humanity-icon-theme \
        i965-va-driver \
        intel-media-va-driver \
        libaacs0 \
        libasound2-data \
        libasound2t64 \
        libass9 \
        libasyncns0 \
        libatk-bridge2.0-0t64 \
        libatk1.0-0t64 \
        libatspi2.0-0t64 \
        libavahi-client3 \
        libavahi-common-data \
        libavahi-common3 \
        libavc1394-0 \
        libavcodec60 \
        libavdevice60 \
        libavfilter9 \
        libavformat60 \
        libavutil58 \
        libbdplus0 \
        libblas3 \
        libbluray2 \
        libbs2b0 \
        libcaca0 \
        libcairo-gobject2 \
        libcairo2 \
        libcdio-cdda2t64 \
        libcdio-paranoia2t64 \
        libcdio19t64 \
        libchromaprint1 \
        libcjson1 \
        libcodec2-1.2 \
        libcolord2 \
        libcups2t64 \
        libdatrie1 \
        libdav1d7 \
        libdc1394-25 \
        libdconf1 \
        libdecor-0-0 \
        libdecor-0-plugin-1-gtk \
        libdrm-amdgpu1 \
        libdrm-common \
        libdrm-intel1 \
        libdrm-nouveau2 \
        libdrm-radeon1 \
        libdrm2 \
        libepoxy0 \
        libfftw3-double3 \
        libflac12t64 \
        libflite1 \
        libfribidi0 \
        libgbm1 \
        libgdk-pixbuf-2.0-0 \
        libgdk-pixbuf2.0-bin \
        libgdk-pixbuf2.0-common \
        libgfortran5 \
        libgl1 \
        libgl1-amber-dri \
        libgl1-mesa-dri \
        libglapi-mesa \
        libglvnd0 \
        libglx-mesa0 \
        libglx0 \
        libgme0 \
        libgraphite2-3 \
        libgsm1 \
        libgtk-3-0t64 \
        libgtk-3-bin \
        libgtk-3-common \
        libharfbuzz0b \
        libhwy1t64 \
        libiec61883-0 \
        libigdgmm12 \
        libjack-jackd2-0 \
        libjxl0.7 \
        liblapack3 \
        liblcms2-2 \
        liblilv-0-0 \
        libllvm19 \
        libmbedcrypto7t64 \
        libmp3lame0 \ 
        libmpg123-0t64 \
        libmysofa1 \
        libnorm1t64 \
        libnuma1 \
        libogg0 \
        libopenal-data \
        libopenal1 \
        libopenmpt0t64 \
        libopus0 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libpangoft2-1.0-0 \
        libpciaccess0 \
        libpgm-5.3-0t64 \
        libpixman-1-0 \
        libplacebo338 \
        libpocketsphinx3 \
        libpostproc57 \
        libpulse0 \
        librabbitmq4 \
        librav1e0 \
        libraw1394-11 \
        librist4 \
        librsvg2-2 \
        librsvg2-common \
        librubberband2 \
        libsamplerate0 \
        libsdl2-2.0-0 \
        libsensors-config \
        libsensors5 \
        libserd-0-0 \
        libshine3 \
        libslang2 \
        libsnappy1v5 \
        libsndfile1 \
        libsndio7.0 \
        libsord-0-0 \
        libsoxr0 \
        libspeex1 \
        libsphinxbase3t64 \
        libsratom-0-0 \
        libsrt1.5-gnutls \
        libssh-gcrypt-4 \
        libsvtav1enc1d1 \
        libswresample4 \
        libswscale7 \
        libthai-data \
        libthai0 \
        libtheora0 \
        libtwolame0  \
        libudfread0 \
        libunibreak5 \
        libva-drm2 \
        libva-x11-2 \
        libva2 \
        libvdpau1 \
        libvidstab1.1 \
        libvorbis0a \
        libvorbisenc2 \
        libvorbisfile3 \
        libvpl2 \
        libvpx9 \
        libvulkan1 \
        libwayland-client0 \
        libwayland-cursor0 \
        libwayland-egl1 \
        libwayland-server0 \
        libwebpmux3 \
        libx11-xcb1 \
        libx264-164 \
        libx265-199 \
        libxcb-dri2-0 \
        libxcb-dri3-0 \
        libxcb-glx0 \
        libxcb-present0 \
        libxcb-randr0 \
        libxcb-render0 \
        libxcb-shape0 \
        libxcb-shm0 \
        libxcb-sync1 \
        libxcb-xfixes0 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxfixes3 \
        libxi6 \
        libxinerama1 \
        libxkbcommon0 \
        libxrandr2 \
        libxrender1 \
        libxshmfence1 \
        libxss1 \
        libxtst6 \
        libxv1 \
        libxvidcore4 \
        libxxf86vm1 \
        libzimg2 \
        libzix-0-0 \
        libzmq5 \
        libzvbi-common \
        libzvbi0t64 \
        mesa-libgallium \
        mesa-va-drivers \
        mesa-vdpau-drivers \
        mesa-vulkan-drivers \
        ocl-icd-libopencl1 \
        pocketsphinx-en-us \
        python3-setuptools \
        python3-wheel \
        session-migration \
        ubuntu-mono \
        va-driver-all \
        vdpau-driver-all \
        x11-common \
        xkb-data  && \
    apt-get autoremove -y && \
    apt-get clean -y


# Fix issue with crontab
RUN rm -rf /var/lib/dpkg/statoverride


# Create the klippy user and group, and set initial ownership for its home and klipper logs
RUN useradd --user-group -m -s /bin/bash -d ${HOME} ${USER} && \
    groupadd -g ${DEVICE_GID} ${DEVICE_GROUP} && \
    usermod -a -G ${DEVICE_GROUP},tty,dialout ${USER} && \
    mkdir -p /var/log/supervisor /var/log/klipper ${HOME}/.cache/pip && \
    chown -R ${USER}:${USER} /var/log/klipper ${HOME}

# Add klippy user to sudoers with NOPASSWD
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/00-${USER}-nopasswd

# For debugging during build - this will show the UID/GID of klippy
RUN id ${USER}

# USER ${USER}  <-- Commented out to run as root, which is fine for systemd
WORKDIR ${HOME}

# Make the klippy user's home folder persistent with this volume
VOLUME /home/pi/.local/share/containers/storage/volumes/klippy_home

# Expose Moonraker
EXPOSE 7125
# Expose PrettyGCode
EXPOSE 7136

COPY supervisord.conf /etc/supervisord.conf
# Copy the supervisord systemd service file and enable it
COPY supervisord.service /etc/systemd/system/supervisord.service
RUN systemctl enable supervisord.service

# Set the CMD to run systemd as the init process
CMD ["/sbin/init"]

