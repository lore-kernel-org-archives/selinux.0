Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA13998
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 10:00:22 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h0GF0LI24893
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 15:00:21 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id h0GF0Kf24889 for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 15:00:21 GMT
Date: Thu, 16 Jan 2003 16:00:10 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: version mismatch in Debian packages
Message-ID: <20030116160010.A2883@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm doing a clean install today and noticed a version mismatch in the
Debian packages at Brian's site.

The tools seem to be compiled to version 12, but the lsm patch for
kernel 2.4.18 is version 11. The patches for 2.4.19 and 2.4.20 are
version 12, it's only the 2.4.18 that is affected.

This is ugly because woody doesn't contain source packages for 19 or
20, only for 2.4.18


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
