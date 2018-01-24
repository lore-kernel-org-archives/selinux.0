From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 24 Jan 2018 10:27:34 +0100
Message-Id: <20180124092736.8432-14-marcus.folkesson@gmail.com>
In-Reply-To: <20180124092736.8432-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180124092736.8432-1-marcus.folkesson@gmail.com>
Subject: [PATCH v4 13/15] semodule-utils: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 semodule-utils/semodule_expand/Makefile  | 8 +++-----
 semodule-utils/semodule_link/Makefile    | 8 +++-----
 semodule-utils/semodule_package/Makefile | 8 +++-----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semodule_expand/Makefile
index 072f2137..c2ab3f65 100644
--- a/semodule-utils/semodule_expand/Makefile
+++ b/semodule-utils/semodule_expand/Makefile
@@ -1,9 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
-MANDIR ?= $(PREFIX)/share/man
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol
diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodule_link/Makefile
index cc4687bd..bcf98765 100644
--- a/semodule-utils/semodule_link/Makefile
+++ b/semodule-utils/semodule_link/Makefile
@@ -1,9 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-BINDIR ?= $(PREFIX)/bin
-MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol
diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/semodule_package/Makefile
index 96dd7c4f..33a95e16 100644
--- a/semodule-utils/semodule_package/Makefile
+++ b/semodule-utils/semodule_package/Makefile
@@ -1,9 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
-BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
-MANDIR ?= $(PREFIX)/share/man
+PREFIX ?= /usr
+BINDIR ?= $(DESTDIR)$(PREFIX)/bin
+MANDIR ?= $(DESTDIR)$(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol
-- 
2.15.1
