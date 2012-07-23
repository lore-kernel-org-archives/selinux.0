Message-ID: <1343053454.23118.44.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] Fix for build error no support ARM mode `smc #0'
From: Stephen Smalley <sds@tycho.nsa.gov>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Date: Mon, 23 Jul 2012 10:24:14 -0400
In-Reply-To: <1342762183-22189-2-git-send-email-w.roberts@sta.samsung.com>
References: <1342762183-22189-1-git-send-email-w.roberts@sta.samsung.com>
	 <1342762183-22189-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 22:29 -0700, William Roberts wrote:
> Fixes build bug
> security/smc/bridge_pub2sec.S:95: Error: selected processor does not support ARM mode `smc #0'
> ---
>  security/smc/bridge_pub2sec.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/security/smc/bridge_pub2sec.S b/security/smc/bridge_pub2sec.S
> index 15cd3b7..30b8b35 100644
> --- a/security/smc/bridge_pub2sec.S
> +++ b/security/smc/bridge_pub2sec.S
> @@ -74,6 +74,7 @@ return_from_irq:
>  	b	label_smc
>  
>  label_smc:
> +	.arch_extension sec
>  	INVALIDATE_BTB
>  	dsb
>  	dmb

Thanks, but this should go to AOSP, not us.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
