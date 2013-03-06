## admin_tools

Administrative tools required on the servers.

  * [backup.sh](#backup.sh) - Find projects in `pwd` that have backup scripts and run them.


## backup.sh

This will call the all the `admin/backup/*` executable files in each directory in the current working directory (`pwd`).

### How to call

```
> MACHINE_NAME=a_name backup.sh
```

  * `MACHINE_NAME` is a label given to this machine where the backups run. This will be passed to all backup scripts.
    They might use this to tag/label the generated backup files with the `MACHINE_NAME` where they were generated.

### Dependencies:

  * [s3cmd](https://github.com/s3tools/s3cmd): This script will fail if s3cmd is not available.
    It will NOT fail if s3cmd is not configured!!! Run `s3cmd --configure` for this. `s3cmd` will
    be searched for in: ~/s3cmd/, $PATH
