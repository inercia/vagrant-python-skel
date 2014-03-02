Vagrant Python Skeleton
=======================

A skeleton for setting up Python, Vagrant machines (provisioned
with Puppet)

Usage
-----

1. Copy the `Vagrantfile` and the `vagrant` subdirectory to your local project.
2. By default, it uses a Centos 6.4 vagrant box, but you can customize it by
modifying the `Vagrantfile`.
3. Review the `vagrant/manifest/init.pp` file, checking out the roles definitions.
4. If you want Python 2.7 and the vagrant box does not provide it, check out the
contents of the `vagrant/extras`directory. There is a spec file and instructions for
creating a RPM from the Python 2.7.3 tar fileavailable in the official site.


