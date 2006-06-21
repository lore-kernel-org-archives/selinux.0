Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5LEYjuk023764
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 10:34:45 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5LEYisi004707
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 14:34:44 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5LEYeIa028181
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 10:34:40 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5LEYe0D028180
	for selinux@tycho.nsa.gov; Wed, 21 Jun 2006 10:34:40 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5L4Z8bt014964
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 00:35:08 -0400
Received: from arnor.apana.org.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5L4Z6si004113
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 04:35:07 GMT
Date: Wed, 21 Jun 2006 14:35:02 +1000
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 03/06] MLSXFRM: Add security sid to sock
Message-ID: <20060621043502.GA899@gondor.apana.org.au>
References: <36282A1733C57546BE392885C06185920132401F@chaos.tcs.tcs-sec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <36282A1733C57546BE392885C06185920132401F@chaos.tcs.tcs-sec.com>
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 20, 2006 at 08:50:55PM -0400, Venkat Yekkirala wrote:
>
> Nope. It would actually overwrite the pointer, so we put it away before
> memcpy
> and set it back after memcpy.

Right, I misread it as sptr = osk->sk_security.  Still, it'd be nice to
optimise it away for the !SECURITY case.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
