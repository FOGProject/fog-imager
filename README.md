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
These scripts assume that you have already mounted a file share directory to
/images by default. Currently, testing has been conducted with simple Windows
shares (samba). Here is a quick command to help you get rolling:

```Shell
mount -t cifs -o username=user,sec=ntlm //0.0.0.0/Images /images
```

## Additional Resources
Check out the FOG Project at https://fogproject.org/ and see the latest development on fog-imager's parent project.

Be sure to check out the FOG Project github as well: https://github.com/FOGProject/fogproject
