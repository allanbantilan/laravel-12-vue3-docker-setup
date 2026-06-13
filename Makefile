# Makefile for Laravel with Docker

# Docker compose command
DC=docker compose

# Start Docker containers
up:
	$(DC) up -d

# Stop Docker containers
down:
	$(DC) down

# Restart containers
restart: down up

# Open Laravel Tinker
tinker:
	$(DC) exec laravel.test php artisan tinker

# Open a bash shell inside the container
shell:
	$(DC) exec laravel.test bash

# Run artisan migrate
migrate:
	$(DC) exec laravel.test php artisan migrate

# Run artisan migrate with refresh
migrate-refresh:
	$(DC) exec laravel.test php artisan migrate:refresh

# Run artisan commands
artisan:
	$(DC) exec laravel.test php artisan $(cmd)

# Run composer commands
composer:
	$(DC) exec laravel.test composer $(cmd)

# Run npm commands
npm:
	$(DC) exec laravel.test npm $(cmd)

# Run tests
test:
	$(DC) exec laravel.test php artisan test

# Run Laravel Pint (code formatting)
pint:
	$(DC) exec laravel.test ./vendor/bin/pint

# Run Pint with test mode (dry run)
pint-test:
	$(DC) exec laravel.test ./vendor/bin/pint --test

# Run Pint on specific path
pint-path:
	$(DC) exec laravel.test ./vendor/bin/pint $(path)

npm-dev:
	$(DC) exec laravel.test npm run dev

npm-build:
	$(DC) exec laravel.test npm run build

# Generate Swagger/OpenAPI docs
swagger:
	$(DC) exec laravel.test php artisan l5-swagger:generate

# Clean generated Swagger files
swagger-clean:
	$(DC) exec laravel.test php artisan l5-swagger:clean

# Run ESLint
lint:
	$(DC) exec laravel.test npm run lint

# Run Prettier
format:
	$(DC) exec laravel.test npm run format

# Clear all caches
cache-clear:
	$(DC) exec laravel.test php artisan cache:clear
	$(DC) exec laravel.test php artisan config:clear
	$(DC) exec laravel.test php artisan route:clear
	$(DC) exec laravel.test php artisan view:clear

# Optimize for production
optimize:
	$(DC) exec laravel.test php artisan config:cache
	$(DC) exec laravel.test php artisan route:cache
	$(DC) exec laravel.test php artisan view:cache
	$(DC) exec laravel.test php artisan event:cache

# View logs
logs:
	$(DC) logs -f
