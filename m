Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GKWjJu003553
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 15:32:45 -0500
Received: from g1t0029.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GKWhMK023743
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 20:32:44 GMT
Subject: Re: [PATCH 07/10] selinux: Check receiving against sending
 interface on packet forwarding
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214132122.GH15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214132122.GH15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 15:32:40 -0500
Message-ID: <1297888360.25079.35.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:21 +0100, Steffen Klassert wrote:
> As it is, it is not possible to check in the forwarding and
> the postrouting hook whether a packet that is received via some
> network interface is allowed to be forwarded via some other network
> interface. With this patch we decode the security identifier on
> selinux_xfrm_decode_session to the sid of the incoming interface,
> if we have neither a secpath nor socket context, so this check is
> possible now. Also set the sid to SECINITSID_KERNEL if we have none
> of secpath, socket context and incoming interface as the packet
> must be kernel generated in this case.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

If you want to control which interface is allowed to forward to which
other interface, you should use good ol' iptables, not SELinux.

The SELinux peer label network access controls allow you to restrict the
following:

* Which peers are allowed to enter the system via specific networks and
interfaces
* Which peers are allowed to forward traffic matching a specific inbound
iptables rule (requires Secmark configuration)
* Which peers are allowed to forward traffic matching a specific
outbound iptables rule (requires Secmark configuration)
* Which peers are allowed to leave the system via specific networks and
interfaces

> ---
>  security/selinux/xfrm.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index e990c39..17ad37b 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -51,6 +51,7 @@
>  #include "avc.h"
>  #include "objsec.h"
>  #include "xfrm.h"
> +#include "netif.h"
>  
>  /* Labeled XFRM instance counter */
>  atomic_t selinux_xfrm_refcount = ATOMIC_INIT(0);
> @@ -162,7 +163,7 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
>  	struct sec_path *sp;
>  	struct sock *sk;
>  
> -	*sid = SECSID_NULL;
> +	*sid = SECINITSID_KERNEL;
>  
>  	if (skb == NULL)
>  		return 0;
> @@ -188,11 +189,20 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
>  					return -EINVAL;
>  			}
>  		}
> -	} else if (sk) {
> +
> +		return 0;
> +	}
> +
> +	if (sk) {
>  		struct sk_security_struct *sksec = sk->sk_security;
>  		*sid = sksec->sid;
> +
> +		return 0;
>  	}
>  
> +	if (selinux_policycap_netpeer && skb->skb_iif)
> +		return sel_netif_sid(skb->skb_iif, sid);
> +
>  	return 0;
>  }
>  

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
