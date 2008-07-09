From: Paul Moore <paul.moore@hp.com>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] Fix a potentially uninitialised variable in SELinux hooks
Date: Wed, 9 Jul 2008 18:21:46 -0400
Cc: sds@tycho.nsa.gov, jmorris@namei.org, selinux@tycho.nsa.gov
References: <20080709161043.24255.62312.stgit@warthog.procyon.org.uk>
In-Reply-To: <20080709161043.24255.62312.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200807091821.46296.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 09 July 2008 12:10:43 pm David Howells wrote:
> Fix a potentially uninitialised variable in SELinux hooks that's
> given a pointer to the network address by selinux_parse_skb() passing
> a pointer back through its argument list.  By restructuring
> selinux_parse_skb(), the compiler can see that the error case need
> not set it as the caller will return immediately.

Looking at all the callers of selinux_parse_skb() none of them actually 
pass a NULL value for addrp, which I believe is the only reason for 
conditionally setting the value of addrp in selinux_parse_skb().  I 
think a cleaner fix is to simply remove the conditional assignment so 
we have something that looks like this ...

	ret = selinux_parse_skb_ipv4(...);
	if (ret != 0)
		break;
	*addrp = (char *)(src ? ...);

I haven't checked but I'm pretty sure that would fix the problem you are 
seeing, yes?

> Signed-off-by: David Howells <dhowells@redhat.com>
> ---
>
>  security/selinux/hooks.c |   42
> ++++++++++++++++++++++++------------------ 1 files changed, 24
> insertions(+), 18 deletions(-)
>
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 85f74f6..3c87c59 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -3513,38 +3513,44 @@ out:
>  #endif /* IPV6 */
>
>  static int selinux_parse_skb(struct sk_buff *skb, struct
> avc_audit_data *ad, -			     char **addrp, int src, u8 *proto)
> +			     char **_addrp, int src, u8 *proto)
>  {
> -	int ret = 0;
> +	char *addrp;
> +	int ret;
>
>  	switch (ad->u.net.family) {
>  	case PF_INET:
>  		ret = selinux_parse_skb_ipv4(skb, ad, proto);
> -		if (ret || !addrp)
> -			break;
> -		*addrp = (char *)(src ? &ad->u.net.v4info.saddr :
> -					&ad->u.net.v4info.daddr);
> -		break;
> +		if (ret)
> +			goto parse_error;
> +		addrp = (char *)(src ? &ad->u.net.v4info.saddr :
> +				       &ad->u.net.v4info.daddr);
> +		goto okay;
>
>  #if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
>  	case PF_INET6:
>  		ret = selinux_parse_skb_ipv6(skb, ad, proto);
> -		if (ret || !addrp)
> -			break;
> -		*addrp = (char *)(src ? &ad->u.net.v6info.saddr :
> -					&ad->u.net.v6info.daddr);
> -		break;
> +		if (ret)
> +			goto parse_error;
> +		addrp = (char *)(src ? &ad->u.net.v6info.saddr :
> +				       &ad->u.net.v6info.daddr);
> +		goto okay;
>  #endif	/* IPV6 */
>  	default:
> -		break;
> +		addrp = NULL;
> +		goto okay;
>  	}
>
> -	if (unlikely(ret))
> -		printk(KERN_WARNING
> -		       "SELinux: failure in selinux_parse_skb(),"
> -		       " unable to parse packet\n");
> -
> +parse_error:
> +	printk(KERN_WARNING
> +	       "SELinux: failure in selinux_parse_skb(),"
> +	       " unable to parse packet\n");
>  	return ret;
> +
> +okay:
> +	if (_addrp)
> +		*_addrp = addrp;
> +	return 0;
>  }
>
>  /**
>
>
> --
> This message was distributed to subscribers of the selinux mailing
> list. If you no longer wish to subscribe, send mail to
> majordomo@tycho.nsa.gov with the words "unsubscribe selinux" without
> quotes as the message.



-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
