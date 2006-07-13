Message-ID: <36282A1733C57546BE392885C06185920138E0F0@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: James Morris <jmorris@namei.org>
Cc: netdev@vger.kernel.org, sds@tycho.nsa.gov, tjaeger@cse.psu.edu,
        selinux@tycho.nsa.gov
Subject: RE: [PATCH 08/10] MLSXFRM: Add security context to acquire messag
	es using PF_KEY
Date: Thu, 13 Jul 2006 10:54:14 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > +static inline void security_xfrm_skb_secid(struct sk_buff 
> *skb, u32 *secid)
> > {
> > -	return security_ops->xfrm_decode_session(skb, fl);
> > +	BUG_ON(security_ops->xfrm_decode_session(skb, secid, 0));
> > 
> 
> BUG_ON looks wrong here, in that you don't know why the LSM 
> returned an 
> error, and why should the box panic at this point at all?

This hook must not fail when the ckall parameter is set to zero,
which is what the BUG_ON is asserting. I see I didn't comment
the hook def in security.h to this effect; will correct this. Thanks.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
