Дипломная работа по профессии «Системный администратор»

---

1. Файлы терраформа лежат в этом репозитории. terraform apply в дирекетории с этим репозиторием => yes. (Время развёртывания инфраструктуры ~7 минут). В output выведены адреса развёрнутых ресоурсов.
2. ```bash ssh <адресс bastion-хоста> ```
3. На bastion-хосте, для удобства, редактирую /etc/hosts, вписываются адреса и желаемые хостенэймы ресурсов.
4. На bastion-хосте: ```bash ssh-keygen ```
5. На bastion-хосте: ```bash ssh-copy-id elastic; ssh-copy-id prom; ssh-copy-id grafana; ssh-copy-id kibana; ssh-copy-id web-1; ssh-copy-id web-2 ```
6. На bastion-хосте: ```bash git clone <url репозитория с директорией upravlenie_hostami> ```
 
