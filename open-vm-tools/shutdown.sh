#!/usr/bin/env bash

ssh -i /root/.ssh/open-vm-tools \
  -o StrictHostKeyChecking=no \
  root@localhost "shutdown $@"
