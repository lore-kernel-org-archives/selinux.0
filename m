Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j02AYtIi012508
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 05:34:55 -0500 (EST)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j02AYweb008019
	for <selinux@tycho.nsa.gov>; Sun, 2 Jan 2005 10:34:58 GMT
Received: from lkcl.net (host81-153-247-118.range81-153.btcentralplus.com [81.153.247.118])
	by open.hands.com (Postfix) with ESMTP id DD826BF8A
	for <selinux@tycho.nsa.gov>; Sun,  2 Jan 2005 10:34:47 +0000 (GMT)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Cl3Eo-0002mc-FU
	for selinux@tycho.nsa.gov; Sun, 02 Jan 2005 10:45:30 +0000
Date: Sun, 2 Jan 2005 10:45:30 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: modules needed to be compiled in for selinux to work
Message-ID: <20050102104530.GG6142@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hi,

debian's 2.6.9 kernel has selinux - and capabilities - as modules.

i was wondering: which gets run first, /sbin/init or modprobe
capability from /etc/modules?

i think the question is fairly obviously /sbin/init but i want to be
absolutely sure.

in other words, is CONFIG_CAPABILITY=m stopping selinux from
working in debian's 2.6.9 kernel?

or am i on the wrong track altogether?

ta,

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
