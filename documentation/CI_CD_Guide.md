# CI/CD Pipeline and Roku App Deployment Guide

This guide provides detailed instructions for setting up a continuous integration and continuous deployment (CI/CD) pipeline for a Roku application using GitHub Actions.

## Prerequisites

- A GitHub account and a repository for your Roku app.
- Roku Developer Account and a Roku device set up for development.

## Step 1: GitHub Actions Setup

1. **Create Workflow File:**
   Navigate to your GitHub repository, and under the `.github/workflows/` directory, create a new file named `main.yml`.

2. **Configure Workflow:**
   Copy and paste the following YAML configuration into `main.yml`. This configuration defines the workflow to build and deploy your Roku app.

   ```yaml
   name: Roku CI/CD Pipeline

   on:
     push:
       branches:
         - main
     pull_request:
       branches:
         - main

   jobs:
     build-and-deploy:
       runs-on: ubuntu-latest
       steps:
       - uses: actions/checkout@v2
         name: Checkout Code
         
       - name: Zip Roku files
         run: zip -r application.zip ./ -x "*.git*"

       - name: Deploy to Roku
         uses: RokuRoad/brightscript-deploy-action@v1
         with:
           roku_dev_id: ${{ secrets.ROKU_DEV_ID }}
           roku_dev_password: ${{ secrets.ROKU_DEV_PASSWORD }}
           roku_dev_target: ${{ secrets.ROKU_DEV_TARGET }}
           package_file_path: './application.zip'
           fail_on_error: true
