#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
nginx -g 'daemon off;'