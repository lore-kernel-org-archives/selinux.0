Message-Id: <20070927200712.950671948@tresys.com>
Date: Thu, 27 Sep 2007 16:07:12 -0400
From: "Todd C. Miller" <tmiller@tresys.com>
To: sds@tycho.nsa.gov, dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov, jbrindle@tresys.com, tmiller@tresys.com
Subject: [patch 0/4] libsemanage: genhomedircon regressions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set fixes several regressions found in the new genhomedircon
replacement.  I've broken things up into their logical parts for easy
reading.  I've also included Dan's do_rebuild_file_context and swigify
patches as a 4th diff.  If we want to treat that completely separately
we can.

 - todd

-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
