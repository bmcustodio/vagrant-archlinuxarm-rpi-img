# vagrant-archlinuxarm-rpi-img

Automates the process of generating `*.img` files from
[Arch Linux ARM](https://goo.gl/Nk5Hkk)'s tarballs for
[Raspberry Pi](https://goo.gl/RQK38t),
[Raspberry Pi 2](https://goo.gl/rVrBi1) and
[Raspberry Pi 3](https://goo.gl/hEvwWT) (AArch64). These can then be used
directly with `dd` on Linux and OSX and
[Win32DiskImager](https://sourceforge.net/projects/win32diskimager/) on Windows.

## Pre-Requisites

* [Vagrant](https://www.vagrantup.com) (tested with 1.9.5).
* [VirtualBox](https://www.virtualbox.org/) (tested with 5.1.22).

## Building Images

To build an image suitable for using with, e.g., Raspberry Pi 2, run

```bash
$ vagrant up
$ vagrant ssh -c "/vagrant/build.sh rpi-2"
$ vagrant destroy
```

The resulting `*.img` file will be placed in the `build/` directory:

```bash
$ ls -la build/
total 2097160
drwxr-xr-x   4 bmcustodio  staff         136 Jul  5 00:33 .
drwxr-xr-x  12 bmcustodio  staff         408 Jul  5 00:31 ..
-rw-r--r--   1 bmcustodio  staff          36 Jul  5 00:01 .gitkeep
-rw-r--r--   1 bmcustodio  staff  1073741824 Jul  4 23:50 ArchLinuxARM-rpi-2-latest.img
```

## Resizing the Root Partition

By flashing the generated images to an SD card you will end up with a root
partition which is about 900MB in size, while your card may have a total
capacity of 16GB.

To expand the root partition in order to fill the whole card you can safely use
`fidsk` and `resize2fs` as described in this [answer](https://goo.gl/9EkLJK)
after you boot your Raspberry Pi.

## License

Copyright 2017 brunomcustodio

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.