Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v44E96nW030040
 for <selinux@tycho.nsa.gov>; Thu, 4 May 2017 10:09:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9FAB867EC4
 for <selinux@tycho.nsa.gov>; Thu,  4 May 2017 14:09:02 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: Add INCLUDEDIR to utils/Makefile
Date: Thu,  4 May 2017 16:08:57 +0200
Message-Id: <20170504140857.18863-1-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

fcb5d5c removed ../include from CFLAGS from libsepol/utils/Makefile so
that a build tool can't find sepol/sepol.h when libsepol is built on a
system without sepol.h in standard paths.

Fixes:
chkcon.c:1:10: fatal error: sepol/sepol.h: No such file or directory
 #include <sepol/sepol.h>

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsepol/utils/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/utils/Makefile b/libsepol/utils/Makefile
index a13164e1..f5097be7 100644
--- a/libsepol/utils/Makefile
+++ b/libsepol/utils/Makefile
@@ -1,6 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 BINDIR ?= $(PREFIX)/bin
+INCLUDEDIR ?= $(PREFIX)/include
 
 CFLAGS ?= -Wall -Werror
 LDFLAGS += -L../src
-- 
2.12.2
