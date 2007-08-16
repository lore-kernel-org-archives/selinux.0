Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GIXIef016577
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:33:18 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GIXBAd012399
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 18:33:11 GMT
Received: from localhost.localdomain (tresys-winxppro [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l7GIWv2t003203
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 14:32:57 -0400
Received: (from mgoldman@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l7GIWvdU003202
	for selinux@tycho.nsa.gov; Thu, 16 Aug 2007 14:32:57 -0400
Message-Id: <20070816182854.469714631@tresys.com>>
Date: Thu, 16 Aug 2007 14:28:54 -0400
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] [Patch 0/2] Add MLS support to policy rep branch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The first patch generalizes an output function.

The second patch adds MLS support to the policy representation.
The object representing user statements now supports MLS as well.

-mdg
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
