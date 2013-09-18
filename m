Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r8IHEFdV014846
	for <selinux@tycho.nsa.gov>; Wed, 18 Sep 2013 13:14:15 -0400
Subject: [PATCH] selinux: add Paul Moore as a SELinux maintainer
To: eparis@parisplace.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Wed, 18 Sep 2013 13:14:04 -0400
Message-ID: <20130918171403.24618.84645.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e61c2e8..4fde706 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7390,9 +7390,10 @@ SELINUX SECURITY MODULE
 M:	Stephen Smalley <sds@tycho.nsa.gov>
 M:	James Morris <james.l.morris@oracle.com>
 M:	Eric Paris <eparis@parisplace.org>
+M:	Paul Moore <paul@paul-moore.com>
 L:	selinux@tycho.nsa.gov (subscribers-only, general discussion)
 W:	http://selinuxproject.org
-T:	git git://git.infradead.org/users/eparis/selinux.git
+T:	git git://git.infradead.org/users/pcmoore/selinux
 S:	Supported
 F:	include/linux/selinux*
 F:	security/selinux/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
