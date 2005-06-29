Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5T25fgA009134
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 22:05:41 -0400 (EDT)
Received: from free.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5T24saC001461
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 02:04:54 GMT
Received: from lkcl.net (host81-155-76-60.range81-155.btcentralplus.com [81.155.76.60])
	by free.hands.com (Postfix) with ESMTP id 49375BF7A
	for <selinux@tycho.nsa.gov>; Wed, 29 Jun 2005 03:04:53 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1DnS5F-0002gt-58
	for selinux@tycho.nsa.gov; Wed, 29 Jun 2005 03:13:49 +0100
Date: Wed, 29 Jun 2005 03:13:49 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: wish-list item for selinux policy analyss
Message-ID: <20050629021349.GA10219@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

dear selinux people,

on my wish-list for selinux is a means to tell, at runtime,
which avc messages have been utilised.  not when - if.

the equivalent of code coverage analysis tools.

i envisage this to be implemented - hand-waving - by a single
bit which is marked in the in-kernel-memory store of selinux avc
policy, for reasons of minimising impact on run-time performance
(i believe that tying something into the avc audit logging
system, would be too slow).

the reason for this is to be able to fire up a system, run
it for a while (live) say oh a few months, and then determine
which bits of the selinux policy.conf have never ever actually
been used.

track them down, and remove them from the selinux source policy.

... via analysis of the policy.conf, back to the macros from
whence they came.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
