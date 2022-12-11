
# Docker Günlüklerini Harici Sunucuda Toplamak ve Görüntülemek

## FLUENTD ile

### Sunucuyu Ayaklandıralım

Eğer günlük toplayıcımız fluentd sunucusu olacaksa:

```shell
$ docker run --rm -d --name gunluk-havuzu \
             -p 24224:24224 \
             -p 24224:24224/udp \
             -v /home/cnrusr/data:/fluentd/log \
             fluent/fluentd:v1.3-debian-1
```

### Konteyner Günlüklerini Sunucuya Yönlendirelim

fluentd Sürücüsü docker il birlikte geliyor ama loki sürücüsünü eklenti olarak kurmamız gerekiyor.
Aşağıdaki komutla alpine konteyneri ayaklanır ve `127.0.0.1:24224` adresine günlükleri basar.

```shell
$ docker run --log-driver=fluentd \
             --log-opt fluentd-address=127.0.0.1:24224 \
             --log-opt tag="etiket" \
             alpine ping 127.0.0.1
```
---

## LOKI ile

### Sunucuyu Ayaklandıralım

Eğer Loki'de günlükleri toplayacaksak LOKI sunucusunu ayaklandıralım:

```shell
$ docker run -d --name=loki \
             -v ./loki/config.yaml:/etc/loki/local-config.yaml \
             -p 3100:3100 \
             grafana/loki
```

### Konteyner Günlüklerini Sunucuya Yönlendirelim

Loki sunucusuna günlükleri yönlendirmek için LOKI sürcüsünü eklenti olarak yükleyelim ([Grafana sayfasından](https://grafana.com/docs/loki/latest/clients/docker-driver/)):

```shell
$ docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

Originator ayaklandıralım:
```shell
$ docker run -d --name ping \
      --log-driver=loki \
      --log-opt loki-url="https://<user_id>:<password>@logs-us-west1.grafana.net/loki/api/v1/push" \
      --log-opt tag="etiketim" \
      --log-opt loki-retries=5 \
      --log-opt loki-batch-size=400 \
      alpine ping 127.0.0.1
```

---

### Grafana Sunucusunu Ayaklandıralım