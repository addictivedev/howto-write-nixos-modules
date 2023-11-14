# howto-write-nixos-modules
This repo contains snippet of nix code I wrote to test out some tutorial about how to write nix modules. It can be useful if you want to test out what you see on the video.

# VM
The ´vm´ directory contains some reference for vm configuration:

* minimal: no graphical display 
* display: with graphical display

To login use:

´´´
user: test 
pwd: test
´´´

To run the vm:
´´´
nix-build <nixpkgs/nixos> --arg configuration ./configuration-minimal.nix -A vm
./result/bin/run-nixos-vm
´´´
