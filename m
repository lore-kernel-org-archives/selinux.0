Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v83CLSQJ026267
 for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2017 08:21:28 -0400
Received: from localhost.localdomain (abo-140-56-69.avi.modulonet.fr
 [85.69.56.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D06205646D2
 for <selinux@tycho.nsa.gov>; Sun,  3 Sep 2017 14:20:10 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Sep 2017 14:19:28 +0200
Message-Id: <20170903121928.24024-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170903121928.24024-1-nicolas.iooss@m4x.org>
References: <20170903121928.24024-1-nicolas.iooss@m4x.org>
Subject: [PATCH 6/6] Makefile: define a default value for CFLAGS
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building the project with "make DESTDIR=... install", the root
Makefile defines CFLAGS and LDFLAGS without any warning flags ("CFLAGS
+= -I$(DESTDIR)/usr/include" and "LDFLAGS += -L$(DESTDIR)/usr/lib"). As
the Makefiles in subdirectories do not override the flags with warning
flags, the code gets compiled without any enabled warning.

This leads for example to code being introduced which breaks building
libsepol from its directory, while building it from the root Makefile
still works fine.

This issue can be fixed by defining a set of flags in the root Makefile
which are used by all Makefiles in subdirectories. The flags have been
chosen following these principles:
* they are compatible with both clang and gcc,
* they already appear in at least one Makefile, and
* they are not triggered with the current git master version.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 Makefile | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Makefile b/Makefile
index 7701e16252fe..6da7f7b71bdc 100644
--- a/Makefile
+++ b/Makefile
@@ -6,6 +6,16 @@ DISTCLEANSUBDIRS=libselinux libsemanage
 ifeq ($(DEBUG),1)
 	export CFLAGS = -g3 -O0 -gdwarf-2 -fno-strict-aliasing -Wall -Wshadow -Werror
 	export LDFLAGS = -g
+else
+	export CFLAGS ?= -O2 -Werror -Wall -Wextra \
+		-Wmissing-format-attribute \
+		-Wmissing-noreturn \
+		-Wpointer-arith \
+		-Wshadow \
+		-Wstrict-prototypes \
+		-Wundef \
+		-Wunused \
+		-Wwrite-strings
 endif
 
 ifneq ($(DESTDIR),)
-- 
2.14.1
