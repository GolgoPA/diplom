# Дипломная работа по профессии «Системный администратор»

---

1. Файлы терраформа лежат в этом репозитории. terraform apply в дирекетории с этим репозиторием => yes. (Время развёртывания инфраструктуры ~7 минут). В output выведены адреса развёрнутых ресоурсов.
2. ```
   ssh <адресс bastion-хоста>
   ```
3. На bastion-хосте, для удобства, редактирую /etc/hosts, вписываются адреса и желаемые хостенэймы ресурсов.
4. На bastion-хосте:
   ```
    ssh-keygen
   ```
5. На bastion-хосте:
   ```
   ssh-copy-id elastic; ssh-copy-id prom; ssh-copy-id grafana; ssh-copy-id kibana; ssh-copy-id web-1; ssh-copy-id web-2
   ```
   ( везде yes, пароль: admin )
6. На bastion-хосте:
   ```
   git clone https://github.com/GolgoPA/upravlenie_hostami
   ```
7. На бастион хосте:
   ```
   cd upravlenie_hostami
   ```
8. На бастион хосте:
   ```
   ansible-playbook elk.yaml; ansible-playbook mon.yaml; ansible-playbook webs.yaml
   ```
9. На elastic хосте:
   ```
   sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u elastic -i
   ```
   (adminadmin)

   ```
   sudo /usr/share/elasticsearch/bin/elasticsearch-reset-password -u kibana_system -i
   ```
   (adminadmin)

   ```
   sudo nano /etc/elasticsearch/elasticsearch.yml 
   ```
   Раскомментить последние две строки

   ```
   sudo cat /etc/elasticsearch/certs/http_ca.crt
   ```
   Скопировать сертификат.

10. На kibana хосте:
    ```
    sudo mkdir /etc/kibana/certs
    ```

    ```
    sudo nano /etc/kibana/certs/http_ca.crt
    ```
    (Вставить скопированный сертификат)

    ```
    sudo chown -R root:kibana /etc/kibana/certs
    ```

    ```
    sudo nano /etc/kibana/kibana.yml
    ```
    Вставить адреса elastic'a и паблик kibana в последние две строки конфига.

    ```
    sudo systemctl restart kibana
    ```
11. На хосте web-1 и web-2:
    ```
    sudo nano /etc/filebeat/filebeat.yml
    ```
    Вставить адрес elastic'a и kibana, вставить сертификат.

    ```
    sudo nano /etc/filebeat/modules.d/nginx.yml.disabled
    ```
    Заменить false на true в блоках error и access

    ```
    sudo systemctl restart filebeat
    ```

    ```
    sudo filebeat modules enable nginx
    ```

    ```
    sudo filebeat setup
    ```

    ```
    sudo filebeat -e 
    ```
12. А
