#!/bin/bash

make clean all && ssh root@pxe.lan "cat > /var/lib/vz/template/iso/notrouteros.iso" < build/notrouteros-*-x86_64.iso
