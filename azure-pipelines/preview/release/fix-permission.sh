#!/usr/bin/env bash
# set -euo pipefail

wit="$1"
echo "wit = $wit"
# VOLUME_SUFFIX="$wit_pg-csv-exports"
# VOLUME_NAME="$(docker volume ls --format '{{ .Name }}' | grep -E "${VOLUME_SUFFIX}\$" | head -1 || true)"
VOLUME_NAME="preview-${wit}_pg-csv-exports"
echo "$VOLUME_NAME"

# VOLUME_NAME="${VOLUME_NAME:-}"
# if [ -z "$VOLUME_NAME" ]; then
#   if docker volume inspect "$VOLUME_SUFFIX" &>/dev/null; then
#     VOLUME_NAME="$VOLUME_SUFFIX"
#   else
#     VOLUME_NAME="$(docker volume ls --format '{{ .Name }}' | grep -E "${VOLUME_SUFFIX}\$" | head -1 || true)"
#   fi
# fi

# if [ -z "$VOLUME_NAME" ]; then
#   echo "No volume matching *${VOLUME_SUFFIX} found." >&2
#   docker volume ls
#   exit 1
# fi

MOUNTPOINT="$(docker volume inspect "$VOLUME_NAME" --format '{{ .Mountpoint }}')"

echo "Volume:     $VOLUME_NAME"
echo "Mountpoint: $MOUNTPOINT"

# if [ ! -d "$MOUNTPOINT" ]; then
#   echo "Mountpoint is not a directory on this host (common on Docker Desktop)." >&2
#   exit 1
# fi

sudo chmod -R 777 "$MOUNTPOINT"
echo "Done: chmod -R 777 $MOUNTPOINT"
