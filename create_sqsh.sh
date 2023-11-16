#!/bin/bash


full_string=$1

# Extract user
user=$(echo $full_string | cut -d '/' -f 1)

# Extract image
image=$(echo $full_string | cut -d '/' -f 2 | cut -d ':' -f 1)

# Extract tag
tag=$(echo $full_string | cut -d ':' -f 2)

# usage: bash slurm_utils/create_sqsh.sh <user>/<image>:<tag>
output="/home/jasonxie/containers/${user}+${image}+${tag}.sqsh"

echo "Creating container image at ${output}"

if [ -f "$output" ]; then
    echo "Container image already exists at ${output}, rebuilding..."
    rm "$output"
fi

echo "Importing container image from docker://${full_string} to ${output}"

srun --mem-per-gpu=10G --cpus-per-gpu=4 --gpus=1 enroot import -o ${output} docker://${full_string}
