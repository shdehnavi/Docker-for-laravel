#!/bin/bash

# Migrate and seed database
php "/var/www/html/artisan" migrate --seed --force --isolated

# Refresh caches
php "/var/www/html/artisan" optimize:clear
php "/var/www/html/artisan" optimize
php "/var/www/html/artisan" icon:cache
php "/var/www/html/artisan" filament:cache-components

# Create storage symlinks
php "/var/www/html/artisan" storage:link

# Start Supervisor
exec supervisord -c /etc/supervisor/supervisord.conf
