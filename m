Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GKvWuh005314
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 15:57:32 -0500
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GKvVvO007575
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 20:57:31 GMT
Subject: Re: [PATCH 08/10] selinux: Fix handling of kernel generated
 packets on labeled IPsec
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214132157.GI15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214132157.GI15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 15:57:27 -0500
Message-ID: <1297889847.25079.44.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:21 +0100, Steffen Klassert wrote:
> As it is, we require the security context of a labeled SA to be the
> same as the security context of the originating flow. On a nontrivial
> selinux policy the security context of the flow of kernel generated
> packets, like echo reply packets, are usually not equal to the
> security context of the labeled SA. So it is not possible to send
> such packets in this case. The fact that the security context of a
> labeled SA must be the same as the security context of the originating
> flow can also lead to problems if an outgoing SA is used for packet
> forwarding and for locally generated traffic.
> 
> This patch fixes this by removing this equality check. Instead we
> ask the access vector cache if the security context of the SA is
> compatible to the security context of the IPsec policy. This
> partially reverts commit 67f83cbf081a70426ff667e8d14f94e13ed3bdca
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

I think understand the problem you're running up against, and if I'm
understanding it correctly it is an inherent problem with the labeled
IPsec design - not something that we can fix.

The core issue is that with labeled IPsec the packets themselves are not
labeled, the SAs are labeled instead.  This means that in order to
accurately convey peer labels over the network you need to ensure that
the flow's label matches the SA label; this is why there is a direct SID
to SID comparison in the code.  Failing to match a flow to the
associated SA will result in data being mis/relabeled which is a big
no-no.

> ---
>  security/selinux/xfrm.c |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 17ad37b..05e1c1c 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -116,6 +116,7 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
>  			struct flowi *fl)
>  {
>  	u32 state_sid;
> +	u32 pol_sid;
>  	int rc;
>  
>  	if (!xp->security)
> @@ -135,20 +136,16 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
>  				return 0;
>  
>  	state_sid = x->security->ctx_sid;
> +	pol_sid = xp->security->ctx_sid;
>  
> -	if (fl->secid != state_sid)
> +	rc = avc_has_perm(state_sid, pol_sid, SECCLASS_ASSOCIATION,
> +			  ASSOCIATION__POLMATCH, NULL)? 0:1;
> +
> +	if (!rc)
>  		return 0;
>  
>  	rc = avc_has_perm(fl->secid, state_sid, SECCLASS_ASSOCIATION,
> -			  ASSOCIATION__SENDTO,
> -			  NULL)? 0:1;
> -
> -	/*
> -	 * We don't need a separate SA Vs. policy polmatch check
> -	 * since the SA is now of the same label as the flow and
> -	 * a flow Vs. policy polmatch check had already happened
> -	 * in selinux_xfrm_policy_lookup() above.
> -	 */
> +			  ASSOCIATION__SENDTO, NULL)? 0:1;
>  
>  	return rc;
>  }

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
