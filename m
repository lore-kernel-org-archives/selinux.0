Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id lBLHOix4003789
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 12:24:44 -0500
Received: from QMTA01.westchester.pa.mail.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id lBLHOgtf021669
	for <selinux@tycho.nsa.gov>; Fri, 21 Dec 2007 17:24:42 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v9 00/18] Labeled networking patches for 2.6.25 (against
	2.6.24-rc6)
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Cc: vyekkirala@TrustedCS.com, chanson@TrustedCS.com
Date: Fri, 21 Dec 2007 12:08:57 -0500
Message-ID: <20071221165109.12522.29726.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One more revision before the end of the year, backed against 2.6.24-rc6
or rather Linus' linux-2.6 tree from an hour ago.  The changes this time are
pretty minor: some IPv6 address tweaks and the object class/permission changes
already discussed on the SELinux list.

I've also update the git tree available here:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
