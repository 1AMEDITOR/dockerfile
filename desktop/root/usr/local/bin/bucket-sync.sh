#!/bin/bash
# Copies files from the Railway bucket into /config/Bucket every 60s.
# Config comes from env vars: RCLONE_CONFIG_BUCKET_TYPE=s3, RCLONE_CONFIG_BUCKET_PROVIDER=Other,
# RCLONE_CONFIG_BUCKET_ENDPOINT, RCLONE_CONFIG_BUCKET_ACCESS_KEY_ID, RCLONE_CONFIG_BUCKET_SECRET_ACCESS_KEY, RCLONE_CONFIG_BUCKET_REGION, and BUCKET_NAME.
mkdir -p /config/Bucket
chown abc:abc /config/Bucket
if [ -z "$BUCKET_NAME" ] || [ -z "$RCLONE_CONFIG_BUCKET_ENDPOINT" ]; then
  echo "bucket-sync: BUCKET_NAME or bucket endpoint not set, skipping"
  exit 0
fi
while true; do
  rclone copy "bucket:${BUCKET_NAME}" /config/Bucket --no-update-modtime 2>&1 | tail -n 5
  chown -R abc:abc /config/Bucket
  sleep 60
done
