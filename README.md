# Neler Yapıyoruz Böyle :)

Aşağıdaki bilgilerin biraz daha tafsilatlısı (ayrıntılısı) için:
> [Dockerfile ve rsyslog ile cron nasıl çalışıyor açıklamasını burada bulabilirsiniz](./etc-crontab/README.md)

### Yapılacaklar

- [x] cron, rsyslog Nedir ve nasıl çalışır?
- [x] PID 1 nedir ve yönlendirme (redirection) nasıl çalışıyor?
- [x] Konteynerin günlüklerinde zamanlanmış görevlerin çıktılarını görelim
- [ ] Konteynerin günlüklerini fluentd log-driver'ı ile sunucuya yönlendirelim 
  - [ ] Günlükleri toplayan bir sunucu ayaklandıralım
  - [ ] Konteynerin günlüklerini bu sunuya yönlendirelim 
  - [ ] Günlükleri gösterecek şekilde Grafana'yı ayaklandıralım :tada:



# Ne, Nasıl ve Ne için Çalışıyor?

`crontab -e` ile sisteme giriş yaptığımız kullanıcıya ait bir zamanlanmış görev tablosu oluşturabiliriz ki bu dosya `/var/spool/cron/crontabs/` dizininde kullanıcı adıyla oluşacaktır.
Ama biz `/etc/cron.d/` dizininde bir dosya oluşturalım ve içine sonunda boş bir satırla bitecek şunu yazalım:

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

## Docker Günlüklerini Harici Sunucuda Toplamak ve Görüntülemek

[Sonraki...](./cron-loki/README.md)
