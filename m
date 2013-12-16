Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rBGKxWUW016119
	for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2013 15:59:33 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so4352480qeb.7
        for <selinux@tycho.nsa.gov>; Mon, 16 Dec 2013 12:59:31 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: sds@tycho.nsa.gov, james.l.morris@oracle.com, eparis@parisplace.org,
        yongjun_wei@trendmicro.com.cn, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH -next] SELinux: remove duplicated include from hooks.c
Date: Mon, 16 Dec 2013 15:59:27 -0500
Message-ID: <2355492.3Xh2eE7mBi@sifl>
In-Reply-To: <CAPgLHd9RPS63ghK_ABTr57zdDqrg0EbceLUM3RHUJ+o5GQBNOQ@mail.gmail.com>
References: <CAPgLHd9RPS63ghK_ABTr57zdDqrg0EbceLUM3RHUJ+o5GQBNOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, December 16, 2013 02:15:40 PM Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  security/selinux/hooks.c | 1 -
>  1 file changed, 1 deletion(-)

Applied, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d0aa173..d7bb6f1 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -81,7 +81,6 @@
>  #include <linux/syslog.h>
>  #include <linux/user_namespace.h>
>  #include <linux/export.h>
> -#include <linux/security.h>
>  #include <linux/msg.h>
>  #include <linux/shm.h>

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
