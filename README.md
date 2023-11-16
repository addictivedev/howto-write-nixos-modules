# howto-write-nixos-modules
This repo contains snippet of nix code I wrote to test out some tutorial about how to write nix modules. It can be useful if you want to test out what you see on the video.

# VM
The `vm` directory contains some reference for vm configuration:

* configuration-minimal.nix => no graphical display
* configuration-gnome.nix
* configuration-xfce.nix



To login use:

```
user: test 
pwd: test
```

To run the vm:
```
nix-build <nixpkgs/nixos> --arg configuration ./configuration-minimal.nix -A vm
./result/bin/run-nixos-vm
```

In one command with SSH port forward:
```
QEMU_NET_OPTS="hostfwd=tcp::2222-:22"  $(nix-build '<nixpkgs/nixos>' --arg configuration ./configuration-xfce.nix -A vm)/bin/run-nixos-vm
```

To login with ssh: `ssh -p 2222 test@localhost`

