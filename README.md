# Laravel 12 Vue Starter Kit

A modern full-stack starter kit built with Laravel 12, Vue 3, Inertia.js, and Tailwind CSS. This template provides a solid foundation for building robust web applications with authentication, authorization, and API documentation out of the box.

## Features

- **Laravel 12** - The latest version of Laravel framework
- **Vue 3.5** - Progressive JavaScript framework with Composition API
- **Inertia.js 3** - Modern monolith architecture without API complexity
- **Jetstream** - Authentication scaffolding with team management
- **Fortify** - Backend authentication implementation
- **Spatie Permissions** - Role and permission management
- **Tailwind CSS 4** - Utility-first CSS framework with CSS-first configuration
- **Vite 6** - Lightning-fast build tool
- **Sanctum** - API token authentication
- **Swagger/OpenAPI** - API documentation with L5-Swagger
- **Docker Support** - Containerized development environment with Redis, queue worker, and scheduler
- **Ziggy** - Use Laravel named routes in Vue components
- **ESLint & Prettier** - Code quality and formatting tools

## Prerequisites

### Required
- **WSL 2** (Windows Subsystem for Linux) - For Windows users
- **Docker Desktop** with WSL 2 backend enabled
- **Docker Compose**
- **Make** (usually pre-installed in WSL)

### Included in Docker Container
- PHP 8.4
- Composer
- Node.js 20+ and npm
- MySQL 8.4
- Redis 7

## Installation

### Prerequisites Setup (Windows Users)

1. **Install WSL 2**
   ```powershell
   # Run in PowerShell as Administrator
   wsl --install
   ```
   Restart your computer after installation.

2. **Install Docker Desktop**
   - Download from https://www.docker.com/products/docker-desktop
   - During installation, ensure "Use WSL 2 based engine" is enabled
   - In Docker Desktop settings, go to Resources > WSL Integration
   - Enable integration with your WSL distribution (Ubuntu)

3. **Open WSL Terminal**
   ```powershell
   wsl
   ```

### Docker Installation (Using Makefile)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd laravel-12-vue3-docker-setup
   ```

2. **Copy environment file**
   ```bash
   cp .env.example .env
   ```

3. **Start Docker containers using Makefile**
   ```bash
   make up
   ```
   This command uses the Makefile to start all Docker containers defined in compose.yaml.

4. **Install PHP dependencies via Makefile**
   ```bash
   make composer cmd="install"
   ```

5. **Install JavaScript dependencies via Makefile**
   ```bash
   make npm cmd="install"
   ```

6. **Generate application key**
   ```bash
   make artisan cmd="key:generate"
   ```

7. **Run migrations**
   ```bash
   make migrate
   ```

8. **Start Vite development server**
   ```bash
   make npm-dev
   ```

9. **Access the application**
   - Open your browser and navigate to `http://localhost`
   - The application should now be running!

### Alternative: Manual Installation (Without Docker)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd laravel-12-vue3-docker-setup
   ```

2. **Install PHP dependencies**
   ```bash
   composer install
   ```

3. **Install JavaScript dependencies**
   ```bash
   npm install
   ```

4. **Copy environment file**
   ```bash
   cp .env.example .env
   ```

5. **Generate application key**
   ```bash
   php artisan key:generate
   ```

6. **Configure your database in `.env` file**

7. **Run migrations**
   ```bash
   php artisan migrate
   ```

8. **Start the development servers**
   ```bash
   # Terminal 1: Laravel server
   php artisan serve
   
   # Terminal 2: Vite dev server
   npm run dev
   ```

## Usage

### Available Make Commands

| Command | Description |
|---------|-------------|
| `make up` | Start Docker containers |
| `make down` | Stop Docker containers |
| `make restart` | Restart Docker containers |
| `make migrate` | Run database migrations |
| `make migrate-refresh` | Refresh database and re-run migrations |
| `make tinker` | Open Laravel Tinker |
| `make shell` | Enter container shell |
| `make artisan cmd="command"` | Run Artisan command |
| `make composer cmd="command"` | Run Composer command |
| `make npm cmd="command"` | Run npm command |
| `make npm-dev` | Start Vite dev server |
| `make npm-build` | Build production assets |
| `make test` | Run PHPUnit tests |
| `make pint` | Run Laravel Pint (code formatting) |
| `make pint-test` | Run Pint in test mode (dry run) |
| `make lint` | Run ESLint |
| `make format` | Run Prettier |
| `make cache-clear` | Clear all caches |
| `make optimize` | Optimize for production |

### Development Workflow

**Important:** All commands should be run from within WSL terminal in the project directory.

```bash
# Open WSL terminal (from Windows)
wsl

# Navigate to project
cd ~/projects/laravel-12-vue3-docker-setup

# Start containers using Makefile
make up

# Run migrations using Makefile
make migrate

# Start Vue dev server with hot reload using Makefile
make npm-dev

# In another WSL terminal, view logs
make down
```

### Building for Production

```bash
# Build optimized assets
make npm-build

# Or manually
npm run build
```

### Code Quality

```bash
# Format PHP code with Laravel Pint
make pint

# Check PHP code without modifying
make pint-test

# Lint JavaScript/Vue files
make lint

# Format JavaScript/Vue files
make format
```

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
└── public/               # Public assets
```

## Authentication

This starter kit uses **Laravel Jetstream** with **Fortify** for authentication, providing:

- User registration
- Login/Logout
- Two-factor authentication
- Email verification
- Password reset
- Password confirmation
- API token management
- Profile management

Access authentication features at `/login`, `/register`, etc.

## Authorization

**Spatie Laravel Permission** is integrated for role and permission management:

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

API documentation is available via **L5-Swagger**:

1. Generate documentation:
   ```bash
   make swagger
   ```

2. Access Swagger UI at: `http://localhost/api/documentation`

## Testing

```bash
# Run all tests
make test

# Or manually
php artisan test

# Run specific test file
php artisan test --filter=ExampleTest

# Run with coverage
php artisan test --coverage
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

## Docker Configuration

This application is designed to run with **Docker in WSL 2**. All Docker commands are managed through the **Makefile** for convenience.

### Docker Services

- **laravel.test** - Main PHP application server
- **mysql** - MySQL 8.4 database
- **redis** - Redis 7 for caching, sessions, and queues
- **queue** - Background job processor
- **scheduler** - Laravel task scheduler
- **phpmyadmin** - Database management UI (port 8080)

### Docker Files

- **compose.yaml** - Main Docker Compose configuration
- **docker-compose.override.yml** - Local development overrides
- **Makefile** - Convenient commands to manage Docker containers

### How It Works

The Makefile wraps Docker Compose commands to simplify container management:

```makefile
# Instead of: docker-compose up -d
make up

# Instead of: docker-compose exec app php artisan migrate
make migrate

# Instead of: docker-compose exec app composer install
make composer cmd="install"
```

### WSL Integration

This project runs in WSL 2. Benefits:

- Native Linux environment for Laravel
- Better Docker performance
- Seamless file system access from Windows
- Full compatibility with Linux-based tools

### Customization

Customize `compose.yaml` and `docker-compose.override.yml` based on your infrastructure needs. The Makefile can also be extended with additional commands.

## Environment Variables

Key environment variables to configure:

```env
APP_NAME="Laravel"
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
REDIS_PASSWORD=null
REDIS_PORT=6379

QUEUE_CONNECTION=redis
CACHE_STORE=redis
SESSION_DRIVER=redis

MAIL_MAILER=log
MAIL_HOST=127.0.0.1
MAIL_PORT=2525
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open-sourced software licensed under the [MIT license](https://opensource.org/licenses/MIT).

## Support

For issues and questions:
- Create an issue in the repository
- Check Laravel documentation: https://laravel.com/docs
- Check Vue documentation: https://vuejs.org
- Check Inertia.js documentation: https://inertiajs.com

## Acknowledgments

- [Laravel](https://laravel.com)
- [Vue.js](https://vuejs.org)
- [Inertia.js](https://inertiajs.com)
- [Tailwind CSS](https://tailwindcss.com)
- [Laravel Jetstream](https://jetstream.laravel.com)
- [Spatie Laravel Permission](https://spatie.be/docs/laravel-permission)
