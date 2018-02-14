From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: selinux@tycho.nsa.gov, Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Wed, 14 Feb 2018 10:57:15 +0100
Message-Id: <20180214095717.1050-14-marcus.folkesson@gmail.com>
In-Reply-To: <20180214095717.1050-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180214095717.1050-1-marcus.folkesson@gmail.com>
Subject: [PATCH v5 13/15] semodule-utils: build: follow standard
 semantics for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v5:
    	- Only use $(DESTDIR) in install
    v2:
    	- Rework all packages (not just selinux/sepol/semanage)

 semodule-utils/semodule_expand/Makefile  | 12 +++++-------
 semodule-utils/semodule_link/Makefile    | 12 +++++-------
 semodule-utils/semodule_package/Makefile | 16 +++++++---------
 3 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/semodule-utils/semodule_expand/Makefile b/semodule-utils/semodule_expand/Makefile
index 072f2137..f1a1c8f3 100644
--- a/semodule-utils/semodule_expand/Makefile
+++ b/semodule-utils/semodule_expand/Makefile
@@ -1,8 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
@@ -13,10 +11,10 @@ all: semodule_expand
 semodule_expand:  semodule_expand.o 
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 semodule_expand $(BINDIR)
-	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
-	install -m 644 semodule_expand.8 $(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 semodule_expand $(DESTDIR)$(BINDIR)
+	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d $(DESTDIR)$(MANDIR)/man8
+	install -m 644 semodule_expand.8 $(DESTDIR)$(MANDIR)/man8/
 
 relabel:
 
diff --git a/semodule-utils/semodule_link/Makefile b/semodule-utils/semodule_link/Makefile
index cc4687bd..692cb026 100644
--- a/semodule-utils/semodule_link/Makefile
+++ b/semodule-utils/semodule_link/Makefile
@@ -1,9 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
 MANDIR ?= $(PREFIX)/share/man
-LIBDIR ?= $(PREFIX)/lib
 
 CFLAGS ?= -Werror -Wall -W
 override LDLIBS += -lsepol
@@ -13,10 +11,10 @@ all: semodule_link
 semodule_link:  semodule_link.o 
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 semodule_link $(BINDIR)
-	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
-	install -m 644 semodule_link.8 $(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 semodule_link $(DESTDIR)$(BINDIR)
+	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d $(DESTDIR)$(MANDIR)/man8
+	install -m 644 semodule_link.8 $(DESTDIR)$(MANDIR)/man8/
 
 relabel:
 
diff --git a/semodule-utils/semodule_package/Makefile b/semodule-utils/semodule_package/Makefile
index 96dd7c4f..da170267 100644
--- a/semodule-utils/semodule_package/Makefile
+++ b/semodule-utils/semodule_package/Makefile
@@ -1,8 +1,6 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-INCLUDEDIR ?= $(PREFIX)/include
+PREFIX ?= /usr
 BINDIR ?= $(PREFIX)/bin
-LIBDIR ?= $(PREFIX)/lib
 MANDIR ?= $(PREFIX)/share/man
 
 CFLAGS ?= -Werror -Wall -W
@@ -13,12 +11,12 @@ all: semodule_package semodule_unpackage
 semodule_package:  semodule_package.o 
 
 install: all
-	-mkdir -p $(BINDIR)
-	install -m 755 semodule_package $(BINDIR)
-	install -m 755 semodule_unpackage $(BINDIR)
-	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
-	install -m 644 semodule_package.8 $(MANDIR)/man8/
-	install -m 644 semodule_unpackage.8 $(MANDIR)/man8/
+	-mkdir -p $(DESTDIR)$(BINDIR)
+	install -m 755 semodule_package $(DESTDIR)$(BINDIR)
+	install -m 755 semodule_unpackage $(DESTDIR)$(BINDIR)
+	test -d $(DESTDIR)$(MANDIR)/man8 || install -m 755 -d $(DESTDIR)$(MANDIR)/man8
+	install -m 644 semodule_package.8 $(DESTDIR)$(MANDIR)/man8/
+	install -m 644 semodule_unpackage.8 $(DESTDIR)$(MANDIR)/man8/
 
 relabel:
 
-- 
2.15.1
