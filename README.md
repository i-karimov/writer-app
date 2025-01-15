# Код к тестовому заданию `Сервис для написания постов`

## Локальное развертывание:

1. Склонируйте репозиторий:
```bash
git clone git@github.com:i-karimov/writer-app.git
```
2. Перейдите в корневую директорию проекта:
```bash
cd writer-app
```
3. Запуститие сборку:
```bash
docker-compose build
```
4. Выполните миграции и предзаполнение таблиц:
```bash
docker-compose run web bundle install
docker-compose run web bundle exec rails db:prepare
```
5. Запустите приложение на http://localhost:3000:
```bash
docker-compose up
```



Запуск тестов:

```bash
docker-compose run web bundle exec rspec
```

## Войти как админ:
Email: `admin@admin.com` \
Пароль: `admin`

## Пароль базовых юзеров:

Пароль: `#13R1fr:wx,E`
