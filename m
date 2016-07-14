Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6EGHxa6012649
 for <selinux@tycho.nsa.gov>; Thu, 14 Jul 2016 12:17:59 -0400
Subject: Re: [PATCH] security: Use IS_ENABLED() instead of checking for
 built-in or module
To: Javier Martinez Canillas <javier@osg.samsung.com>,
 linux-kernel@vger.kernel.org
References: <1468512050-26272-1-git-send-email-javier@osg.samsung.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, Paul Moore <paul@paul-moore.com>,
 linux-security-module@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, selinux@tycho.nsa.gov,
 James Morris <james.l.morris@oracle.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <adc7dca8-9685-c9f0-7d61-d3537963cf6f@schaufler-ca.com>
Date: Thu, 14 Jul 2016 09:17:27 -0700
MIME-Version: 1.0
In-Reply-To: <1468512050-26272-1-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

On 7/14/2016 9:00 AM, Javier Martinez Canillas wrote:
> The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
> built-in or as a module, use that macro instead of open coding the same.

Why?

>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
>
>  security/lsm_audit.c             |  2 +-
>  security/selinux/hooks.c         | 12 ++++++------
>  security/smack/smack_netfilter.c |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/security/lsm_audit.c b/security/lsm_audit.c
> index cccbf3068cdc..5369036cf905 100644
> --- a/security/lsm_audit.c
> +++ b/security/lsm_audit.c
> @@ -99,7 +99,7 @@ int ipv4_skb_to_auditdata(struct sk_buff *skb,
>  	}
>  	return ret;
>  }
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  /**
>   * ipv6_skb_to_auditdata : fill auditdata from skb
>   * @skb : the skb
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ec30880c4b98..c20ea9fe9274 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3984,7 +3984,7 @@ out:
>  	return ret;
>  }
>  
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  
>  /* Returns error only if unable to parse addresses */
>  static int selinux_parse_skb_ipv6(struct sk_buff *skb,
> @@ -4075,7 +4075,7 @@ static int selinux_parse_skb(struct sk_buff *skb, struct common_audit_data *ad,
>  				       &ad->u.net->v4info.daddr);
>  		goto okay;
>  
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  	case PF_INET6:
>  		ret = selinux_parse_skb_ipv6(skb, ad, proto);
>  		if (ret)
> @@ -5029,7 +5029,7 @@ static unsigned int selinux_ipv4_forward(void *priv,
>  	return selinux_ip_forward(skb, state->in, PF_INET);
>  }
>  
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  static unsigned int selinux_ipv6_forward(void *priv,
>  					 struct sk_buff *skb,
>  					 const struct nf_hook_state *state)
> @@ -5087,7 +5087,7 @@ static unsigned int selinux_ipv4_output(void *priv,
>  	return selinux_ip_output(skb, PF_INET);
>  }
>  
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  static unsigned int selinux_ipv6_output(void *priv,
>  					struct sk_buff *skb,
>  					const struct nf_hook_state *state)
> @@ -5273,7 +5273,7 @@ static unsigned int selinux_ipv4_postroute(void *priv,
>  	return selinux_ip_postroute(skb, state->out, PF_INET);
>  }
>  
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  static unsigned int selinux_ipv6_postroute(void *priv,
>  					   struct sk_buff *skb,
>  					   const struct nf_hook_state *state)
> @@ -6317,7 +6317,7 @@ static struct nf_hook_ops selinux_nf_ops[] = {
>  		.hooknum =	NF_INET_LOCAL_OUT,
>  		.priority =	NF_IP_PRI_SELINUX_FIRST,
>  	},
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  	{
>  		.hook =		selinux_ipv6_postroute,
>  		.pf =		NFPROTO_IPV6,
> diff --git a/security/smack/smack_netfilter.c b/security/smack/smack_netfilter.c
> index aa6bf1b22ec5..205b785fb400 100644
> --- a/security/smack/smack_netfilter.c
> +++ b/security/smack/smack_netfilter.c
> @@ -20,7 +20,7 @@
>  #include <net/inet_sock.h>
>  #include "smack.h"
>  
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  
>  static unsigned int smack_ipv6_output(void *priv,
>  					struct sk_buff *skb,
> @@ -64,7 +64,7 @@ static struct nf_hook_ops smack_nf_ops[] = {
>  		.hooknum =	NF_INET_LOCAL_OUT,
>  		.priority =	NF_IP_PRI_SELINUX_FIRST,
>  	},
> -#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +#if IS_ENABLED(CONFIG_IPV6)
>  	{
>  		.hook =		smack_ipv6_output,
>  		.pf =		NFPROTO_IPV6,
