Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s6HDFdxS018542
 for <selinux@tycho.nsa.gov>; Thu, 17 Jul 2014 09:15:39 -0400
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [mcstransd] Fails after Reload Translations
From: Joe Nall <joe@nall.com>
In-Reply-To: <53C766F5.4090905@windriver.com>
Date: Thu, 17 Jul 2014 08:15:54 -0500
Message-Id: <7E820C6F-E375-4E61-8DDF-77E8BE2D1BD2@nall.com>
References: <53C766F5.4090905@windriver.com>
To: wenzong fan <wenzong.fan@windriver.com>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


On Jul 17, 2014, at 1:02 AM, wenzong fan <wenzong.fan@windriver.com> wrote:

> Hello,
> 
> Generally the mcstransd works well on mls enabled system, but if "restart daemon" triggered, it will fail to trans the mls levels.

domain does seems to be scoped improperly for a reload. I'll take a look and get back in a couple of days.

joe

> 
> * To reproduce the issue:
> 1) apply attached patch: force-to-reload-translations.patch
> 2) build mcstransd and replace the one: "/sbin/mcstransd"
> 3) start the daemon and check results:
> 
>  $ run_init /etc/init.d/mcstrans start
>  $ id -Z
>  staff_u:lspp_test_r:lspp_harness_t:s0-s15:c0.c1023
> 
>  $ ps aux|grep mcs
>  root      3004  0.0  0.0  14884   668 ?        Ss   09:37   0:00 mcstransd
>  root      3116  0.0  0.0 103252   832 pts/1    S+   10:39   0:00 grep mcs
> 
>  $ grep mcs /var/log/messages
>  Jul 17 09:37:05 localhost mcstransd: mcstransd starting
>  Jul 17 09:37:05 localhost mcstransd: Failed to initialize color translations
>  Jul 17 09:37:05 localhost mcstransd: No color information will be available
>  Jul 17 09:37:05 localhost mcstransd: mcstransd initialized
>  Jul 17 09:37:05 localhost mcstransd: Reload Translations
>  Jul 17 09:37:05 localhost mcstransd: cache sizes: tr = 26, rt = 26
>  Jul 17 09:37:05 localhost mcstransd: Failed to initialize color translations
>  Jul 17 09:37:05 localhost mcstransd: No color information will be available
> 
> I tested this on CentOS 6.5 with mls policy enabled.
> 
> * Why does it fail?
> 
> Check process_trans() in mcstrans.c:
> 
> 723 process_trans(char *buffer) {
> 724         static domain_t *domain;
> [snip] ...
> 784         if (!domain) {
> 785                 domain = create_domain("Default");
> 786                 if (!domain)
> 787                         return -1;
> 788                 group = NULL;
> 789         }
> 
> As I think, the static pointer "domain" will be initialized when the daemon is starting, it will work well if that's all; But if "restart daemon" triggered after that, the point "domain" will have an old value but not NULL, this will prevent the create_domain() from running. In this case, an empty "domains" causes the translation failed.
> 
> I have a workaround to get it works: workaround-for-mcstransd.patch, but it's a bit ugly, I hope someone could give a better fix for it:)
> 
> Thanks
> Wenzong
> <force-to-reload-translations.patch><workaround-for-mcstransd.patch>_______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
