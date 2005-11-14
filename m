Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAELPtMA006693
	for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2005 16:25:55 -0500 (EST)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAELIetR022911
	for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2005 21:18:40 GMT
Received: from lkcl.net (bb-87-82-6-113.ukonline.co.uk [87.82.6.113])
	by free.hands.com (Postfix) with ESMTP id 75AA4C1B3
	for <selinux@tycho.nsa.gov>; Mon, 14 Nov 2005 21:16:55 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Eblh2-00008V-H2
	for selinux@tycho.nsa.gov; Mon, 14 Nov 2005 21:16:48 +0000
Date: Mon, 14 Nov 2005 21:16:48 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [owner@bugs.debian.org: Bug#338543 acknowledged by developer (Bug#338543: fixed in linux-2.6 2.6.14-3)]
Message-ID: <20051114211648.GL8699@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hurrah.  much info cut from the original (very long) message.
highlights below.

----- Forwarded message from Debian Bug Tracking System <owner@bugs.debian.org> -----

This is an automatic notification regarding your Bug report
#338543: linux-image-2.6.14-1-686: CONFIG_SECURITY_NETWORK is disabled which totally breaks SE/Linux,
which was filed against the linux-image-2.6.14-1-686 package.

It has been closed by one of the developers, namely
Norbert Tretkowski <nobse@debian.org>.

Architecture: source i386 all
Version: 2.6.14-3
Distribution: unstable
Urgency: low
Maintainer: Debian Kernel Team <debian-kernel@lists.debian.org>
Changed-By: Norbert Tretkowski <nobse@debian.org>
 linux-headers-2.6.14 - All header files for Linux kernel 2.6.14
 linux-image-2.6.14-2-686 - Linux kernel 2.6.14 image on PPro/Celeron/PII/PIII/P4 machines
 linux-tree-2.6.14 - Linux kernel source tree for building Debian kernel images
Closes: 267600 321200 336424 336431 336450 337072 337089 337713 338543 338911
Changes: 
 linux-2.6 (2.6.14-3) unstable; urgency=low
 .
   [ Frederik Sch??ler ]
   * activate CONFIG_SECURITY_NETWORK to fix SElinux operation.
     (Closes: #338543)

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
