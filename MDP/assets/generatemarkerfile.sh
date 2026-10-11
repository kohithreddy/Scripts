#!/bin/bash
set -e

MARKER_FILE="/usr/local/share/mdp-provisioning-success.txt"

{
  echo "MDP provisioning script started at $(date -u)"
  echo "Hostname: $(hostname)"
  echo "ProvisioningStatus=Success"
} | sudo tee "$MARKER_FILE"

sudo chmod 644 "$MARKER_FILE"
