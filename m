Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LNKshO002446
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 19:20:54 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l5LNKrnL019126
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 23:20:53 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070621231507.402982591@hp.com>
Date: Thu, 21 Jun 2007 19:15:07 -0400
To: selinux@tycho.nsa.gov
Cc: cpebenito@tresys.com
Subject: [PATCHv2 0/5] Labeled network policy patches
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The latest revision of the labeled policy patches which enable both labeled
and unlabeled policy support for NetLabel.  This revision takes into account
Chris' feedback from the first version and reduces the number of interface
calls in each domain down to two at present: one for unlabeled access, one for
NetLabel access.  The older, transport layer specific interfaces, are still
present for use by third-party modules but are not used in the default policy
modules.

If there are still concerns please let me know, thanks.

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
