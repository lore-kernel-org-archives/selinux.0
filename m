Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB28kfRb013048
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 03:46:42 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB28kfqY016742
	for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 08:46:41 GMT
Received: from nox.lemuria.org ([213.191.86.35])
        by jazzband.ncsc.mil  with ESMTP id hB28ke0o016739 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2003 08:46:40 GMT
Date: Tue, 2 Dec 2003 09:46:39 +0100
From: Tom <tom@lemuria.org>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: wdm now has SELinux support out-of-the-box
Message-ID: <20031202094639.C29282@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a short update:

My wdm patches have been accepted and integrated upstream and wdm will
now have SELinux support without any patches. You may have to recompile
it with the proper ./configure switches, though.


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
