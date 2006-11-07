Subject: Re: [PATCH 1/3] mlsxfrm: Various fixes
From: Eric Paris <eparis@parisplace.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov
In-Reply-To: <4550BF91.6040906@trustedcs.com>
References: <4550BF91.6040906@trustedcs.com>
Content-Type: text/plain
Date: Tue, 07 Nov 2006 14:09:43 -0500
Message-Id: <1162926583.3268.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-11-07 at 11:17 -0600, Venkat Yekkirala wrote:
>  int selinux_xfrm_policy_alloc(struct xfrm_policy *xp,
> -		struct xfrm_user_sec_ctx *uctx, struct sock *sk)
> +		struct xfrm_user_sec_ctx *uctx)
>  {
>  	int err;
> -	u32 sid;
>  
> -	BUG_ON(!xp);
> -	BUG_ON(uctx && sk);
> -
> -	if (sk) {
> -		struct sk_security_struct *ssec = sk->sk_security;
> -		sid = ssec->sid;
> -	}
> -	else
> -		sid = SECSID_NULL;
> +	BUG_ON(!xp || !uctx);
>  
> -	err = selinux_xfrm_sec_ctx_alloc(&xp->security, uctx, NULL, sid);
> +	err = selinux_xfrm_sec_ctx_alloc(&xp->security, uctx, 0);
>  	return err;
>  }

BUG_ON() with an || makes this a slight bit trickier to debug if
something goes wrong.  I'd have to dig around a little in the assembly
and look at the registers in the back trace to know which of the 2 was
the problem.  I personally would rather have a seperate

BUG_ON(!xp);
BUG_ON(!uctx);

probably not worth resubmitting, but if you have to make another set of
these....

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
