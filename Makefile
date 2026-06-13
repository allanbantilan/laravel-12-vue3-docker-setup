# Makefile for Laravel with Docker

# Docker compose command
DC=docker compose

# ─── Docker ────────────────────────────────────────────

# Start Docker containers
up:
	$(DC) up -d

# Stop Docker containers
down:
	$(DC) down

# Restart containers
restart: down up

# Build production Docker image
docker-build:
	docker build -t laravel-app:latest .

# Run production containers
docker-up:
	$(DC) -f docker-compose.prod.yml up -d

# ─── Shell & Tinker ───────────────────────────────────

# Open Laravel Tinker
tinker:
	$(DC) exec laravel.test php artisan tinker

# Open a bash shell inside the container
shell:
	$(DC) exec laravel.test bash

# Open Redis CLI
redis-cli:
	$(DC) exec redis redis-cli

# ─── Database ──────────────────────────────────────────

# Run artisan migrate
migrate:
	$(DC) exec laravel.test php artisan migrate

# Run artisan migrate with refresh
migrate-refresh:
	$(DC) exec laravel.test php artisan migrate:refresh

# Run database seeder
seed:
	$(DC) exec laravel.test php artisan db:seed

# Fresh migrate + seed
fresh:
	$(DC) exec laravel.test php artisan migrate:fresh --seed

# ─── Artisan / Composer / NPM ─────────────────────────

# Run artisan commands
artisan:
	$(DC) exec laravel.test php artisan $(cmd)

# Run composer commands
composer:
	$(DC) exec laravel.test composer $(cmd)

# Run npm commands
npm:
	$(DC) exec laravel.test npm $(cmd)

# ─── Frontend ──────────────────────────────────────────

npm-dev:
	$(DC) exec laravel.test npm run dev

npm-build:
	$(DC) exec laravel.test npm run build

# ─── Testing ───────────────────────────────────────────

# Run tests
test:
	$(DC) exec laravel.test php artisan test

# Run tests with coverage
test-coverage:
	$(DC) exec laravel.test php artisan test --coverage

# ─── Code Quality ──────────────────────────────────────

# Run Laravel Pint (code formatting)
pint:
	$(DC) exec laravel.test ./vendor/bin/pint

# Run Pint with test mode (dry run)
pint-test:
	$(DC) exec laravel.test ./vendor/bin/pint --test

# Run Pint on specific path
pint-path:
	$(DC) exec laravel.test ./vendor/bin/pint $(path)

# Run Larastan (PHP static analysis)
phpstan:
	$(DC) exec laravel.test ./vendor/bin/phpstan analyse

# Run Larastan and generate baseline
phpstan-baseline:
	$(DC) exec laravel.test ./vendor/bin/phpstan analyse --generate-baseline

# Run ESLint
lint:
	$(DC) exec laravel.test npm run lint

# Run ESLint check only (no fix)
lint-check:
	$(DC) exec laravel.test npm run lint:check

# Run Prettier
format:
	$(DC) exec laravel.test npm run format

# Run all code quality checks
quality: pint-test lint-check test
	@echo "All quality checks passed!"

# ─── API Docs ──────────────────────────────────────────

# Generate Swagger/OpenAPI docs
swagger:
	$(DC) exec laravel.test php artisan l5-swagger:generate

# Clean generated Swagger files
swagger-clean:
	$(DC) exec laravel.test php artisan l5-swagger:clean

# ─── Cache & Optimization ─────────────────────────────

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

# ─── Logs ──────────────────────────────────────────────

# View all logs
logs:
	$(DC) logs -f

# View app logs only
logs-app:
	$(DC) logs -f laravel.test
