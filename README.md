# Neler Yapıyoruz Böyle :)

![image](https://user-images.githubusercontent.com/261946/207039066-d4d6ec55-6951-4bc2-9162-c041ffe7dac3.png)

Aşağıdaki bilgilerin biraz daha tafsilatlısı (ayrıntılısı) için:

> [Dockerfile ve rsyslog ile cron nasıl çalışıyor açıklamasını burada bulabilirsiniz](./etc-crontab/README.md)

### Yapılacaklar

- [X] cron, rsyslog Nedir ve nasıl çalışır?
- [X] PID 1 nedir ve yönlendirme (redirection) nasıl çalışıyor?
- [X] Konteynerin günlüklerinde zamanlanmış görevlerin çıktılarını görelim
- [X] Konteynerin günlüklerini fluentd log-driver'ı ile sunucuya yönlendirelim
  - [X] Günlükleri toplayan bir sunucu ayaklandıralım
  - [X] Konteynerin günlüklerini bu sunuya yönlendirelim
  - [X] Günlükleri gösterecek şekilde Grafana'yı ayaklandıralım 🎉

# Ne, Nasıl ve Ne için Çalışıyor?

/etc/crontab dosyası sistem üzerinde geçerli ilk iş listesidir ve satırlar içinde kullanıcı adı girmeye gerek yoktur. `crontab -e `ile sisteme giriş yaptığımız kullanıcıya ait bir zamanlanmış görev tablosu oluşturabiliriz ki bu dosya `/var/spool/cron/crontabs/`dizininde kullanıcı adıyla oluşacaktır. Ama biz `/etc/cron.d/` dizininde bir dosya oluşturalım ve içine sonunda boş bir satırla bitecek şunu yazalım:

```shell
* * * * * root /bin/sh -c "echo selam dunya > /proc/1/fd/1 2>/proc/1/fd/2"

```

![image](https://user-images.githubusercontent.com/261946/206898164-c1cbdcdf-3df9-4d11-a5d1-afdda24b10d1.png)

Cron'un günlük dosyasında hemen işletildiğini göreceğiz:

![image](https://user-images.githubusercontent.com/261946/206898145-58fba895-7d62-4a84-b93d-2eb9a10b1876.png)

Şimdi konteynerin günlük dosyasına bakalım ve zamanlanmış görevin PDI 1'in stdout dosyasına echo ile istediğimiz çıktıları yazıp yazmadığını görelim:

![image](https://user-images.githubusercontent.com/261946/206898364-a62b790f-ad89-4c87-97c6-65c4854d17aa.png)

Ne şirin değil mi? :)

---

## crontab Dosyasının Yetkilendirmesi

/var/log/cron.log dosyasında `INSECURE MODE (mode 0600 expected) (crontabs/root)` yazısını görünce anlıyoruz ki `/var/spool/cron/crontab/root` dosyasının yetkilendirmesinin 600 olması gerekiyor. Yani bağladığımız dosyasının `chmod 600 root-crontab` ile özelliklerinin değişmesi gerekiyor.

![image](https://user-images.githubusercontent.com/261946/208244462-be787e60-3fec-4997-b2a5-3bf0f18a5daf.png)
![image](https://user-images.githubusercontent.com/261946/208244475-060cd45a-8bed-4e46-bf08-df6ed32e8086.png)

---

## Docker Günlüklerini Harici Sunucuda Toplamak ve Görüntülemek

[Sonraki...](./cron-loki/README.md)
