#!/usr/bin/env bash
[[ "$TRACE" ]] && set -x
nginx-debug -g 'daemon off;'
