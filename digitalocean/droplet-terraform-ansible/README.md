## Creates and sets up a new DigitalOcean droplet for use with Docker.

### Actions performed:
- Create the server
- Add existing SSH key pair for remote access
- Apply OS updates
- Install a few required packages
- Add Docker CE repository
- Install Docker CE
- If a reboot is required by the updates, then reboot the server