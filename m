Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6QFvZFA029768
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 11:57:35 -0400
Message-ID: <501168EA.8070906@circletech.net>
Date: Thu, 26 Jul 2012 17:57:30 +0200
From: =?UTF-8?B?TWljaGFsIE1hxaFlaw==?= <michal.masek@circletech.net>
MIME-Version: 1.0
To: William Roberts <bill.c.roberts@gmail.com>
CC: selinux@tycho.nsa.gov, William Roberts <w.roberts@sta.samsung.com>
Subject: Re: [PATCH] Support older compilers by wrapping smc .arch
References: <1343248695-32278-1-git-send-email-w.roberts@sta.samsung.com> <1343248695-32278-2-git-send-email-w.roberts@sta.samsung.com>
In-Reply-To: <1343248695-32278-2-git-send-email-w.roberts@sta.samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/25/2012 10:38 PM, William Roberts wrote:
> From: William Roberts <bill.c.roberts@gmail.com>
> 
> Fixes build bug
> security/smc/bridge_pub2sec.S:95: Error: selected processor does not support ARM mode `smc #0'
> 
> Signed-off-by: William Roberts <w.roberts@sta.samsung.com>
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

Should the ".arch_extension sec" line be present when compiling with
some future compiler (eg. 5.1)? If so then this condition is not correct
because it will not be met if the major number is greater than 4 and
minor number is lower than 6 (eg. version 5.1). I do not know the proper
syntax but the condition should look something like this:

#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)

> +        .arch_extension sec
> +#endif
>  	INVALIDATE_BTB
>  	dsb
>  	dmb

--
Michal Mašek


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
