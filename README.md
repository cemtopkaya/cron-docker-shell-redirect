# cron-docker-shell-redirect

![image](https://user-images.githubusercontent.com/261946/206875083-51b620be-755e-4b28-9e00-8afc00634f25.png)

Chrõnos, Yunanca ‘zaman’ demektir.

**Cron**, zamanlanmış görevleri çalıştırmak için sistem önyüklemesi sırasında çalışan bir arka plan programıdır. Çok kullanıcılı çalışma düzeyine girdiğinizde `cron` arka plan programı `/etc/init.d`’den otomatik olarak başlatılır.

![image](https://user-images.githubusercontent.com/261946/206875097-bb2b44a4-8462-48be-bf64-53cd389fc4be.png)


**Crontab** (**Chron**ological **Tab**le) komutu zamanlanmış cron girdilerinin tablosu üstünde, yeni görevleri zamanlamak, düzenlemesini veya silmesini sağlayan uygulamadır. Bu tablonun dosya konumu işletim sistemlerine göre değişir. Crontab ile düzenlenen işler kullanıcıların zamanlanmış görevleridir. Crontab dosyası, belirli zamanlarda yürütülen komutların bir listesine sahip basit bir metin dosyasıdır. `/var/spool/cron/crontabs` içindeki crontab dosyalarına erişmek ve bunları güncellemek için crontab komutunu kullanmanız önerilir. Yani elle değiştirmeyin !!!

**Cron job/cron schedule**, cron programı, yürütülecek günü, saati ve komutu belirten belirli bir yürütme yönergeleri kümesidir. crontab birden çok yürütme ifadesine sahip olabilir. Çoğu **cron job**, crontab komutu kullanılarak ayarlanırken, cron komutu bir defaya mahsus olmak üzere doğrudan kullanılabilir. Sisteminiz 7/24 açık değilse crontab’a anacron adında bir alternatif var.

Bir **crontab dosyası**, zamanlama bilgilerini tutan bir kullanıcı dosyasıdır. Komut dosyalarınızdan herhangi birini veya tek satırlık ifadeyle zamanlayıp çalıştırmak için crontab’ı kullanabilirsiniz, bu size kalmış.

Sistemde tanımlı her kullanıcı (root gibi) isterse kendi crontab’ını tanımlayabilir, ancak büyük sistemlerde `root` kullanıcısı genellikle buna izin vermez ve tüm sistem için yalnızca bir ana crontab dosyası kullanır. Root bunu, “`cron.deny`” ve “`cron.allow`” adlı bir dosya sayesinde yapabilir; burada `root`, kimlerin kendi crontab’larına sahip olup olamayacağını belirleyebilir.

> cron ayrıca biraz farklı bir formatta olan `/etc/crontab` dosyasını da okur (bkz. [crontab(5)](https://man7.org/linux/man-pages/man5/crontab.5.html)). Ek olarak, cron `/etc/cron.d` içindeki dosyaları da okur: `/etc/cron.d` içindeki dosyalara, `/etc/crontab` dosyasıyla aynı şekilde davranır. Ancak, `/etc/crontab`’tan bağımsızdırlar: örneğin, ortam değişkenleri ayarlarını `_/etc/crontab_`’tan devralmazlar. `/etc/cron.d` dizininde bir `crontab` dosyası eklemek için `/etc/cron.{hourly,daily,weekly,monthly}` dizinlerini kullanabiliriz. Cron, Debain ve Ubuntu’da `_/etc/crontab_`, ve `/etc/cron.*` dizinlerinin altındaki dosyaları arar ve yürütmek için belleğe yükler (günlük-`cron.daily`-, saatlik-`cron.hourly`-, haftalık-`cron.weekly`- ve aylık-`cron.monthly`-).

`/etc/cron.d` ve `/etc/crontab` içindeki işler sistem işleridir; genellikle birden fazla kullanıcı için kullanılır, bu nedenle ek olarak **kullanıcı adı** yazılması gereklidir.

`/etc/cron.d/cron.allow` ve `/etc/cron.d/cron.deny` dosyaları aracılığıyla crontab komutuna erişimi kısıtlayabilirsiniz. Bu dosyaların ikisi de Ubuntu’da varsayılan olarak mevcut değildir. `cron.allow` ve `cron.deny` dosyalarında belirtilen kullanıcılara sırasıyla crontab komutuna erişim izni verilir ve reddedilir. Her iki dosyada da, her satıra bir kullanıcı olacak şekilde kullanıcı adları eklemelisiniz.

Eğer cron günlüklerini aktif etmek isterseniz ve sisteminiz `rsyslog` ile çalışıyor ise /etc/rsyslog.d/50-default.conf ayar dosyasında değişiklik yapmanız gerekir.

```shell
# apt install rsyslog
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
The following additional packages will be installed:
  libestr0 libfastjson4 libpopt0 logrotate
....
..... buraları yapıştırmıyorum ....
....
Setting up rsyslog (8.2112.0-2ubuntu2.2) ...
Adding user `syslog' to group `adm' ...
Adding user syslog to group adm
Done.

Creating config file /etc/rsyslog.d/50-default.conf with new version
Setting up libpopt0:amd64 (1.18-3build1) ...
Setting up logrotate (3.19.0-1ubuntu1.1) ...
Processing triggers for libc-bin (2.35-0ubuntu3.1) ...
```

![image](https://user-images.githubusercontent.com/261946/206875258-5d925e04-3e9a-4a15-a105-d88370d950aa.png)


### Özetle Dosya & Dizinler

`**/etc/crontab**` ana sistem crontab dosyası.

`**/var/spool/cron/{root,user1,cnrusr..}**` kullanıcılar tarafından tanımlanan crontab’ları depolamak için dizin.

`**/etc/cron.d/**` sistem crontab’larını depolamak için dizindir. Bu dizindeki dosyaların uzantısı olmaksızın ve son satırlarının yeni ve boş bir satırla bitmesi gerektiğini unutmayın.
