# Dockerfile Uygulmaları

## cron
Zamanlanmış görevleri çalıştıracak uygulama. Buralarda bir yerde uygulamaya dair ziyadesiyle bilgi bulabilirsiniz.

## nano
`crontab -e` komutuyla kullanıcıya özgü `cron table` oluşturmak için varsayılan bir editör çalıştırılacak ki buradaki düzenleyici `nano` oluyor.

## rsyslog
Zamanlanmış görevlerimizin nerede hata verip nerede çalıştığını görmek için cron uygulamasının 
günlüklerini syslog standartında depolayabileceği bir hizmete (`rsyslog`) ihtiyacı olacak. 
İşte bunun için rsyslog kullanacağız ancak `cron.log` dosyasının oluşması için `/etc/rsyslog.d/50-default.conf` dosyasında işaretli satır yorum satırı olmaktan çıkarmalıyız.

Yorum satırı olduğunu:
![image](https://user-images.githubusercontent.com/261946/206894815-6035659e-975a-489c-8c06-6fd897caf882.png)

Ve cron günlüklerinin tutulmadığını görebiliriz:
![image](https://user-images.githubusercontent.com/261946/206895264-f48638be-4dbf-43c2-91b2-a31462c46329.png)

Aşağıdaki komut bu değişimi yapacaktır ama siz `-e` anahtarıyla dosyada değişim yapmadan sonucu görebilirsini (dry-run).

```shell
$ sed -i 's/#cron/cron/g'  /etc/rsyslog.d/50-default.conf
```

![image](https://user-images.githubusercontent.com/261946/206896439-75dce723-bcdf-44b2-b1a7-61c279a8377d.png)

Artık rsyslog servisini tekrar çalıştırabilirsiniz:

![image](https://user-images.githubusercontent.com/261946/206896936-6e38bcfe-d643-4237-bcf7-31bb97072fe2.png)

Cron servisini tekrar başlattığımızda artık günlük kaydının oluştuğunu görürüz.
```shell
$ service cron restart
```

![image](https://user-images.githubusercontent.com/261946/206897156-57214376-0da3-4707-a40e-eff1a2acbfc0.png)

Zamanlanmış görevleri bulmak için `crontab -l` yapıp `cron.log` dosyasına baktığımızda bir hareket olamdığını da görürüz:

![image](https://user-images.githubusercontent.com/261946/206897266-64f98138-1ddd-414a-bdbf-0658f1b9dcf6.png)


---

# Ne, Nasıl ve Ne için Çalışıyor?

`cron` Uygulaması kurulu ancak başlatılmadığı için (`ps aux` içinde yok!) servisin durumu `[ - ]` olarak görünüyor.

![image](https://user-images.githubusercontent.com/261946/206894533-bcafa83d-bc94-492f-bba9-2b50a3a08e20.png)
