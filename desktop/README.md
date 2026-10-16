# Ubuntu desktop

A browser-based Linux desktop built on the LinuxServer `webtop:ubuntu-xfce` image (Selkies web GUI). It adds Temurin JDKs and a background sync from an S3-compatible bucket.

Build this directory as its own service (on Railway, set Root Directory to `desktop`). Mount the persistent volume at `/config`, which is the home directory of the desktop user `abc`.

## Environment variables

Login (handled by the base image):

- `CUSTOM_USER` and `PASSWORD`: HTTP basic auth credentials.

Bucket sync (files are copied into `/config/Bucket` every 60 seconds; local files are never deleted):

- `RCLONE_CONFIG_BUCKET_TYPE=s3`
- `RCLONE_CONFIG_BUCKET_PROVIDER=Other`
- `RCLONE_CONFIG_BUCKET_ENDPOINT`
- `RCLONE_CONFIG_BUCKET_ACCESS_KEY_ID`
- `RCLONE_CONFIG_BUCKET_SECRET_ACCESS_KEY`
- `RCLONE_CONFIG_BUCKET_REGION`
- `BUCKET_NAME`

If `BUCKET_NAME` or `RCLONE_CONFIG_BUCKET_ENDPOINT` is unset, the sync is skipped.

## Java

Java 25 (LTS) is the default: `JAVA_HOME` and `PATH` point to `/opt/java/25`. JDK 27 is installed at `$JAVA_27_HOME` (`/opt/java/27`); `$JAVA_25_HOME` is also set.
