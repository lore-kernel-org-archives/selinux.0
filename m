Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA11917
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 19:20:27 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id gBF0KQI20446
	for <selinux@tycho.nsa.gov>; Sun, 15 Dec 2002 00:20:26 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
        by jazzband.ncsc.mil  with ESMTP id gBF0KNf20442 for <selinux@tycho.nsa.gov>; Sun, 15 Dec 2002 00:20:23 GMT
Date: Sun, 15 Dec 2002 11:24:50 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Les Bell <lesbell@lesbell.com.au>
Cc: Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Subject: Re: new Debian packages
Message-ID: <20021215002450.GC7775@snoopy.apana.org.au>
References: <OFABDD1FCC.C3C23AF2-ONCA256C90.00007F8A@lesbell.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFABDD1FCC.C3C23AF2-ONCA256C90.00007F8A@lesbell.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Dec 15, 2002 at 11:10:06AM +1100, Les Bell wrote:
> The FreeS/WAN developers seem mostly unconcerned by this - their view is
> that the kernel IPSec code is just one small part of a complete IPSec
> implementation; there's also a lot of user-space code for key management,
> authentication via X.509 certificates, etc. which they've been working on

errr.... FreeS/WAN project aren't interested in X.509, X.509 is an extra
unsupported patch to the FreeS/WAN patch (although both are integrated
in the Debian packaging).

I asked (in person) one of the FreeS/WAN developers about this at
OLS2002, and was told that they aren't currently interested in
supporting X.509 and have no plans to support it in the future.

(please correct me if I am mistaken though).
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
