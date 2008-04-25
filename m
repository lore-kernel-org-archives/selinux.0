Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3PJ5mRc019794
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 15:05:48 -0400
Received: from QMTA08.westchester.pa.mail.comcast.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3PJ5lef016955
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 19:05:47 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 0/2] Fixes for 2.6.26
To: selinux@tycho.nsa.gov
Date: Fri, 25 Apr 2008 15:03:28 -0400
Message-ID: <20080425185928.18002.88176.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These two patches fix the SLAB corruption problems seen by Andrew Morton
which caused the netnode cache changes to be bumped from the initial 2.6.26
SELinux patchset.  The patches are backed against Linus' tree from this
morning and have been testing against 2.6.25-mm1 with a reduced hash table
size to stress the problem; I have not seen any regressions.

The first patch in the corrected netnode cache changes and the second patch
applies the same fix to the netport cache (it suffers the same problem but
it hasn't been seen yet).

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
