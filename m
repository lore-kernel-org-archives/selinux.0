Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m85NNHnr030956
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 19:23:17 -0400
Received: from g4t0016.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m85NNHQ2002305
	for <selinux@tycho.nsa.gov>; Fri, 5 Sep 2008 23:23:17 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v5 00/14] Labeled networking patches for 2.6.28
To: selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Fri, 05 Sep 2008 19:23:12 -0400
Message-ID: <20080905231853.31840.57880.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new spin to fix problems pointed out by Andrew Mortion and Randy Dunlap
as well as some minor things found by James Morris during review.  Thanks
to all three for the extra sets of eyes.

This patchset also has a slight change in it which involves moving the
SELinux packet parsing (to determine protocol, address, etc.) farther down
in the SELinux per-packet processing routines.  This should help reduce
some wasted cycles, especially in the unconfigured case.

I've updated both my lblnet-2.6_testing and lblnet-2.6_next trees with
the new bits:

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_testing
 * git://git.infradead.org/users/pcmoore/lblnet-2.6_next

--
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
