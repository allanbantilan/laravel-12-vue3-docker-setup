# Makefile for Laravel Sail

# Sail binary
SAIL=./vendor/bin/sail

# Start Docker containers
up:
	$(SAIL) up -d

# Stop Docker containers
down:
	$(SAIL) down

# Restart containers
restart: down up

# Open Laravel Tinker
tinker:
	$(SAIL) artisan tinker

# Open a bash shell inside the Sail container
shell:
	$(SAIL) shell

# Run artisan migrate
migrate:
	$(SAIL) artisan migrate

# Run artisan migrate with refresh
migrate-refresh:
	$(SAIL) artisan migrate:refresh

# Run artisan commands
artisan:
	$(SAIL) artisan $(cmd)

# Run composer commands
composer:
	$(SAIL) composer $(cmd)

# Run npm commands
npm:
	$(SAIL) npm $(cmd)

# Run tests
test:
	$(SAIL) artisan test

# Run Laravel Pint
pint:
	$(SAIL) php ./vendor/bin/pint

npm-dev:
	$(SAIL) npm run dev

npm-build:
	$(SAIL) npm run build

# Generate Swagger/OpenAPI docs
swagger:
	$(SAIL) artisan l5-swagger:generate

# Clean generated Swagger files
swagger-clean:
	$(SAIL) artisan l5-swagger:clean
