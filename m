Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GL0t8w005589
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 16:00:55 -0500
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GL0sMK001690
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 21:00:55 GMT
Subject: [Fwd: Re: [PATCH 09/10] selinux: xfrm - notify users on dropped
 packets]
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 16:00:52 -0500
Message-ID: <1297890052.25079.47.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ooops, forgot the CC the SELinux list.

-------- Forwarded Message --------
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org
Subject: Re: [PATCH 09/10] selinux: xfrm - notify users on dropped
packets
Date: Wed, 16 Feb 2011 15:59:51 -0500

On Mon, 2011-02-14 at 14:22 +0100, Steffen Klassert wrote:
> In selinux_xfrm_state_pol_flow_match we have cases where we drop
> packets without asking the avc. No audit message is generated in
> this case. Lets at least print out a message to the logs, so the
> users don't need to dig in the code to find out why these packets
> are dropped.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

I might remove the exclamation points from the error messages, but
otherwise nice addition.

Acked-by: Paul Moore <paul.moore@hp.com>

> ---
>  security/selinux/xfrm.c |   24 ++++++++++++++++--------
>  1 files changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 05e1c1c..6d85c17 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -120,20 +120,28 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
>  	int rc;
>  
>  	if (!xp->security)
> -		if (x->security)
> -			/* unlabeled policy and labeled SA can't match */
> +		if (x->security) {
> +			if (net_ratelimit())
> +				printk("selinux: unlabeled policy and labeled"
> +				       "SA can't match!\n");
>  			return 0;
> -		else
> +		} else
>  			/* unlabeled policy and unlabeled SA match all flows */
>  			return 1;
>  	else
> -		if (!x->security)
> -			/* unlabeled SA and labeled policy can't match */
> +		if (!x->security) {
> +			if (net_ratelimit())
> +				printk("selinux: unlabeled SA and labeled"
> +				       "policy can't match!\n");
>  			return 0;
> -		else
> -			if (!selinux_authorizable_xfrm(x))
> -				/* Not a SELinux-labeled SA */
> +		} else {
> +			if (!selinux_authorizable_xfrm(x)) {
> +				if (net_ratelimit())
> +					printk("selinux: Not a"
> +					       "SELinux-labeled SA!\n");
>  				return 0;
> +			}
> +		}
>  
>  	state_sid = x->security->ctx_sid;
>  	pol_sid = xp->security->ctx_sid;

-- 
paul moore
linux @ hp


-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
