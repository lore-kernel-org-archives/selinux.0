Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l57FaZNX021308
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 11:36:35 -0400
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l57FaYWW020598
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 15:36:35 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070607153226.524778346@hp.com>
Date: Thu, 07 Jun 2007 11:32:26 -0400
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 0/2] NetLabel cleanups
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Two straight-forward, smallish patches against David's net-2.6 tree which fix
some kernel unaligned access errors/messages and remove some redundant code.
I've tested this patchset on both x86 and ia64 platforms and have not seen
any regressions.

I'm not sure about my timing, but if it is too late for 2.6.22 please consider
these for 2.6.23.

Thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
