#!/usr/bin/env bash

set -eu -o pipefail

ssh -F ssh_config servicegwd-admin ls /etc || echo $?
ssh -F ssh_config servicegwd-client ls /etc || echo $?
