#!/bin/bash
echo "==================================="
echo "    Container Image Push Script    "
echo "==================================="
echo "This script is used to help create Karsajobs image from Dockerfile, format image name and push it to GitHub Package registry."
echo "The login method to container registry will user PAT (Personal Access Token)"
echo ""

read -p "GitHub Username: " username                            # Read an input from user and store to $username
read -s -p "Personal Access Token: " pat                        # Read an secret input from user and store to $pat

docker build -t karsajobs:latest .                              # Build image from Dockerfile
docker tag karsajobs:latest ghcr.io/$username/karsajobs:latest  # Change image name to GitHub Package format

echo $pat | docker login ghcr.io -u $username --password-stdin  # Login to GitHub Package
docker push ghcr.io/$username/karsajobs:latest                  # Push image to GitHub Package

echo "Finish to build and push Karsajobs Image to GitHub Package"