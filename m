From: Paul Moore <paul.moore@hp.com>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Subject: Re: [PATCH 7/7] secid reconciliation-v02: Enforcement for SELinux
Date: Mon, 18 Sep 2006 18:26:47 -0400
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, jmorris@namei.org,
        sds@tycho.nsa.gov, chanson@TrustedCS.com
References: <45019F72.2050708@trustedcs.com>
In-Reply-To: <45019F72.2050708@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609181826.47622.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 September 2006 12:50 pm, Venkat Yekkirala wrote:
> This defines SELinux enforcement of the 2 new LSM hooks.

{snip}

> +static int selinux_skb_policy_check(struct sk_buff *skb, unsigned short
> family) +{
> +	u32 xfrm_sid, trans_sid;
> +	int err;
> +
> +	if (selinux_compat_net)
> +		return 1;
> +
> +	err = selinux_xfrm_decode_session(skb, &xfrm_sid, 0);
> +	BUG_ON(err);

First, any reason against including the "struct sock *" in the LSM hook?  At a 
quick glance it looks like it is available at each place 
security_skb_policy_check() is invoked?  If there are no objections I would 
like to see it included in the hook.

Second, I wonder if it would be better to do a NetLabel/CIPSO query here using 
the xfrm_sid as the NetLabel "base_sid" instead of at the end of the function 
(see your comment)?  This way we wouldn't have to duplicate the 
avc_has_perm() and security_transition_sid() calls for both xfrm and 
NetLabel.  It just seems to be more inline with the whole secid 
reconciliation concept.

I don't feel too strongly either way, I just thought it was worth exploring - 
thoughts?

> +	err = avc_has_perm(xfrm_sid, skb->secmark, SECCLASS_PACKET,
> +					PACKET__FLOW_IN, NULL);
> +	if (err)
> +		goto out;
> +
> +	if (xfrm_sid) {
> +		err = security_transition_sid(xfrm_sid, skb->secmark,
> +						SECCLASS_PACKET, &trans_sid);
> +		if (err)
> +			goto out;
> +
> +		skb->secmark = trans_sid;
> +	}
> +
> +	/* See if CIPSO can flow in thru the current secmark here */
> +
> +out:
> +	return err ? 0 : 1;
> +};

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
