# SSH_user_usage
Usage Monitoring for SSH users

This script monitors the network usage for SSH sessions and aggregates the data over time. It produces a JSON file `SSH_Usage.json` that contains running totals for each SSH user.

## Requirements

- jq
- nethogs
- sudo access (for running nethogs)

## Installation & Execution (One-liner)

```bash
bash <(curl -Ls https://raw.githubusercontent.com/ArashpMD/SSH_user_usage/master/install.sh)
```
## See Usage Tracking and Menu
You can observe the consumption and service options by typing `SSHUsage` 

```bash
SSHUsage

## Usage Tracking File
The SSH user file is saved to root directory as `SSH_Usage.json`
otherwise run this could to find it:
```bash
find / -name SSH_Usage.json 2>/dev/null
