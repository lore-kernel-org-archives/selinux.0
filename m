Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6DFIbDg009406
	for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2006 11:18:37 -0400
Received: from mail7.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6DFIZ1A003566
	for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2006 15:18:35 GMT
Date: Thu, 13 Jul 2006 11:18:32 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, sds@tycho.nsa.gov, tjaeger@cse.psu.edu,
        selinux@tycho.nsa.gov
Subject: RE: [PATCH 08/10] MLSXFRM: Add security context to acquire messag
 es using PF_KEY
In-Reply-To: <36282A1733C57546BE392885C06185920138E0F0@chaos.tcs.tcs-sec.com>
Message-ID: <Pine.LNX.4.64.0607131115130.6169@d.namei>
References: <36282A1733C57546BE392885C06185920138E0F0@chaos.tcs.tcs-sec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Jul 2006, Venkat Yekkirala wrote:

> > > +static inline void security_xfrm_skb_secid(struct sk_buff 
> > *skb, u32 *secid)
> > > {
> > > -	return security_ops->xfrm_decode_session(skb, fl);
> > > +	BUG_ON(security_ops->xfrm_decode_session(skb, secid, 0));
> > > 
> > 
> > BUG_ON looks wrong here, in that you don't know why the LSM 
> > returned an 
> > error, and why should the box panic at this point at all?
> 
> This hook must not fail when the ckall parameter is set to zero,
> which is what the BUG_ON is asserting. I see I didn't comment
> the hook def in security.h to this effect; will correct this. Thanks.

I'd suggest assigning the return value to a variable and asserting that, 
in case defines BUG_ON to nothing and the function won't be called.  Not 
sure what kernel policy is on this (ISTR people used to worry about it), 
but it's better not to take uncecessary chances.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
