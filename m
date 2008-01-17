Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m0HKtS9X017473
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 15:55:28 -0500
Received: from g5t0006.atlanta.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m0HKtRGS003619
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2008 20:55:27 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v12 00/18] Labeled networking changes for 2.6.25
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 17 Jan 2008 15:55:21 -0500
Message-ID: <20080117204653.21013.77930.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The latest update to the labeled networking changes for 2.6.25.

This revision of the patchset finalizes the packet ingress/egress controls
using the existing netfilter forwarding and postrouting hooks while
adding SECMARK controls for forwarded traffic as discussed on the SELinux list.
This patchset also fixes a longstanding, but recently discovered, discrepancy
regarding the SELinux FLASK definitions, the discussion is still ongoing and
the fix used here may change as a result. 

The patches below can also be found here:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing
 * http://git.infradead.org/?p=users/pcmoore/lblnet-2.6_testing

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
