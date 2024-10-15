#!/bin/bash

# Prompt for the directory path containing JPG images
read -p "Enter the path of the directory with JPG images: " directory

# Check if the specified directory exists
if [ ! -d "$directory" ]; then
    echo "Directory not found: $directory"
    exit 1
fi

# Check for JPG files in the directory
shopt -s nullglob  # Allow for empty file lists
jpg_images=("$directory"/*.jpg)

if [ ${#jpg_images[@]} -eq 0 ]; then
    echo "No JPG images found in the directory: $directory"
    exit 1
fi

# Convert all JPG images to PNG in the directory
for jpg_image in "${jpg_images[@]}"; do
    png_image="${jpg_image%.jpg}.png"
    if convert "$jpg_image" "$png_image"; then
        echo "Image converted: $png_image"
    else
        echo "Conversion failed: $jpg_image"
    fi
done

echo "Conversion completed!"
