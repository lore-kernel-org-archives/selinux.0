Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6SKq7Ev028357
 for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2017 16:52:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C714F317E4B
 for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2017 20:51:57 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Fri, 28 Jul 2017 16:52:02 -0400
Message-ID: <150127512210.31041.8443514853829257333.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] selinux: update the selinux info in MAINTAINERS
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f66488dfdbc9..65990909fe73 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11798,8 +11798,9 @@ M:	Paul Moore <paul@paul-moore.com>
 M:	Stephen Smalley <sds@tycho.nsa.gov>
 M:	Eric Paris <eparis@parisplace.org>
 L:	selinux@tycho.nsa.gov (moderated for non-subscribers)
-W:	http://selinuxproject.org
-T:	git git://git.infradead.org/users/pcmoore/selinux
+W:	https://selinuxproject.org
+W:	https://github.com/SELinuxProject
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
 S:	Supported
 F:	include/linux/selinux*
 F:	security/selinux/
