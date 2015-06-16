# fog-imager
A FOG Project side project that will lead to 2.0 development.

## Requirements
These scripts are built to be run on the FOG buildroot environment or a
custom Arch Live disk used for testing. Both of these platforms provide:

* gptfdisk
* sfdisk
* partclone
* pigz

If you spin your own test environment to try these scripts out, these programs
will be needed.

## Storage
There is now a script to mount SMB or NFS shares with ease: fog.mount

Usage: ```fog.mount <shareType> <serverIP> <shareName> [username] [password]```

At this time, shareType can be either 1 (SMB) or 2 (NFS).

It is highly suggested to avoid using the password option since user passwords
could be found in plaintext in the process list. If you do decide to use it,
only use it with read-only accounts. You've been warned!

## Additional Resources
Check out the FOG Project at https://fogproject.org/ and see the latest
development on fog-imager's parent project.

Be sure to check out the FOG Project github as well:
https://github.com/FOGProject/fogproject
