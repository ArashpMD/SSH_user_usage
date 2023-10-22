# SSH_user_usage
Usage Monitoring for SSH users

This script monitors the network usage for SSH sessions and aggregates the data over time. It produces a JSON file `SSH_Usage.json` that contains running totals for each SSH user.

## Requirements

- jq
- nethogs
- sudo access (for running nethogs)

## Installation & Execution (One-liner)

```bash
curl -O https://raw.githubusercontent.com/ArashpMD/SSH_user_usage/main && sudo bash install.sh
