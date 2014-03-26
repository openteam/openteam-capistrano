# Openteam::Capistrano

Добавлена поддержка Capistrano v3.

## Установка

Добавить в Gemfile:

    gem 'openteam-capistrano', '~> 1.0.0', :require => false

Затем выполнить:

    $ bundle

Или установить gem:

    $ gem install openteam-capistrano

## Использование

* Удаляем все что связано с capistrano v2 (Capfile, config/deploy.rb, config/deploy/)
* Ставим gem openteam-capistrano

Запускаем генератор:

    $ rails g openteam:capistrano:install
    
Деплой приложения:

    $ bundle exec cap STAGE deploy

или:

    $ bin/cap STAGE deploy

## Схема работы с бренчами

В Capistrano v3 изменилась схема работы со стейджами - теперь обязательно указывать стейдж при деплое. Опция set :default_stage была удалена.

В папке config/deploy/ должен лежать пустой файл с именем стейджа, деплой должен происходить из бранча с таким же именем что и стейдж. 
