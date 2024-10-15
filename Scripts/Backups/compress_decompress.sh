#!/bin/bash

# Function to check if a file exists
file_exists() {
    [ -e "$1" ]
}

# Function to check if a directory exists
directory_exists() {
    [ -d "$1" ]
}

read -rp "Enter the desired operation: 'compress' or 'decompress': " operation

case "$operation" in
    "compress")
        read -rp "Final file name (.tar.gz): " output_file
        read -rp "List of files (separated by space): " files

        if [ -z $files ]; then
            echo "Error: No files specified."
            exit 1
        fi

        
        if tar -czf "$output_file".tar.gz $files; then        
            echo "Successfully compressed to $output_file"
        else
            echo "Error: Compression failed."
        fi
        ;;
        
    "decompress")
        read -rp "Name of the file to decompress (.tar.gz): " file
        read -rp "Destination directory: " directory

        if ! file_exists $file; then
            echo "Error: File '$file' does not exist."
            exit 1
        fi

        if ! directory_exists "$directory"; then
            echo "Error: Directory '$directory' does not exist. Creating it..."
            mkdir -p "$directory"
        fi

        if  tar -vxzf "$file" -C "$directory"; then
            echo "Successfully decompressed to $directory"
        else
            echo "Error: Decompression failed."
        fi
        ;;
        
    *)
        echo "Invalid operation!"
        echo "Please select either 'compress' or 'decompress'."
        exit 1
        ;;
esac
