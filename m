Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1NEuvnw007660
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 09:56:57 -0500
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1NEuuNH028818
	for <selinux@tycho.nsa.gov>; Wed, 23 Feb 2011 14:56:56 GMT
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH 4/4] selinux: xfrm - notify users on dropped packets
Date: Wed, 23 Feb 2011 09:56:52 -0500
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>,
        linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
References: <20110223115343.GH20852@secunet.com> <20110223115715.GL20852@secunet.com>
In-Reply-To: <20110223115715.GL20852@secunet.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201102230956.53069.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday, February 23, 2011 6:57:15 AM Steffen Klassert wrote:
> In selinux_xfrm_state_pol_flow_match we have cases where we drop
> packets without asking the avc. No audit message is generated in
> this case. Lets at least print out a message to the logs, so the
> users don't need to dig in the code to find out why these packets
> are dropped.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> Acked-by: Paul Moore <paul.moore@hp.com>
> ---
> 
> Paul,
> 
> I removed the exclamation marks and  I changed this one
> to print a message too if the flow label does not match the SA label.
> I kept your ACK on this one, I hope it is ok.
> If not please complain.

I still see the exclamation marks in the patch below; perhaps you sent the 
wrong version by mistake?

Also, as far as keeping ACKs on modified patches, I think it is okay as long 
as you are just porting a patch, e.g. minor changes necessary so that the 
patch applies to the current stable kernel.  If you have to do anything 
beyond that, I would appreciate it if you could drop my ACK; I don't have a 
problem with re-reviewing patches and re-ACKing them if they look okay.

>  security/selinux/xfrm.c |   26 +++++++++++++++++---------
>  1 files changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 728c57e..0062613 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -118,25 +118,33 @@ int selinux_xfrm_state_pol_flow_match(struct
> xfrm_state *x, struct xfrm_policy * int rc;
> 
>  	if (!xp->security)
> -		if (x->security)
> -			/* unlabeled policy and labeled SA can't match */
> +		if (x->security) {
> +			if (net_ratelimit())
> +				printk("selinux: unlabeled policy and labeled SA can't 
match!\n");
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
> +				printk("selinux: unlabeled SA and labeled policy can't 
match!\n");
>  			return 0;
> -		else
> -			if (!selinux_authorizable_xfrm(x))
> -				/* Not a SELinux-labeled SA */
> +		} else {
> +			if (!selinux_authorizable_xfrm(x)) {
> +				if (net_ratelimit())
> +					printk("selinux: Not a SELinux-labeled SA!\n");
>  				return 0;
> +			}
> +		}
> 
>  	state_sid = x->security->ctx_sid;
> 
> -	if (fl->secid != state_sid)
> +	if (fl->secid != state_sid) {
> +		if (net_ratelimit())
> +			printk("selinux: Flow label does not match SA label!\n");
>  		return 0;
> +	}
> 
>  	rc = avc_has_perm(fl->secid, state_sid, SECCLASS_ASSOCIATION,
>  			  ASSOCIATION__SENDTO,


--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
