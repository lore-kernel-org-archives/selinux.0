From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070309203327.709750017@hp.com>
Date: Fri, 09 Mar 2007 15:33:27 -0500
To: selinux@tycho.nsa.gov
Cc: dwalsh@redhat.com, cpebenito@tresys.com, sds@tycho.nsa.gov
Subject: [PATCH 0/3] Some quick policy patches based on the problems from earlier today
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set addresses some issues seen when trying to configure/start both
the IPsec and NetLabel management tools at boot from the init scripts.  These
patches have only been lightly tested, but they are pretty trivial.

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
