#!/usr/bin/env bash

ssh -F ssh_config servicegwd-admin "sleep 1; echo 1" || echo $? &
ssh -F ssh_config servicegwd-admin "sleep 2; echo 2" || echo $? &
ssh -F ssh_config servicegwd-admin "sleep 3; echo 3" || echo $? &
ssh -F ssh_config servicegwd-admin "sleep 4; echo 4" || echo $? &
wait
