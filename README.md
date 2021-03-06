# Openteam::Capistrano

Добавлена поддержка Capistrano v3.

###### Обновлен до версии 3.5

## Установка

Добавить в Gemfile:

    gem 'openteam-capistrano', '~> 1.0.12'

Затем выполнить:

    $ bundle

## Использование

* Удаляем все что связано с capistrano v2 (Capfile, config/deploy.rb, config/deploy/)
* Ставим gem openteam-capistrano

Запускаем генератор:

    $ rails g openteam:capistrano:install

Необходимо поправить Capfile, если версия Airbrake >= 4

    $ vim Capfile

  Удалить строчку 4 и раскоментировать 5

Если AirBrake < 4, то ничего делать не надо.

В папке config/deploy/ должны остаться файлы соответствующие стейджам.
В Capfile необходимо раcкомментировать необходимые задачи для Sidekiq и Whenever если это необходимо.

Деплой приложения:

    $ bundle exec cap STAGE deploy

или:

    $ bin/cap STAGE deploy

## Схема работы с бренчами

В Capistrano v3 изменилась схема работы со стейджами - теперь обязательно указывать стейдж при деплое. Опция set :default_stage была удалена.

В папке config/deploy/ должен лежать пустой файл с именем стейджа, деплой должен происходить из бранча с таким же именем что и стейдж.

В бренч из которого производится деплой нельзя делать комиты. Разработка ведется в мастере! Перед деплоем делаем:

    $ git checkout STAGE
    $ git rebase master
    $ git push
    $ git checkout master
    $ bundle exec cap STAGE deploy

###### Если нет необходимости в разделенных ветках (например, приложение очень маленькое и не относится ни к одной из веток разработки (ato, tusur, esp)), то можно использовать ветку master и деплоить из неё.
