Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6EDt48r029945
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 09:55:04 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6EDt348014496
	for <selinux@tycho.nsa.gov>; Fri, 14 Jul 2006 13:55:03 GMT
Date: Fri, 14 Jul 2006 09:54:59 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: David Miller <davem@davemloft.net>
cc: vyekkirala@TrustedCS.com, netdev@vger.kernel.org,
        Stephen Smalley <sds@tycho.nsa.gov>, tjaeger@cse.psu.edu,
        selinux@tycho.nsa.gov, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH 08/10] MLSXFRM: Add security context to acquire messages
 using PF_KEY
In-Reply-To: <20060713.230445.106436593.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0607140952220.15305@d.namei>
References: <44B56642.6060500@trustedcs.com> <20060713.230445.106436593.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Jul 2006, David Miller wrote:

> The other changes I'm either OK with, or they are outside my scope of
> knowledge (the stuff that lives inside of SELINUX).

The security side of things looks ok to me.

Herbert, any review from you on this would be greatly appreciated.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
