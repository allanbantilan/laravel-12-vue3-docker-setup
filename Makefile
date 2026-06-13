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

# Run Laravel Pint (code formatting)
pint:
	$(SAIL) pint

# Run Pint with test mode (dry run)
pint-test:
	$(SAIL) pint --test

# Run Pint on specific path
pint-path:
	$(SAIL) pint $(path)

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

# Run ESLint
lint:
	$(SAIL) npm run lint

# Run Prettier
format:
	$(SAIL) npm run format

# Clear all caches
cache-clear:
	$(SAIL) artisan cache:clear
	$(SAIL) artisan config:clear
	$(SAIL) artisan route:clear
	$(SAIL) artisan view:clear

# Optimize for production
optimize:
	$(SAIL) artisan config:cache
	$(SAIL) artisan route:cache
	$(SAIL) artisan view:cache
	$(SAIL) artisan event:cache
