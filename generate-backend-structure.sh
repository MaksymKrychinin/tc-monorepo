#!/bin/bash

set -e

PROJECT_ROOT="backend-services"
AUTH_SERVICE="auth-service"
TICKETS_SERVICE="tickets-service"

# Create root directory
mkdir -p $PROJECT_ROOT/packages

# Navigate to project root
cd $PROJECT_ROOT

# Initialize root package.json
cat <<EOL > package.json
{
  "name": "backend-services",
  "version": "1.0.0",
  "private": true,
  "workspaces": [
    "packages/*"
  ]
}
EOL

# Initialize yarn workspace
yarn

# Function to create a NestJS service
create_nest_service() {
  local SERVICE_NAME=$1

  # Navigate to packages directory
  cd packages

  # Create service directory
  mkdir $SERVICE_NAME

  # Navigate to service directory
  cd $SERVICE_NAME

  # Initialize NestJS application
  nest new $SERVICE_NAME --skip-git --package-manager yarn

  # Move contents to current directory
  mv $SERVICE_NAME/* .
  mv $SERVICE_NAME/.[^.]* .

  # Remove empty directory
  rmdir $SERVICE_NAME

  # Install additional dependencies
  yarn add @nestjs/mapped-types class-validator class-transformer mongoose @nestjs/mongoose @nestjs/jwt passport passport-jwt @nestjs/passport

  # Return to project root
  cd ../../
}

create_nest_service $AUTH_SERVICE
create_nest_service $TICKETS_SERVICE

echo "Backend services structure has been generated successfully."

# Navigate back to the root
cd ..

# Output completion message and next steps
echo "--------------------------------------------------"
echo "Backend services setup is complete."
echo "Navigate to each service directory (packages/<service-name>) and run 'yarn start:dev' to start the services."
echo "E.g., cd packages/$AUTH_SERVICE && yarn start:dev"
echo "--------------------------------------------------"