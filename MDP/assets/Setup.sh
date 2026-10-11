#!/bin/bash
echo "========================================"
echo "       Linux Machine Information"
echo "========================================"

echo "Hostname        : $(hostname)"
echo "OS              : $(grep '^PRETTY_NAME=' /etc/os-release | cut -d= -f2- | tr -d '"')"
echo "Kernel          : $(uname -r)"
echo "Architecture    : $(uname -m)"
echo "Uptime          : $(uptime -p)"

echo "-------- CPU --------"
echo "CPU Model       : $(lscpu | grep 'Model name' | head -1 | cut -d: -f2- | xargs)"
echo "CPU Cores       : $(nproc)"

echo "-------- Memory --------"
free -h

echo "-------- Disk --------"
df -h --output=target,size,used,avail,pcent | grep -v "tmpfs"

echo "-------- IP Address --------"
hostname -I

echo "-------- Network Interfaces --------"
ip -br addr

echo "========================================"
echo "Scenario 1"
echo "========================================"
#!/bin/bash
set -e

echo "Running main MDP provisioning script..."
chmod +x ./generatemarkerfile.sh
./generatemarkerfile.sh
echo "Marker script completed successfully"
echo "========================================"
echo "End of Scenario 1"
echo "========================================"
