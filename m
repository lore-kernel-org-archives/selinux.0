Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5IM6hFX023563
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 18:06:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 999E587AA9
 for <selinux@tycho.nsa.gov>; Mon, 18 Jun 2018 22:05:59 +0000 (UTC)
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Mon, 18 Jun 2018 18:05:58 -0400
Message-ID: <152935955894.24236.15755269652361352467.stgit@chester>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [PATCH] MAINTAINERS: update the LSM and SELinux subsystems
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

The SELinux code, security/selinux/, already has a MAINTAINERS entry
so exclude it from the security subsystem entry in an effort to better
reflect current practices.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..67e4c4f92ba9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12769,6 +12769,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
 W:	http://kernsec.org/
 S:	Supported
 F:	security/
+X:	security/selinux/
 
 SELINUX SECURITY MODULE
 M:	Paul Moore <paul@paul-moore.com>
