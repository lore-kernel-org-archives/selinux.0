Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAADb7Sf003451
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 08:37:07 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hAADb6Kl000407
	for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 13:37:06 GMT
Received: from nox.lemuria.org ([213.191.86.35])
        by jazzband.ncsc.mil  with ESMTP id hAADb55m000401 for <selinux@tycho.nsa.gov>; Mon, 10 Nov 2003 13:37:05 GMT
Date: Mon, 10 Nov 2003 14:37:05 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Do we break POSIX?
Message-ID: <20031110143701.S16119@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One point brought up by Theo DeRaadt during PacSec was that according
to POSIX, write operations can not return a permission denied error.

I could not argue with him on that because I have not actually read the
POSIX standard, but he has a valid point in that breaking standards
would be a big no.

Does anyone know immediately if this is so and if we are indeed
breaking POSIX? If nobody can answer that, I will find out myself, as
I've promised him to check.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
