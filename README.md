# fog-imager
A FOG Project 2.0 imaging submodule.

## Requirements
The scripts should be used with the buildroot environment that can be built
with ./bin/config-br.sh. In order to use the scripts, they will need to be
merged into the rootfs.ext.xz file before using ./bin/makeiso.sh (assuming
you want to have an ISO). At this time, this is not automated in any way.

If you spin your own test environment to try these scripts out, these programs
will be needed:

* gptfdisk
* sfdisk
* partclone
* pigz

## Storage
There is now a script to mount SMB or NFS shares with ease: fog.mount

Usage: ```fog.mount <shareType> <serverIP> <shareName> [username] [password]```

At this time, shareType can be either 1 (SMB) or 2 (NFS).

It is highly suggested to avoid using the password option since user passwords
could be found in plaintext in the process list. If you do decide to use it,
only use it with read-only accounts. You've been warned!

## Additional Resources
Check out the FOG Project at https://fogproject.org/ and see the latest
development on fog-too, the parent repository.
