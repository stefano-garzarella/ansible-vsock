# VSOCK ansible roles

This repository contains roles and playbooks to start VMs with VSOCK devices.
There are 2 example playbooks:

* **playbooks/nested-vms.yml** starts 2 VMs the first running on L0 and the second
  (nested) running on L1. Both are reachable through ssh from L0.

* **playbooks/sibling-vms.yml** starts 2 sibling VMs both running on L0.

## Configuration
All disk VMs are generated using a disk base image (backing file) that you
should provide (e.g. Fedora image).

In order to runs this playbooks on your machine, you should edit the
**playbooks/vars/common-vars.yml**:
1. Set `remote_dir` in the `pool` where your disk base images are stored.
   This directory will be mounted on L0 and L1 through NFS.
2. Set `l0_disk_base` with the path (in the pool) of disk base image for VMs
   running on L0.
2. Set `l1_disk_base` with the path (in the pool) of disk base image for VMs
   running on L1.

## Running
Run the playbook using `ansible-playbook`

### Nested VMs
```shell
ansible-playbook --ask-become-pass playbooks/nested-vms.yml
```

### Sibling VMs
```shell
ansible-playbook --ask-become-pass playbooks/sibling-vms.yml
```
