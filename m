Message-ID: <1343317040.5186.10.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Support older compilers by wrapping smc .arch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Thu, 26 Jul 2012 11:37:20 -0400
In-Reply-To: <1343248695-32278-2-git-send-email-w.roberts@sta.samsung.com>
References: <1343248695-32278-1-git-send-email-w.roberts@sta.samsung.com>
	 <1343248695-32278-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2012-07-25 at 13:38 -0700, William Roberts wrote:
> From: William Roberts <bill.c.roberts@gmail.com>
> 
> Fixes build bug
> security/smc/bridge_pub2sec.S:95: Error: selected processor does not support ARM mode `smc #0'
> 
> Signed-off-by: William Roberts <w.roberts@sta.samsung.com>

Thanks, applied.

> ---
>  security/smc/bridge_pub2sec.S |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/security/smc/bridge_pub2sec.S b/security/smc/bridge_pub2sec.S
> index 30b8b35..e433380 100644
> --- a/security/smc/bridge_pub2sec.S
> +++ b/security/smc/bridge_pub2sec.S
> @@ -74,7 +74,9 @@ return_from_irq:
>  	b	label_smc
>  
>  label_smc:
> -	.arch_extension sec
> +#if __GNUC__ >= 4 && __GNUC_MINOR__ >= 6
> +        .arch_extension sec
> +#endif
>  	INVALIDATE_BTB
>  	dsb
>  	dmb

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
