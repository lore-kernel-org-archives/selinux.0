Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h92CxosJ002392
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 08:59:50 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h92Cw1Zt020800
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 12:58:01 GMT
Received: from nox.lemuria.org ([213.191.86.35])
	by jazzswing.ncsc.mil  with ESMTP id h92Cw0M3020791
	for <selinux@tycho.nsa.gov>; Thu, 2 Oct 2003 12:58:00 GMT
Date: Thu, 2 Oct 2003 14:59:39 +0200
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: patched wdm (new API)
Message-ID: <20031002145936.A16412@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi everyone -

I have patched the current wdm version so we have again an SELinux-aware
graphical login available.

Diff file and Debian package for Sid are on my website
(http://selinux.lemuria.org)

I have submitted the patch upstream for inclusion into the wdm tree.


I also would like to congratulate everyone who was involved in creating
the new API. It was much, much easier to patch wdm this time around,
and it required less total and especially less intrusive changes.


Tom

-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
