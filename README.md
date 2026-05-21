### Hexlet tests and linter status:
[![Actions Status](https://github.com/AndreiZaikin/devops-for-developers-project-77/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/AndreiZaikin/devops-for-developers-project-77/actions)

# Инфраструктура как код

## Инфраструктура

- **2 виртуальные машины** — веб-серверы с приложением
- **Балансировщик нагрузки** — принимает запросы на порты 80/443
- **Yandex Managed PostgreSQL** — база данных для приложения
- **Сеть и подсеть** — `192.168.10.0/24` в зоне `ru-central1-a`
- **Домен** — [hexlet-deploy-project.ru](https://hexlet-deploy-project.ru)

## Структура проекта

- `terraform/` — конфигурация инфраструктуры
- `ansible/` — плейбуки для настройки ВМ

## Требования

- Terraform >= 0.13
- Yandex Cloud CLI (`yc`)
- Ansible (для настройки ВМ)

## Быстрый старт

### 1. Аутентификация

Установите переменные окружения для работы с Yandex Cloud:

```bash
# Замените <service-account-id> на ID вашего сервисного аккаунта
export YC_TOKEN=$(yc iam create-token --impersonate-service-account-id <service-account-id>)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
```

Установите переменные для Terraform:
```bash
# Пароль для базы данных (придумайте сами)
export TF_VAR_db_password="ваш_пароль_бд"
# API и Application ключи DataDog (получите в DataDog: Organization Settings → API Keys / Application Keys)
export TF_VAR_datadog_api_key="ваш_api_ключ_datadog"
export TF_VAR_datadog_app_key="ваш_app_ключ_datadog"
```
Установите пароль для Ansible Vault (придумайте сами):
```bash
export ANSIBLE_VAULT_PASSWORD="ваш_пароль_vault"
```

В директории `ansible/` создайте файл `vault.yml` со следующим содержимым:

```yaml
vault_redmine_db_password: "ваш_пароль_бд"
vault_secret_key_base: "любая_строка_для_secret_key_base"
vault_datadog_api_key: "ваш_api_ключ_datadog"
vault_datadog_app_key: "ваш_app_ключ_datadog"
```

Зашифруйте его:

```bash
ansible-vault encrypt ansible/vault.yml
```

### 2. Инициализация

```bash
make init
```

### 3. Планирование
```bash
make plan
```

### 4. Создание инфраструктуры
```bash
make apply
```

### 5. Установка Docker на серверы
```bash
make setup-docker
```

### 6. Деплой приложения
```bash
make deploy
```

### 7. Установка DataDog агента
```bash
make setup-monitoring
```

### 8. Просмотр выходных данных
```bash
make output
```

### 9. Удаление инфраструктуры
```bash
make destroy
```

### 10. Форматирование кода
```bash
make fmt
```

### 11. Очистка кеша
```bash
make clean
```
