Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8IIJvvh016744
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 14:19:57 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8IIJRuA028414
	for <selinux@tycho.nsa.gov>; Mon, 18 Sep 2006 18:19:27 GMT
Date: Mon, 18 Sep 2006 14:19:54 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        chanson@TrustedCS.com
Subject: Re: [PATCH 4/7] secid reconciliation-v02: Invoke LSM hook for outbound
 traffic
In-Reply-To: <45019F66.20603@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0609181418310.5976@d.namei>
References: <45019F66.20603@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 8 Sep 2006, Venkat Yekkirala wrote:

> @@ -114,6 +128,9 @@ static struct xt_target xt_connsecmark_t
> 		.target		= target,
> 		.targetsize	= sizeof(struct xt_connsecmark_target_info),
> 		.table		= "mangle",
> +		.hooks		= (1 << NF_IP_LOCAL_IN) |
> +				  (1 << NF_IP_FORWARD) |
> +				  (1 << NF_IP_POST_ROUTING),

Why have you added constraints on the hooks?

This breaks a bunch of things.


> @@ -123,6 +140,9 @@ static struct xt_target xt_connsecmark_t
> 		.target		= target,
> 		.targetsize	= sizeof(struct xt_connsecmark_target_info),
> 		.table		= "mangle",
> +		.hooks		= (1 << NF_IP6_LOCAL_IN) |
> +				  (1 << NF_IP6_FORWARD) |
> +				  (1 << NF_IP6_POST_ROUTING),
> 		.me		= THIS_MODULE,

Ditto...

> @@ -119,6 +129,9 @@ static struct xt_target xt_secmark_targe
> 		.target		= target,
> 		.targetsize	= sizeof(struct xt_secmark_target_info),
> 		.table		= "mangle",
> +		.hooks		= (1 << NF_IP_LOCAL_IN) |
> +				  (1 << NF_IP_FORWARD) |
> +				  (1 << NF_IP_POST_ROUTING),
> 		.me		= THIS_MODULE,
> 	},
> 	{
> @@ -128,6 +141,9 @@ static struct xt_target xt_secmark_targe
> 		.target		= target,
> 		.targetsize	= sizeof(struct xt_secmark_target_info),
> 		.table		= "mangle",
> +		.hooks		= (1 << NF_IP6_LOCAL_IN) |
> +				  (1 << NF_IP6_FORWARD) |
> +				  (1 << NF_IP6_POST_ROUTING),
> 		.me		= THIS_MODULE,
> 	},
> };
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
