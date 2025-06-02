# ──────────────────────────────────────────────────────────────
# Dockerfile para PHP 8.2-CLI + Node 20 + Composer + Git
# ──────────────────────────────────────────────────────────────

FROM php:8.2-cli

# 1) Instalar dependencias básicas para Node.js, Composer y Git
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    zip \
    gnupg \
    ca-certificates \
    lsb-release \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# 2) Instalar Node.js v20 desde NodeSource
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
  && apt-get update \
  && apt-get install -y nodejs \
  && npm install -g npm \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# 3) Instalar Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
  && chmod +x /usr/local/bin/composer

# 4) Crear directorio de trabajo
WORKDIR /workspace

# 5) (Opcional) Si necesitas ext-pdo_mysql, xdebug u otras extensiones de PHP, instálalas aquí.
#    Ejemplo para pdo_mysql:
# RUN docker-php-ext-install pdo_mysql

# 6) Expón el comando por defecto
CMD ["bash"]
