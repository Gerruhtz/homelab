# Script designed to install a GitHub Runner

# Create a folder and download latest runner package
mkdir actions-runner && cd actions-runner
curl -o actions-runner-linux-x64-2.317.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.317.0/actions-runner-linux-x64-2.317.0.tar.gz

# Extract the installer
tar xzf ./actions-runner-linux-x64-2.317.0.tar.gz

# Create the runner and start configuration
./config.sh --url https://github.com/Gerruhtz/homelab --token A7CINOI3M5VE7WKSYH7ZIKLGMOBHS

# Install service
sudo ./svc.sh install
sudo ./svc.sh start
sudo systemctl enable actions.runner.Gerruhtz-homelab.DIMM-IAC.service