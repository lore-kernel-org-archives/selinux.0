Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5CKSjgA002309
	for <selinux@tycho.nsa.gov>; Sun, 12 Jun 2005 16:28:45 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5CKKkO0019219
	for <selinux@tycho.nsa.gov>; Sun, 12 Jun 2005 20:20:46 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by free.hands.com (Postfix) with ESMTP id 7E97ABF88
	for <selinux@tycho.nsa.gov>; Sun, 12 Jun 2005 21:20:45 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1DhZ5J-0000Lk-GZ
	for selinux@tycho.nsa.gov; Sun, 12 Jun 2005 21:29:33 +0100
Date: Sun, 12 Jun 2005 21:29:33 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: [owner@bugs.debian.org: Bug#249496 acknowledged by developer (Bug#249496: fixed in dpkg 1.13.9)]
Message-ID: <20050612202933.GF31033@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

whoo-hoo!  thank you, manoj, thank you scott!

----- Forwarded message from Debian Bug Tracking System <owner@bugs.debian.org> -----

This is an automatic notification regarding your Bug report
#249496: dpkg: [patch] - SElinux patches (security enhanced linux),
which was filed against the dpkg package.

It has been closed by one of the developers, namely
Scott James Remnant <scott@netsplit.com>.

....

Description: 
 dpkg       - Package maintenance system for Debian
 dpkg-dev   - Package building tools for Debian
 dselect    - a user tool to manage Debian packages
Closes: 21236 156317 193653 246802 249496 282323 304297 307139
Changes: 
 dpkg (1.13.9) unstable; urgency=low
 .
   The "On like Donkey Kong" Release.
 .
 .
   SELinux support (Manoj Srivastava):
   * On SELinux-enabled systems, try to set the security context when the
     package is unpacked.  Closes: #193653, #249496, #307139.
   * Added build-dependancy on libselinux1-dev.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
