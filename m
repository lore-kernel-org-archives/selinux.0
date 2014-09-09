Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s890nSL2027168
 for <selinux@tycho.nsa.gov>; Mon, 8 Sep 2014 20:49:30 -0400
Received: by mail-qc0-f170.google.com with SMTP id r5so16603358qcx.15
 for <selinux@tycho.nsa.gov>; Mon, 08 Sep 2014 17:49:33 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: Jiri Pirko <jiri@resnulli.us>
Subject: Re: [patch] selinux: register nf hooks with single nf_register_hooks
 call
Date: Mon, 08 Sep 2014 20:49:29 -0400
Message-ID: <1946467.xFbgoZ3iyq@sifl>
In-Reply-To: <1409758933-16882-1-git-send-email-jiri@resnulli.us>
References: <1409758933-16882-1-git-send-email-jiri@resnulli.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: james.l.morris@oracle.com, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, sds@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wednesday, September 03, 2014 05:42:13 PM Jiri Pirko wrote:
> Push ipv4 and ipv6 nf hooks into single array and register/unregister
> them via single call.
> 
> Signed-off-by: Jiri Pirko <jiri@resnulli.us>
> ---
>  security/selinux/hooks.c | 35 ++++++++++-------------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)

Applied, thanks.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index b0e9404..ed73809 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6035,7 +6035,7 @@ security_initcall(selinux_init);
> 
>  #if defined(CONFIG_NETFILTER)
> 
> -static struct nf_hook_ops selinux_ipv4_ops[] = {
> +static struct nf_hook_ops selinux_nf_ops[] = {
>  	{
>  		.hook =		selinux_ipv4_postroute,
>  		.owner =	THIS_MODULE,
> @@ -6056,12 +6056,8 @@ static struct nf_hook_ops selinux_ipv4_ops[] = {
>  		.pf =		NFPROTO_IPV4,
>  		.hooknum =	NF_INET_LOCAL_OUT,
>  		.priority =	NF_IP_PRI_SELINUX_FIRST,
> -	}
> -};
> -
> +	},
>  #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> -
> -static struct nf_hook_ops selinux_ipv6_ops[] = {
>  	{
>  		.hook =		selinux_ipv6_postroute,
>  		.owner =	THIS_MODULE,
> @@ -6075,32 +6071,24 @@ static struct nf_hook_ops selinux_ipv6_ops[] = {
>  		.pf =		NFPROTO_IPV6,
>  		.hooknum =	NF_INET_FORWARD,
>  		.priority =	NF_IP6_PRI_SELINUX_FIRST,
> -	}
> -};
> -
> +	},
>  #endif	/* IPV6 */
> +};
> 
>  static int __init selinux_nf_ip_init(void)
>  {
> -	int err = 0;
> +	int err;
> 
>  	if (!selinux_enabled)
> -		goto out;
> +		return 0;
> 
>  	printk(KERN_DEBUG "SELinux:  Registering netfilter hooks\n");
> 
> -	err = nf_register_hooks(selinux_ipv4_ops, ARRAY_SIZE(selinux_ipv4_ops));
> -	if (err)
> -		panic("SELinux: nf_register_hooks for IPv4: error %d\n", err);
> -
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> -	err = nf_register_hooks(selinux_ipv6_ops, ARRAY_SIZE(selinux_ipv6_ops));
> +	err = nf_register_hooks(selinux_nf_ops, ARRAY_SIZE(selinux_nf_ops));
>  	if (err)
> -		panic("SELinux: nf_register_hooks for IPv6: error %d\n", err);
> -#endif	/* IPV6 */
> +		panic("SELinux: nf_register_hooks: error %d\n", err);
> 
> -out:
> -	return err;
> +	return 0;
>  }
> 
>  __initcall(selinux_nf_ip_init);
> @@ -6110,10 +6098,7 @@ static void selinux_nf_ip_exit(void)
>  {
>  	printk(KERN_DEBUG "SELinux:  Unregistering netfilter hooks\n");
> 
> -	nf_unregister_hooks(selinux_ipv4_ops, ARRAY_SIZE(selinux_ipv4_ops));
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> -	nf_unregister_hooks(selinux_ipv6_ops, ARRAY_SIZE(selinux_ipv6_ops));
> -#endif	/* IPV6 */
> +	nf_unregister_hooks(selinux_nf_ops, ARRAY_SIZE(selinux_nf_ops));
>  }
>  #endif

-- 
paul moore
www.paul-moore.com
