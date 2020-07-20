# ugaidmitry_infra



ДЗ host bastion

1)Подключние к someinternalhost в одну команду: ssh someinternalhost

Создаем файл ~/.ssh/config с описание хостов, пользователей и команд:

Host bastion hostname 35.204.48.189 user dima

Host someinternalhost hostname 10.164.0.3 user dima proxycommand ssh bastion -W %h:%p

При подлключении на someinternalhost видим, что наша ssh-сессия открыта с bastionhost (см файл https://github.com/Otus-DevOps-2018-11/ugaidmitry_infra/blob/master/someinternalhost.png)

VPN-сервер Pritunl:

bastion_IP = 35.204.48.189 someinternalhost_IP = 10.164.0.3

Подключение к Pritunl серверу с рабочего хоста: sudo openvpn --config cloud-bastion.vpn

Д.З 7

Получены практические навыки работы с packer

Создан шаблон packer для подготовки reddit-base образа. Шаблон находится в файле packer/ubuntu16.json.

Чувствительные переменные вынесены в файл переменных packer/variables.json.example

Д.З 8 В процессе сделано:

-1 На основе terrafrom развернуто приложение reddit.Доступно по адресу http://адрес:9292.

-2 Определена input переменная для приватного ключа использующегося в определении подключения для провижинеров (connection).Файл https://github.com/Otus-DevOps-2018-11/ugaidmitry_infra/blob/terraform-1/terraform/main.tf

-3 Определил input переменную для задания зоны в ресурсе "google_compute_instance" "app". https://github.com/Otus-DevOps-2018-11/ugaidmitry_infra/blob/terraform-1/terraform/main.tf

-4 Отформатировал все конфигурационные файлы используя команду terraform fm

Д.З 10

-1 Создал шаблоны для packer db.json и app.json, на основе которых создал базовые образы reddit-base-app и reddit-base-db

-2 Создал модули app, db, vpc.

-3 Параметризировал модуль vpc и проверил его работу с разными ip адресами.

-4 Отформатировал конфигурационные файлы, используя команду terraform fmt.

-5 Использовал модуль storage-bucket от SweetOPS (https://github.com/SweetOps/terraform-google-storage-bucket) для создания бакетов, в которых будут храниться стейт файлы stage и prod окружений

Д.3 11


-1 Установлен Ansible для выполнения различных команд

-2 Созданы файлы invertory (`yml`,` json`)

-3 Создан конфигурационный файл `ansible.cfg` со значениями по умолчанию для проекта

-4 Создан ansible playbook, описанный в `clone.yml`, для проверки поведения ansible для повторяющихся задач.



Д.З 12


    [+ ] Основное ДЗ

 
  - Созданы ansible playbook:

  - reddit_app_one_play
  - reddit_app_multiple_plays
  - app.yml, db.yml, deploy.yml  Плейбуки встроены в `site.yml` для последовательной установки Reddit.
  - packer_db.yml, packer_app.yml созданы для использовании в PACKER
  - packer/app.json , packer/db.json обновлены для использования ansible playbook в место баш скриптов

Д.З 13


    [+ ] Основное ДЗ


  - созданы ansible-роли app, db, users (создаются пользователи для {prod,stage} окружений)
  - созданы окружения {prod,stage}
  - организован каталог ansible
        плейбуки перенесены в /ansible/playbooks
        прочие файлы перенесены в /ansible/old
  - созданы файл конфигурации и инвентори файлы (ini, yml, json*) для ansible

Д.З 14


- создано локальное окружение с использованием Vagrnat, в качестве провижионера используется ansible;
- доработаны роли для работы с Vagrant, доработаны json файлы с конфигами packer для совместимости;
- создано локальное окружение пользователя для работы с molecule
- созданы тесты и протестирована конфигурация

