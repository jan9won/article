# Crontab 으로 Certbot 리뉴얼 자동화하기

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



## 개요

Lets-Encrypt 메뉴얼에서는 만료 30 일 전에, 그러니까 60 일 에 한번씩은 강제로 리뉴얼하도록 자동화하는걸 추천한다. (그 때까지 리뉴얼하지 않으면 이메일로 알려준다)

메뉴얼에 따르면, 리뉴얼할 도메인이 10000 개가 넘을 경우에는 작은 단위로 나누어 실행하고, 리뉴얼을 자동화할 경우에는 요청을 랜덤한 시간대에 (겹치지 않게) 보내야 한다.



## 리뉴얼 방법

1. root 권한으로 크론탭 설정을 연다.

```shell
sudo crontab -e
```

2. 리뉴얼 명령어를 입력한다.

```crontab
0 0 */60 * * timeout 60 certbot -d your.domain1.com,domain2.com --force-renewal > /path/to/log/file
```

* `0 0 */60 * *` 60 일에 한 번씩.

* `-d [domain]` 해당 플래그 뒤에 여러 도메인을 콤마로 구분하여 입력한다.

* `--force-renewal` 플래그를 사용하면 더이상의 인터랙션을 요구하지 않고 기존 인증서를 찾아서 리뉴얼해준다.

* `timeout 60`

  * 도메인을 잘못 입력했거나 처음 발급반는 도메인이 포함된 경우에는 인터렉티브 셸로 넘어갈 수 있다. 
  * 이런 오류상황에는 crontab timeout 설정시간 전까지 프로세스가 종료되지 않기 때문에 적당한 타임아웃을 설정한다.
  * 주의해야할 점은 도메인 갯수나 letsencrypt 서버 상태에 따라서 오래 걸릴 수 있기 때문에 도메인이 많은 경우 리뉴얼에 실패할 수 있다. 이런 경우 타임아웃 설정하지 않는다.

* `> /path/to/log/file` 실행 결과를 볼 수 있도록 아웃풋을 파일에 저장해준다. 

  

