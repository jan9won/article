# Auto-Renew Certbot Certificates With Crontab

> **Reviews**
>
> - last reviewed : 2021-11-30
>
> **Related Versions**
>
> - certbot : 1.21.0
>
> **References**
>
> * [letsencrypt guide](https://letsencrypt.org/docs/integration-guide/#when-to-renew)



## Summary

Lets-Encrypt recommends users to force-renew certificates at least 30 days before expiration. Certbot's default lifetime is set to 90 days, so renewing once in 60 days will do. (If you don't Letsencrypt will notice you via email)

According to the official guide, when you are renewing more than 10k domains, you should request them in a smaller unit to prevent their server overload. You should also avoid sending requests concurrently. 



## How to Automate

1. Open crontab configuration as a root user.

```shell
sudo crontab -e
```

2. Set interval and write commands. 

```crontab
0 0 */60 * * timeout 60 certbot -d domain1.com,domain2.com --force-renewal > /path/to/log/file
```

* `0 0 */60 * *`    every 60 days

* `-d [domain]`    write multiple domains separated with comma after thins flag

* `--force-renewal`    this means, "don't prompt an interactive shell, just find domains and forcefully renew them" 

* `timeout 60`

  * If you have a typo on your domain, or you accidentally included a newly issuing domain, Certbot will prompt an interactive shell. In
  * With these kind of errors, Certbot's process will not exit until your crontab's timeout configuration. So we're writing timeout command.
  * But this approach can be dangerouse when you have many domains and requesets takes a long time. In this case do not set timeout.

* `> /path/to/log/file` Write output to a log file to check the result later.

  

