Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3PLLwH5024565
 for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2017 17:21:59 -0400
Received: by mail-vk0-f67.google.com with SMTP id j135so8575447vka.2
 for <selinux@tycho.nsa.gov>; Tue, 25 Apr 2017 14:21:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170423005311.GA29693@hackers.mu>
References: <20170423005311.GA29693@hackers.mu>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 25 Apr 2017 17:21:56 -0400
Message-ID: <CAHC9VhQy7bCtB3CZLiKsbrkmRoyPY=nbo+6EjGJEoBwW3oKzmw@mail.gmail.com>
Subject: Re: [PATCH] security: hooks : Prevent security to persist in memory
 (PR #31)
To: Pirabarlen-Cheenaramen <selven@hackers.mu>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Apr 22, 2017 at 8:53 PM, Pirabarlen-Cheenaramen
<selven@hackers.mu> wrote:
> Signed-off-by: Pirabarlen-Cheenaramen <selven@hackers.mu>
> ---
>  security/selinux/hooks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d98550a..9f82908 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4944,7 +4944,7 @@ static int selinux_tun_dev_alloc_security(void **security)
>
>  static void selinux_tun_dev_free_security(void *security)
>  {
> -       kfree(security);
> +       kzfree(security);

As a general rule we don't zero out memory before free'ing it, you
need to provide some additional information as to why this is required
here.

>  }
>
>  static int selinux_tun_dev_create(void)
> --
> 1.9.1

-- 
paul moore
www.paul-moore.com
