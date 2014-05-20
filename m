Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s4KEtAWZ006557
 for <selinux@tycho.nsa.gov>; Tue, 20 May 2014 10:55:11 -0400
Received: by mail-qg0-f45.google.com with SMTP id z60so906136qgd.32
 for <selinux@tycho.nsa.gov>; Tue, 20 May 2014 07:55:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: zhangdianfang <zhangdianfang@huawei.com>
Subject: Re: [PATCH] =?UTF-8?B?c2VsaW51eO+8mmNsZWFudXA=?= redundant code in
 selinux_init()
Date: Tue, 20 May 2014 10:55:10 -0400
Message-ID: <10080497.EqJdIIVPn4@sifl>
In-Reply-To: <537B42A4.4070301@huawei.com>
References: <537B42A4.4070301@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, SELinux list <selinux@tycho.nsa.gov>,
 James Morris <james.l.morris@oracle.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tuesday, May 20, 2014 07:55:16 PM zhangdianfang wrote:
> Delete redundant if-condition code.
> 
> Signed-off-by: Zhang Dianfang <zhangdianfang@huawei.com>
> ---
>  security/selinux/hooks.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 2c7341d..70afb3a 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5967,10 +5967,6 @@ static __init int selinux_init(void)
>  {
>  	if (!security_module_enable(&selinux_ops)) {
>  		selinux_enabled = 0;
> -		return 0;
> -	}
> -
> -	if (!selinux_enabled) {
>  		printk(KERN_INFO "SELinux:  Disabled at boot.\n");
>  		return 0;
>  	}

NACK

We still need to check selinux_enabled if security_module_enable() returns 
true.

-- 
paul moore
www.paul-moore.com
