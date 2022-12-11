
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
             grafana/loki:2.7.0 --config.file=/etc/loki/local-config.yaml
```

### Konteyner Günlüklerini Sunucuya Yönlendirelim

Loki sunucusuna günlükleri yönlendirmek için LOKI sürcüsünü eklenti olarak yükleyelim ([Grafana sayfasından](https://grafana.com/docs/loki/latest/clients/docker-driver/)):

```shell
$ docker plugin install grafana/loki-docker-driver:latest --alias loki --grant-all-permissions
```

Sürücünün takma adını (alias) "loki" diye kaydettik!
Originator ayaklandıralım ve günlüklerin promtail ile çekilmesi (pull) yerine log-driver ile basılmasını sağlayalım:
```shell
$ docker run -d --name ping \
      --log-driver=loki \
      --log-opt loki-url="http://host.docker.internal:3100/loki/api/v1/push" \
      --log-opt loki-retries=5 \
      --log-opt loki-batch-size=400 \
      alpine ping 127.0.0.1
```

---

### Grafana Sunucusunu Ayaklandıralım

```shell
docker run -d --user $(id -u) \
     -v "./grafana/lib:/var/lib/grafana" \
     -v ./grafana/provisioning/:/etc/grafana/provisioning/ \
     -p 3000:3000 \
     grafana/grafana:9.2.2
```

Önce LOKI'yi Grafana'ya `Data Source` olarak ekleyelim. Bunun için tüm konteynerlerin çalıştığı bilgisayarın IP adresini kullanacağız. Ayrıca LOKI 3100 portunda çalıştığı için: `http://192.168.57.85:3100`

![image](https://user-images.githubusercontent.com/261946/206922274-45219a14-d99f-4540-b2f6-8368ae27afc0.png)

Günlükleri görmek için `EXPLORE` içinde Loki veri kaynağına bakalım:

![image](https://user-images.githubusercontent.com/261946/206922649-cf093660-9cda-4bd7-9f54-9e1ee1ae1215.png)
