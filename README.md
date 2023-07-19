Дипломная работа по профессии «Системный администратор»

---

* Файлы терраформа лежат в этом репозитории. terraform apply в дирекетории с этим репозиторием => yes. (Время развёртывания инфраструктуры ~7 минут). В output выведены адреса развёрнутых ресоурсов. 
* ``` ssh <адресс bastion-хоста> ```
* На bastion-хосте, для удобства, редактирую /etc/hosts, вписываются адреса и желаемые хостенэймы ресурсов.
* На bastion-хосте: ``` ssh-keygen ```
* На bastion-хосте: ``` ssh-copy-id elastic; ssh-copy-id prom; ssh-copy-id grafana; ssh-copy-id kibana; ssh-copy-id web-1; ssh-copy-id web-2 ```
* На bastion-хосте: ``` git clone <url репозитория с директорией upravlenie_hostami> ```
 
