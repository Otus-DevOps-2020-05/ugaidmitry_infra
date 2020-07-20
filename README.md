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


