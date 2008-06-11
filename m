Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5BEgpg9008372
	for <selinux@tycho.nsa.gov>; Wed, 11 Jun 2008 10:42:51 -0400
Subject: [RFC] Context ordering based on MLS dominance.
From: Dave Quigley <dpquigl@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Joshua Brindle <method@manicmethod.com>, bwhalen@tresys.com
Content-Type: text/plain
Date: Wed, 11 Jun 2008 10:34:12 -0400
Message-Id: <1213194852.16897.60.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set was original made to help in providing unioned polyinstantiated
directories for MLS. The method used Unionfs to order the branches from the
highest to lowest levels so when a process at a certain level listed the
directory contents it would see all of the polyinstantiated directories as one
with duplicates exposing the document at the highest level found.

Others have expressed a need for this functionality so the patches have been
revived. The question is should this be done as a kernel interface or should
it be done on the on disk policy file using libsepol?

The kernel patch is based off of Linus' current git tree as of 6/10 while the
libselinux patch is based off of the current svn tree from sourceforge as of
the same date. The patches went through testing initially when I was working
on polyinstantiated directories but I haven't tested the new version so give
them a try and see if they meet your needs.

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
