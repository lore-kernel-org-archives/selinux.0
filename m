Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7FJl1dE001726
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 15:47:01 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7FJkunk028280
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 19:46:56 GMT
Received: from localhost.localdomain (tresys-winxppro [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l7FJksnY011746
	for <selinux@tycho.nsa.gov>; Wed, 15 Aug 2007 15:46:54 -0400
Received: (from mgoldman@localhost)
	by localhost.localdomain (8.13.8/8.13.8/Submit) id l7FJksJO011745
	for selinux@tycho.nsa.gov; Wed, 15 Aug 2007 15:46:54 -0400
Message-Id: <20070815194633.208081111@tresys.com>>
Date: Wed, 15 Aug 2007 15:46:33 -0400
From: Mark Goldman <mgoldman@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [POLICYREP] [Patch 0/3] remove modular policy support for policy rep branch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset removes module support from libsepol.  This
patchset is in support of the policyrep work.

Patch one removes the files that are solely for supporting modular
policies. 

Patch two eliminates the various structures that supported modular
policies. All functional changes occur in this patch.

Patch three puts dispol in libsepol's utils directory.
Dispol was not modified in this move.

-mdg

Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
