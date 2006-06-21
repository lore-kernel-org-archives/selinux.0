Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5L0qxNp012161
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 20:52:59 -0400
Received: from tcsfw4.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5L0qqOh029248
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 00:52:56 GMT
Message-ID: <36282A1733C57546BE392885C06185920132401F@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: RE: [PATCH 03/06] MLSXFRM: Add security sid to sock
Date: Tue, 20 Jun 2006 20:50:55 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > +static inline void sock_copy(struct sock *nsk, const 
> struct sock *osk)
> > +{
> > +	void *sptr = nsk->sk_security;
> > +
> > +	memcpy(nsk, osk, osk->sk_prot->obj_size);
> > +	nsk->sk_security = sptr;
> 
> I don't get it.  Why do you put sk_security away and then set it back.
> Doesn't memcpy already do this for you?

Nope. It would actually overwrite the pointer, so we put it away before
memcpy
and set it back after memcpy.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
