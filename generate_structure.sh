#!/bin/bash

# Function to create a NestJS service
create_nestjs_service() {
  local service_name=$1
local service_dir=${2:-backend-services/microservices/$service_name}

  # Create NestJS project
  nest new $service_name --directory $service_dir --package-manager yarn

  # Create necessary folders
  mkdir -p $service_dir/src/$service_name/{controllers,services,repositories,dtos,entities}

  # Create module file
  cat <<EOL > $service_dir/src/$service_name/$service_name.module.ts
import { Module } from '@nestjs/common';
import { ${service_name^}Service } from './services/${service_name}.service';
import { ${service_name^}Controller } from './controllers/${service_name}.controller';

@Module({
  controllers: [${service_name^}Controller],
  providers: [${service_name^}Service],
})
export class ${service_name^}Module {}
EOL

  # Create main.ts file
  cat <<EOL > $service_dir/src/main.ts
import { NestFactory } from '@nestjs/core';
import { ${service_name^}Module } from './$service_name/$service_name.module';

async function bootstrap() {
  const app = await NestFactory.create(${service_name^}Module);
  await app.listen(3000);
}
bootstrap();
EOL

  # Create app.module.ts file
  cat <<EOL > $service_dir/src/app.module.ts
import { Module } from '@nestjs/common';
import { ${service_name^}Module } from './$service_name/$service_name.module';

@Module({
  imports: [${service_name^}Module],
})
export class AppModule {}
EOL
}

# Function to create a Spring service
create_spring_service() {
  local service_name=$1
  local service_dir=backend-services/microservices/$service_name

  # Create Spring Boot project
  mkdir -p $service_dir
  cd $service_dir
  curl https://start.spring.io/starter.zip \
    -d dependencies=web,data-jpa,postgresql \
    -d name=$service_name \
    -d packageName=com.example.$service_name \
    -d javaVersion=11 \
    -o $service_name.zip
  unzip $service_name.zip
  rm $service_name.zip
  cd -
}

# Function to create an Angular app
create_angular_app() {
  local app_name=$1
  local app_dir=frontend-apps/$app_name

  # Create Angular project
  ng new $app_name --directory $app_dir --style=scss --routing=true

  # Install Taiga UI
  cd $app_dir
  ng add @taiga-ui
  cd -
}

# Create necessary directories
#mkdir -p frontend-apps

# Create api-gateway
#create_nestjs_service "api-gateway" "backend-services/api-gateway"

# Create services
#create_nestjs_service "auth-service"
#create_spring_service "payments-service"
#create_nestjs_service "company-service"
#create_nestjs_service "manager-service"
#create_nestjs_service "tickets-service"
#create_nestjs_service "verification-service"
#create_nestjs_service "support-service"
#create_nestjs_service "statistic-service"

# Create front-end apps
#create_angular_app "admin-app"
#create_angular_app "client-app"

# Create directories for databases
#mkdir -p databases/{postgresql,mongodb}

# Create RabbitMQ directory
#mkdir -p message-broker/rabbitmq

echo "Structure generated successfully."

#git submodule add https://github.com/MaksymKrychinin/tc-company-service.git backend-services/microservices/company-service
#git submodule add https://github.com/MaksymKrychinin/tc-manager-service.git backend-services/microservices/manager-service
#git submodule add https://github.com/MaksymKrychinin/tc-statistic-service.git backend-services/microservices/statistic-service
#git submodule add https://github.com/MaksymKrychinin/tc-support-service.git backend-services/microservices/support-service
#git submodule add https://github.com/MaksymKrychinin/tc-tickets-service.git backend-services/microservices/tickets-service
#git submodule add https://github.com/MaksymKrychinin/tc-verification-service.git backend-services/microservices/verification-service
#
#git add .gitmodules backend-services/microservices/company-service backend-services/microservices/manager-service backend-services/microservices/statistic-service backend-services/microservices/support-service backend-services/microservices/tickets-service backend-services/microservices/verification-service