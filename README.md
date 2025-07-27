Ubuntu Podman Container to allow you to use and update klipper using []https://github.com/dw-0/kiauh

Home directory for the klippy user is persistent, and all of the prerequisit packages are installed for Klipper, Moonraker, Mainsail, Crowsnest.
It also has the prerequisits for the following extensions: G-Code Shell Command, Klipper-Backup, Obico for klipper, PrettyGCode for klipper.

This Podman Containerfile will prepare a container to work with kiauh to install klipper and its extensions using Mainsail as the web interface. 
The generated image will be less than 5GB, but you need to ensure that there is 50 GB of space available in /var/tmp, or link /var/tmp somewhere with enough space for the build.

This container will need to be rootful in order to use the usb port for the 3D printer.  When you create the image, and when you compose the container, use sudo.
