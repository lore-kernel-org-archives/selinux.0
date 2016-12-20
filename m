Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBKHjvat006318
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 12:45:57 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
 (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA4D0C04B926
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 17:45:55 +0000 (UTC)
Subject: [PATCH] selinux: use the kernel headers when building
 scripts/selinux/genheaders
From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue, 20 Dec 2016 12:45:54 -0500
Message-ID: <148225595449.30954.6812336959299313160.stgit@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <paul@paul-moore.com>

Commit 3322d0d64f4e ("selinux: keep SELinux in sync with new capability
definitions") added a check on the defined capabilities without
explicitly including the capability header file which caused problems
when building genheaders for users of clang/llvm.  Resolve this by
using the kernel headers when building genheaders, which is arguably
the right thing to do regardless, and explicitly including the
kernel's capability.h header file in classmap.h.

Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 scripts/selinux/genheaders/Makefile     |    4 +++-
 scripts/selinux/genheaders/genheaders.c |    4 ++++
 security/selinux/include/classmap.h     |    2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/scripts/selinux/genheaders/Makefile b/scripts/selinux/genheaders/Makefile
index 1d1ac51359e3..6fc2b8789a0b 100644
--- a/scripts/selinux/genheaders/Makefile
+++ b/scripts/selinux/genheaders/Makefile
@@ -1,4 +1,6 @@
 hostprogs-y	:= genheaders
-HOST_EXTRACFLAGS += -Isecurity/selinux/include
+HOST_EXTRACFLAGS += \
+	-I$(srctree)/include/uapi -I$(srctree)/include \
+	-I$(srctree)/security/selinux/include
 
 always		:= $(hostprogs-y)
diff --git a/scripts/selinux/genheaders/genheaders.c b/scripts/selinux/genheaders/genheaders.c
index 539855ff31f9..f4dd41f900d5 100644
--- a/scripts/selinux/genheaders/genheaders.c
+++ b/scripts/selinux/genheaders/genheaders.c
@@ -1,3 +1,7 @@
+
+/* NOTE: we really do want to use the kernel headers here */
+#define __EXPORTED_HEADERS__
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index e2d4ad3a4b4c..13ae49b0baa0 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -1,3 +1,5 @@
+#include <linux/capability.h>
+
 #define COMMON_FILE_SOCK_PERMS "ioctl", "read", "write", "create", \
     "getattr", "setattr", "lock", "relabelfrom", "relabelto", "append"
 
