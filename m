Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5ILU2I4029631
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 17:30:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h5ILU25e014364
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 21:30:02 GMT
Received: from petrus.schuldei.org (petrus.schuldei.org [81.27.1.16])
        by jazzband.ncsc.mil  with ESMTP id h5ILU192014355 for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 21:30:01 GMT
Received: from lukas (lukas.schuldei.com [192.168.31.10])
	by petrus.schuldei.org (Postfix) with ESMTP id F3193FB922
	for <selinux@tycho.nsa.gov>; Wed, 18 Jun 2003 23:29:51 +0200 (CEST)
Date: Wed, 18 Jun 2003 23:27:46 +0200
From: Andreas Schuldei <andreas@schuldei.org>
To: selinux@tycho.nsa.gov
Subject: how usable is selinux in lsm-2.5?
Message-ID: <20030618212607.GB5278@schuldei.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I notice with satisfaction that lsm-2.5 with selinux configured
in compiles fine here.

what is missing from it to be usable? Or which parts are there
and what can one do with them?

will the 2.4 userspace which russel and brian ship in debian
packages work on this kernel? I understand that the proc
interface changed. are there patches for userspace allready?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
