Subject: Re: [PATCH 1/2] SELinux: Only return netlink error when we know
 the return is fatal
From: Paul Moore <paul.moore@hp.com>
To: Eric Paris <eparis@redhat.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        davem@davemloft.net
In-Reply-To: <20101123162802.3588.74894.stgit@paris.rdu.redhat.com>
References: <20101123162802.3588.74894.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 23 Nov 2010 11:32:35 -0500
Message-ID: <1290529955.5359.20.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2010-11-23 at 11:28 -0500, Eric Paris wrote:
> Some of the SELinux netlink code returns a fatal error when the error might
> actually be transient.  This patch just silently drops packets on
> potentially transient errors but continues to return a permanant error
> indicator when the denial was because of policy.
> 
> Based-on-comments-by: Paul Moore <paul.moore@hp.com>
> Signed-off-by: Eric Paris <eparis@redhat.com>

Thanks for fixing this up.

Reviewed-by: Paul Moore <paul.moore@hp.com>

> ---
> 
>  security/selinux/hooks.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a0bc5c0..bd6dc16 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4594,7 +4594,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  		}
>  		if (secmark_perm == PACKET__FORWARD_OUT) {
>  			if (selinux_skb_peerlbl_sid(skb, family, &peer_sid))
> -				return NF_DROP_ERR(-ECONNREFUSED);
> +				return NF_DROP;
>  		} else
>  			peer_sid = SECINITSID_KERNEL;
>  	} else {
> @@ -4607,7 +4607,7 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  	ad.u.net.netif = ifindex;
>  	ad.u.net.family = family;
>  	if (selinux_parse_skb(skb, &ad, &addrp, 0, NULL))
> -		return NF_DROP_ERR(-ECONNREFUSED);
> +		return NF_DROP;
>  
>  	if (secmark_active)
>  		if (avc_has_perm(peer_sid, skb->secmark,
> @@ -4619,13 +4619,13 @@ static unsigned int selinux_ip_postroute(struct sk_buff *skb, int ifindex,
>  		u32 node_sid;
>  
>  		if (sel_netif_sid(ifindex, &if_sid))
> -			return NF_DROP_ERR(-ECONNREFUSED);
> +			return NF_DROP;
>  		if (avc_has_perm(peer_sid, if_sid,
>  				 SECCLASS_NETIF, NETIF__EGRESS, &ad))
>  			return NF_DROP_ERR(-ECONNREFUSED);
>  
>  		if (sel_netnode_sid(addrp, family, &node_sid))
> -			return NF_DROP_ERR(-ECONNREFUSED);
> +			return NF_DROP;
>  		if (avc_has_perm(peer_sid, node_sid,
>  				 SECCLASS_NODE, NODE__SENDTO, &ad))
>  			return NF_DROP_ERR(-ECONNREFUSED);
> 

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
