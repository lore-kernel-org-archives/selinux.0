Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6D1r2bA030536
	for <selinux@tycho.nsa.gov>; Wed, 12 Jul 2006 21:53:02 -0400
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6D1r04K019621
	for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2006 01:53:01 GMT
Date: Wed, 12 Jul 2006 21:52:57 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
cc: netdev@vger.kernel.org, sds@tycho.nsa.gov, tjaeger@cse.psu.edu,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 08/10] MLSXFRM: Add security context to acquire messages
 using PF_KEY
In-Reply-To: <44B56642.6060500@trustedcs.com>
Message-ID: <Pine.LNX.4.64.0607122149070.573@d.namei>
References: <44B56642.6060500@trustedcs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 12 Jul 2006, Venkat Yekkirala wrote:

> +static inline void security_xfrm_skb_secid(struct sk_buff *skb, u32 *secid)
> {
> -	return security_ops->xfrm_decode_session(skb, fl);
> +	BUG_ON(security_ops->xfrm_decode_session(skb, secid, 0));
> 

BUG_ON looks wrong here, in that you don't know why the LSM returned an 
error, and why should the box panic at this point at all?


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
