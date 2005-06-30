Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UBjtgA021069
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 07:45:55 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5UBiHBs011871
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 11:44:17 GMT
Received: from lkcl.net (host81-139-141-63.in-addr.btopenworld.com [81.139.141.63])
	by free.hands.com (Postfix) with ESMTP id CF611BF6F
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 12:44:53 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Dnxc6-0003aC-HP
	for selinux@tycho.nsa.gov; Thu, 30 Jun 2005 12:53:50 +0100
Date: Thu, 30 Jun 2005 12:53:50 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: idea for reducing policy size: put representation of macros in binary form
Message-ID: <20050630115350.GJ8415@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

mad-cap idea that should NOT be taken to its literal extreme (except
possibly in the case of an embedded system with more time than memory on
its hands).

how about, in trading off against processing power, making a
[possibly limited] means to represent the macros or equivalent
in binary form in the policy?

the reasoning behind this is to reduce the size of the policy, and to
have them expanded out (not using m4 obviously) by the selinux
capability module at runtime.

optionally cacheing the results of course, with the possibility of
throwing these cached results away if too much memory gets used.

certain macros could be an appropriate target but others, macros of
macros etc. would not.  yet.

l.

-- 
--
<a href="http://lkcl.net">http://lkcl.net</a>
--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
