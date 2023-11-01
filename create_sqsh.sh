#!/bin/bash


full_string=$1

# Extract user
user=$(echo $full_string | cut -d '/' -f 1)

# Extract image
image=$(echo $full_string | cut -d '/' -f 2 | cut -d ':' -f 1)

# Extract tag
tag=$(echo $full_string | cut -d ':' -f 2)

# usage: bash util_scripts/create_sqsh.sh <user>/<image>:<tag>
output="/home/jasonxie/containers/${user}+${image}+${tag}.sqsh"

echo "Creating container image at ${output}"

if [ -f "$output" ]; then
    echo "Container image already exists at ${output}, rebuilding..."
    rm "$output"
fi

srun enroot import -o ${output} docker://${full_string}
