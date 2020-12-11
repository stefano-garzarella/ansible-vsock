# VSOCK ansible roles

This repository contains roles and playbooks to start VMs with VSOCK devices.
There are 2 example playbooks and 1 playbook to run vsock tests:

* **playbooks/vsock-test-suite.yml** starts 2 nested VMs and runs vsock tests
  between them. The tests currently run are:

    * [vsock_test](https://github.com/torvalds/linux/blob/master/tools/testing/vsock/vsock_test.c)
    * [vsock_diag_test](https://github.com/torvalds/linux/blob/master/tools/testing/vsock/vsock_diag_test.c)
    * [iperf-vsock](https://github.com/stefano-garzarella/iperf-vsock)

* **playbooks/nested-vms.yml** starts 2 VMs the first running on L0 and the second
  (nested) running on L1. Both are reachable through ssh from L0.

* **playbooks/sibling-vms.yml** starts 2 sibling VMs both running on L0.

## Configuration
All disk VMs are generated using a disk base image (backing file) that you
should provide (e.g. Fedora image).

In order to runs this playbooks on your machine, you should edit the
**playbooks/vars/common-vars.yml**:
1. Set `nfs_server_path` and `nfs.exports` with the path where your disk base
   images are stored.
   This directory will be mounted on L0 and L1 through NFS.
3. Set `l0_disk_base` with the path (in the pool) of disk base image for VMs
   running on L0.
4. Set `l1_disk_base` with the path (in the pool) of disk base image for VMs
   running on L1.

## Running
Run the playbook using `ansible-playbook`

### VSOCK test suite

#### Start VMs, run tests, cleanup VMs
```shell
ansible-playbook --ask-become-pass playbooks/nested-vms.yml
```

#### Start VMs without running tests
```shell
ansible-playbook --ask-become-pass playbooks/nested-vms.yml --tags "setup"
```

#### Run tests on VMs previously started
```shell
ansible-playbook --ask-become-pass playbooks/nested-vms.yml --tags "test"
```

#### Cleanup VMs previously started
```shell
ansible-playbook --ask-become-pass playbooks/nested-vms.yml --tags "cleanup"
```

### Nested VMs
```shell
ansible-playbook --ask-become-pass playbooks/nested-vms.yml
```

### Sibling VMs
```shell
ansible-playbook --ask-become-pass playbooks/sibling-vms.yml
```
