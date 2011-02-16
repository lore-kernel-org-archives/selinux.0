Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p1GKBhig002032
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 15:11:43 -0500
Received: from g1t0027.austin.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p1GKBSMK017365
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2011 20:11:28 GMT
Subject: Re: [PATCH 05/10] selinux: selinux_xfrm_decode_session check for
 socket sid
From: Paul Moore <paul.moore@hp.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
In-Reply-To: <20110214132009.GF15640@secunet.com>
References: <20110214131651.GA15640@secunet.com>
	 <20110214132009.GF15640@secunet.com>
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 16 Feb 2011 15:11:25 -0500
Message-ID: <1297887085.25079.24.camel@sifl>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-02-14 at 14:20 +0100, Steffen Klassert wrote:
> selinux_xfrm_decode_session is used to decode the security identifyer
> of the originating flow. So return the sid of the socket instead of
> SECSID_NULL, if we have socket context but no secpath. This is
> needed because ip_xfrm_me_harder (and selinux_xfrm_decode_session)
> is invoked on outbound packets and before the xfrm transformations,
> therefore we have no secpath and the sid of a labeled IPsec SA usually
> does not match SECSID_NULL.
> 
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

Granted, it has been some time since I've looked at the labeled IPsec
code in some detail so I might be a little off here, but is it possible
to move the xfrm_decode LSM hook to an area on the outbound processing
where we do have a valid secpath?  If not, I'd rather see us split this
hook so that we preserve the existing xfrm_decode_session() hook for
input (I believe it is also used for input, yes?) and create a new hook
which only grabs the sksec's label on output (preferably named so that
it is clear this is the socket's label and not the SA's label).

> ---
>  security/selinux/xfrm.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/security/selinux/xfrm.c b/security/selinux/xfrm.c
> index 62f3b26..e990c39 100644
> --- a/security/selinux/xfrm.c
> +++ b/security/selinux/xfrm.c
> @@ -160,6 +160,7 @@ int selinux_xfrm_state_pol_flow_match(struct xfrm_state *x, struct xfrm_policy *
>  int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
>  {
>  	struct sec_path *sp;
> +	struct sock *sk;
>  
>  	*sid = SECSID_NULL;
>  
> @@ -167,6 +168,8 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
>  		return 0;
>  
>  	sp = skb->sp;
> +	sk = skb->sk;
> +
>  	if (sp) {
>  		int i, sid_set = 0;
>  
> @@ -185,6 +188,9 @@ int selinux_xfrm_decode_session(struct sk_buff *skb, u32 *sid, int ckall)
>  					return -EINVAL;
>  			}
>  		}
> +	} else if (sk) {
> +		struct sk_security_struct *sksec = sk->sk_security;
> +		*sid = sksec->sid;
>  	}
>  
>  	return 0;

-- 
paul moore
linux @ hp



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
