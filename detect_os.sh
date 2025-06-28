#!/bin/bash

# WSL環境かどうかを検出
if grep -qi microsoft /proc/version 2>/dev/null; then
    echo "wsl"
else
    echo "linux"
fi