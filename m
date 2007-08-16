Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7GFtx0G004110
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:55:59 -0400
Received: from localhost.localdomain (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7GFtvCf011534
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 15:55:58 GMT
Received: from localhost.localdomain (tresys-winxppro [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l7GFtuE5028066
	for <selinux@tycho.nsa.gov>; Thu, 16 Aug 2007 11:55:56 -0400
Received: (from mgoldman@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l7GFttme028065
	for selinux@tycho.nsa.gov; Thu, 16 Aug 2007 11:55:55 -0400
Message-Id: <20070816155325.881136010@tresys.com>>
Date: Thu, 16 Aug 2007 11:53:25 -0400
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] [Patch 0/5] remove modular policy support for policy rep branch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset removes module support from libsepol.  This
patchset is in support of the policyrep work.

Patches one and two removes the files that are solely for 
supporting modular policies. 

Patch three and four eliminates the various structures that 
supported modular policies. All functional changes occur in 
this patch.

Patch five puts dispol in libsepol's utils directory.
Dispol was not modified in this move.

This e-mail splits the original patches up so that they will go
through the list-serv without being bounced.

-mdg

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
