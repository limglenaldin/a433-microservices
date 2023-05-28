#!/bin/bash

# Function Collection
# Function to build image
build_image () {
    docker build -t item-app:v1 .
    docker images
}

# Function to format image container based on selected container registry 
format_tag_image () {
    case "$1" in
        1)
            docker tag item-app:v1 $2/item-app:v1                   # create tag <username>/item-app:v1
            ;;
        2)
            docker tag item-app:v1 ghcr.io/$2/item-app:v1           # create tag ghcr.io/<username>/item-app:v1
            ;;
    esac
}

# Funtion to push image to Docker Hub
push_to_docker_hub () {
    echo "==================================="
    echo "   Docker Hub Container Registry   "
    echo "==================================="

    read -p "Docker Hub Username: " username                        # Read an input from user and store to $username
    read -s -p "Personal Access Token: " pat                        # Read an secret input from user and store to $pat
    
    build_image                                                     # Call function build_image
    format_tag_image $1 $username                                   # Call function format_tag_image and pass $container_registry and $username

    echo $pat | docker login -u $username --password-stdin          # Login to Docker Hub
    docker push $username/item-app:v1                               # Push image to Docker Hub
}

push_to_github_packages () {
    echo "==================================="
    echo "Github Packages Container Registry "
    echo "==================================="

    read -p "Github Username: " username                            # Read an input from user and store to $username
    read -s -p "Personal Access Token: " pat                        # Read an secret input from user and store to $pat
    
    build_image
    format_tag_image $1 $username

    echo $pat | docker login ghcr.io -u $username --password-stdin  # Login to Github Packages
    docker push ghcr.io/$username/item-app:v1                       # Push image to Github Packages
}

# Main Script
echo "==================================="
echo "    Container Image Push Script    "
echo "==================================="
echo "This script is used to help create image from Dockerfile, format image name and push it to container registry."
echo "The login method to container registry will user PAT (Personal Access Token)"
echo "Created by Glenaldin Halim (https://github.com/glenaldinlim)"
echo ""

echo "Supported Container Registry"
echo "1. Docker Hub"
echo "2. Github Packages"
read -p "Select the container registry (1/2): " container_registry  # Read an input from user and store to $container_registry

case "$container_registry" in
    1)
        echo ""
            push_to_docker_hub $container_registry                  # Call function push_to_docker_hub and pass $container_registry
        ;;
    2)
        echo ""
            push_to_github_packages $container_registry             # Call function push_to_github_packages and pass $container_registry
        ;;
esac