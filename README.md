# Дипломная работа по профессии «Системный администратор»

---

1. Файлы терраформа лежат в этом репозитории. terraform apply в дирекетории с этим репозиторием => yes. (Время развёртывания инфраструктуры ~7 минут). В output выведены адреса развёрнутых ресоурсов.
2. ```
   ssh <адресс bastion-хоста>
   ```
3. На bastion-хосте: 
   ```
   sudo nano /etc/hosts
   ```
   Вписываются адреса и хостенэймы ресурсов.
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
   Раскомментить network_host.

   ```
   sudo systemctl restart elasticsearch
   ```

   ```
   sudo cp -R /etc/elasticsearch/certs /etc/logstash
   ```

   ```
   sudo chown -R root:logstash /etc/logstash/certs
   ```

   ```
   sudo cat /etc/elasticsearch/certs/http_ca.crt
   ```
   Скопировать сертификат.

11. На kibana хосте:
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
12. На хостах web-1 и web-2:

    ```
    sudo systemctl daemon-reload
    ```

    ```
    sudo nano /etc/prometheus-nginxlog-exporter.yml
    ```
    Поменять web-№ на номер сервера.

    ```
    sudo systemctl restart prometheus-nginxlog-exporter
    ```

    ```
    sudo systemctl restart nginx
    ```

    ```
    sudo nano /etc/filebeat/filebeat.yml
    ```
    Вставить адрес elastic.

    ```
    sudo systemctl restart filebeat
    ```

    
14. На хосте prom:

    ```
    sudo nano /etc/prometheus/prometheus.yml
    ```

    Вставить адреса целевых хостов в job'aх.

    ```
    sudo systemctl restart prometheus
    ```
    
16. На web-панели grafana установить соединение с prometheus.
17. Импортировать дашборд [dashboard](https://grafana.com/grafana/dashboards/1860-node-exporter-full/).
18. Сделать дашборд для метрик nginxlog-exporter'a.
19. Сделать визуализацию в kibana.
