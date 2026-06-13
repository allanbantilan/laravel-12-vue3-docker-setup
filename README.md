# Laravel 12 Vue 3 Starter Kit

A modern full-stack starter kit built with Laravel 12, Vue 3, Inertia.js, and Tailwind CSS. Production-ready Docker setup with authentication, authorization, and API documentation out of the box.

## Features

- **Laravel 12** — Latest Laravel framework
- **Vue 3.5** — Composition API with `<script setup>`
- **Inertia.js 3** — Monolith architecture without API complexity
- **Jetstream** — Authentication scaffolding with team management
- **Fortify** — Backend authentication implementation
- **Spatie Permissions** — Role and permission management
- **Tailwind CSS 4** — CSS-first configuration
- **Vite 8** — Lightning-fast build tool
- **Sanctum** — API token authentication
- **Swagger/OpenAPI** — API documentation with L5-Swagger
- **Docker** — Containerized dev + production environments with health checks
- **Ziggy** — Laravel named routes in Vue components
- **ESLint & Prettier** — Code quality and formatting
- **Larastan** — PHP static analysis
- **Husky** — Pre-commit hooks for code quality
- **Laravel Pulse** — Application performance monitoring

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Backend | Laravel 12, PHP 8.4 |
| Frontend | Vue 3.5, Inertia.js 3 |
| CSS | Tailwind CSS 4 |
| Build | Vite 8 |
| Database | MySQL 8.4 |
| Cache/Queue | Redis 7 |
| Auth | Laravel Jetstream + Fortify + Sanctum |
| Permissions | Spatie Laravel Permission |
| API Docs | L5-Swagger (OpenAPI) |
| Static Analysis | Larastan (PHPStan) |
| Monitoring | Laravel Pulse |

## Prerequisites

### Required

- **Docker Desktop** with Docker Compose v2
- **Make** (pre-installed on macOS/Linux, available via `choco install make` on Windows)

### Included in Docker Container

- PHP 8.4
- Composer
- Node.js 20+ and npm
- MySQL 8.4
- Redis 7

## Quick Start

```bash
# Clone the repository
git clone <repository-url>
cd laravel-12-vue3-docker-setup

# Copy environment file
cp .env.example .env

# Start containers and install dependencies
make up
make composer cmd="install"
make npm cmd="install"
make artisan cmd="key:generate"
make migrate
make npm-dev
```

Open [http://localhost](http://localhost) in your browser.

## Platform-Specific Setup

### Windows (WSL 2)

1. **Install WSL 2** (run in PowerShell as Administrator):
   ```powershell
   wsl --install
   ```
   Restart your computer after installation.

2. **Install Docker Desktop:**
   - Download from [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
   - Enable "Use WSL 2 based engine" in settings
   - Enable WSL integration with your distribution (Ubuntu)

3. **Open WSL terminal** and follow the Quick Start above.

### macOS

1. **Install Docker Desktop:**
   - Download from [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
   - Or via Homebrew: `brew install --cask docker`

2. **Install Make** (if not present):
   ```bash
   xcode-select --install
   ```

3. **Follow the Quick Start above.**

### Linux

1. **Install Docker Engine:**
   ```bash
   # Ubuntu/Debian
   curl -fsSL https://get.docker.com | sh
   sudo usermod -aG docker $USER
   ```
   Log out and back in after adding yourself to the docker group.

2. **Install Docker Compose:**
   ```bash
   sudo apt install docker-compose-plugin
   ```

3. **Install Make:**
   ```bash
   sudo apt install make
   ```

4. **Follow the Quick Start above.**

## Docker Setup

### Development

```bash
make up          # Start all containers
make down        # Stop all containers
make restart     # Restart all containers
make shell       # Enter container shell
make logs        # View all logs
make logs-app    # View app logs only
```

### Production

Build and run the optimized production Docker image:

```bash
make docker-build    # Build production image
make docker-up       # Start with production config
```

The production Dockerfile uses multi-stage builds:
- **Stage 1:** Builds frontend assets with Node.js
- **Stage 2:** PHP-FPM Alpine with OPcache, no dev dependencies

### Docker Services

| Service | Description | Port |
|---------|-------------|------|
| `laravel.test` | PHP application server | 80 |
| `mysql` | MySQL 8.4 database | 3306 |
| `redis` | Redis 7 (cache, sessions, queues) | 6379 |
| `queue` | Background job processor | — |
| `scheduler` | Laravel task scheduler | — |
| `phpmyadmin` | Database management UI | 8080 |

All services include health checks for reliable startup ordering.

## Available Make Commands

### Docker

| Command | Description |
|---------|-------------|
| `make up` | Start Docker containers |
| `make down` | Stop Docker containers |
| `make restart` | Restart Docker containers |
| `make shell` | Enter container shell |
| `make redis-cli` | Open Redis CLI |
| `make docker-build` | Build production Docker image |
| `make docker-up` | Start with production config |

### Database

| Command | Description |
|---------|-------------|
| `make migrate` | Run database migrations |
| `make migrate-refresh` | Refresh and re-run migrations |
| `make seed` | Run database seeder |
| `make fresh` | Fresh migrate + seed |

### Development

| Command | Description |
|---------|-------------|
| `make npm-dev` | Start Vite dev server |
| `make npm-build` | Build production assets |
| `make tinker` | Open Laravel Tinker |
| `make artisan cmd="command"` | Run Artisan command |
| `make composer cmd="command"` | Run Composer command |
| `make npm cmd="command"` | Run npm command |

### Code Quality

| Command | Description |
|---------|-------------|
| `make pint` | Format PHP code (Laravel Pint) |
| `make pint-test` | Check PHP formatting (dry run) |
| `make phpstan` | Run Larastan static analysis |
| `make phpstan-baseline` | Generate PHPStan baseline |
| `make lint` | Lint JavaScript/Vue files |
| `make lint-check` | Check lint without fixing |
| `make format` | Format with Prettier |
| `make quality` | Run all quality checks |

### Testing

| Command | Description |
|---------|-------------|
| `make test` | Run PHPUnit tests |
| `make test-coverage` | Run tests with coverage |

### API Documentation

| Command | Description |
|---------|-------------|
| `make swagger` | Generate Swagger docs |
| `make swagger-clean` | Clean generated docs |

### Cache & Optimization

| Command | Description |
|---------|-------------|
| `make cache-clear` | Clear all caches |
| `make optimize` | Optimize for production |

### Logs

| Command | Description |
|---------|-------------|
| `make logs` | View all container logs |
| `make logs-app` | View app logs only |

## Project Structure

```
├── app/
│   ├── Actions/          # Jetstream actions
│   ├── Http/
│   │   ├── Controllers/  # API and web controllers
│   │   └── Middleware/   # Custom middleware
│   ├── Models/           # Eloquent models
│   └── Providers/        # Service providers
├── config/               # Configuration files
├── database/
│   ├── factories/        # Model factories
│   ├── migrations/       # Database migrations
│   └── seeders/          # Database seeders
├── resources/
│   ├── css/              # Stylesheets
│   ├── js/
│   │   ├── Components/   # Vue components
│   │   ├── Layouts/      # Layout components
│   │   └── Pages/        # Inertia pages
│   └── views/            # Blade templates
├── routes/
│   ├── api.php           # API routes
│   ├── web.php           # Web routes
│   └── console.php       # Console commands
├── tests/                # Unit and feature tests
├── Dockerfile            # Production Docker image
├── compose.yaml          # Development Docker Compose
├── docker-compose.prod.yml  # Production Docker Compose
├── Makefile              # Convenience commands
└── phpstan.neon          # Larastan configuration
```

## Authentication & Authorization

### Authentication

This starter kit uses **Laravel Jetstream** with **Fortify** for authentication:

- User registration and login
- Two-factor authentication
- Email verification
- Password reset and confirmation
- API token management
- Profile management

### Authorization (Spatie Permissions)

```php
// Assign role to user
$user->assignRole('admin');

// Give permission to user
$user->givePermissionTo('edit articles');

// Check permissions in controllers
if ($user->can('edit articles')) {
    // ...
}
```

```vue
<!-- Check permissions in Vue components -->
<template>
  <div v-if="$page.props.auth.user.permissions.includes('edit articles')">
    <!-- Content for users with permission -->
  </div>
</template>
```

## API Documentation

1. Generate documentation:
   ```bash
   make swagger
   ```

2. Access Swagger UI at: `http://localhost/api/documentation`

## Testing

```bash
# Run all tests
make test

# Run with coverage
make test-coverage

# Run specific test
make artisan cmd="test --filter=ExampleTest"
```

## Code Quality

### Pre-commit Hooks

Husky automatically runs lint-staged on every commit:
- **Vue/JS/TS files:** ESLint + Prettier
- **CSS files:** Prettier

### Static Analysis

```bash
# Run Larastan
make phpstan

# Generate baseline (ignore current errors)
make phpstan-baseline
```

### Manual Quality Checks

```bash
# Run all checks at once
make quality
```

## Frontend Development

### Using Inertia.js

Create Vue pages in `resources/js/Pages/`:

```vue
<script setup>
import { Head } from '@inertiajs/vue3'

defineProps({
  users: Array
})
</script>

<template>
  <Head title="Users" />
  <div>
    <h1>Users</h1>
    <div v-for="user in users" :key="user.id">
      {{ user.name }}
    </div>
  </div>
</template>
```

Return from controller:

```php
use Inertia\Inertia;

public function index()
{
    return Inertia::render('Users/Index', [
        'users' => User::all()
    ]);
}
```

### Using Ziggy Routes

```vue
<script setup>
import { router } from '@inertiajs/vue3'

const deleteUser = (userId) => {
  router.delete(route('users.destroy', userId))
}
</script>
```

## Environment Variables

Key environment variables to configure in `.env`:

```env
APP_NAME="Your App"
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=mysql
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=sail
DB_PASSWORD=password

REDIS_HOST=redis
REDIS_PORT=6379

QUEUE_CONNECTION=redis
CACHE_STORE=redis
SESSION_DRIVER=redis

LOG_CHANNEL=daily
LOG_DAILY_DAYS=30

PULSE_ENABLED=true
```

## Troubleshooting

### Common Issues

**Port already in use:**
```bash
# Change ports in .env
APP_PORT=8080
FORWARD_DB_PORT=3307
FORWARD_REDIS_PORT=6380
```

**Permission issues with storage:**
```bash
make shell
chmod -R 775 storage bootstrap/cache
chown -R www:www storage bootstrap/cache
```

**Vite hot reload not working:**
```bash
make npm cmd="run dev"
# Or restart containers
make restart
```

### WSL-Specific Issues

**Docker not starting in WSL:**
```bash
# Ensure Docker Desktop WSL integration is enabled
# Settings > Resources > WSL Integration > Enable your distro
```

**File performance in WSL:**
- Store project files in the WSL filesystem (`~/projects/`), not `/mnt/c/`
- Docker Desktop > Settings > Resources > WSL Integration > Enable "Use the WSL 2 based engine"

### Docker Issues

**Containers not healthy:**
```bash
docker compose ps          # Check container status
docker compose logs        # View logs for issues
make down && make up       # Full restart
```

**MySQL connection refused:**
```bash
# Wait for MySQL health check to pass
make up
# Check health status
docker compose ps
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Commit Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):
- `feat:` — New feature
- `fix:` — Bug fix
- `docs:` — Documentation changes
- `chore:` — Maintenance tasks
- `refactor:` — Code refactoring

## License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

## Acknowledgments

- [Laravel](https://laravel.com)
- [Vue.js](https://vuejs.org)
- [Inertia.js](https://inertiajs.com)
- [Tailwind CSS](https://tailwindcss.com)
- [Laravel Jetstream](https://jetstream.laravel.com)
- [Spatie Laravel Permission](https://spatie.be/docs/laravel-permission)
