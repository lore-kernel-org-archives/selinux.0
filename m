Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5L5Clk0015310
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 01:12:47 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5L5Cksi007147
	for <selinux@tycho.nsa.gov>; Wed, 21 Jun 2006 05:12:46 GMT
Date: Wed, 21 Jun 2006 01:12:43 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>, netdev@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [PATCH 03/06] MLSXFRM: Add security sid to sock
In-Reply-To: <20060621043502.GA899@gondor.apana.org.au>
Message-ID: <Pine.LNX.4.64.0606210111570.5693@d.namei>
References: <36282A1733C57546BE392885C06185920132401F@chaos.tcs.tcs-sec.com>
 <20060621043502.GA899@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 21 Jun 2006, Herbert Xu wrote:

> On Tue, Jun 20, 2006 at 08:50:55PM -0400, Venkat Yekkirala wrote:
> >
> > Nope. It would actually overwrite the pointer, so we put it away before
> > memcpy
> > and set it back after memcpy.
> 
> Right, I misread it as sptr = osk->sk_security.  Still, it'd be nice to
> optimise it away for the !SECURITY case.

Indeed, there should be zero overhead for core networking code when LSM is 
not configured.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
