Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBEJSdZg002416
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 14:28:39 -0500
Received: from atlrel6.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBEJTBSS011082
	for <selinux@tycho.nsa.gov>; Thu, 14 Dec 2006 19:29:12 GMT
Message-Id: <20061214192414.551708000@hp.com>
Date: Thu, 14 Dec 2006 14:24:14 -0500
From: paul.moore@hp.com
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com
Subject: [PATCH 0/4] NetLabel and MLS fixes for Reference Policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset addresses a few problems with the reference policy in SVN.  The first is that when I sent the original NetLabel policy patches I forgot to actually assign NetLabel receive access to any of the application domains - oops.  The other issues involve MLS socket overrides and their use in the inetd_t domain.

Most of the changes should have little impact on the policy and I've done some quick testing and everything looks okay to me.  One note, telnet seem to be broken when used in strict-mls under the current policy (broken without this patchset) and I'm currently looking into that, I'll push another patch when I have that fixed.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
