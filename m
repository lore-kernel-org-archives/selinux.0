From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: selinux@tycho.nsa.gov, nicolas.iooss@m4x.org, sds@tycho.nsa.gov
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Date: Tue, 16 Jan 2018 21:23:19 +0100
Message-Id: <20180116202327.23253-7-marcus.folkesson@gmail.com>
In-Reply-To: <20180116202327.23253-1-marcus.folkesson@gmail.com>
References: <marcus.folkesson@gmail.com>
 <20180116202327.23253-1-marcus.folkesson@gmail.com>
Subject: [PATCH v2 06/14] mcstrans: build: follow standard semantics
 for DESTDIR and PREFIX
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 mcstrans/man/Makefile   | 3 ++-
 mcstrans/src/Makefile   | 6 +++---
 mcstrans/utils/Makefile | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/mcstrans/man/Makefile b/mcstrans/man/Makefile
index 8e971192..5030fa81 100644
--- a/mcstrans/man/Makefile
+++ b/mcstrans/man/Makefile
@@ -1,5 +1,6 @@
 # Installation directories.
-MAN8DIR ?= $(DESTDIR)/usr/share/man/man8
+PREFIX ?= /usr
+MAN8DIR ?= $(DESTDIR)$(PREFIX)/share/man/man8
 
 all:
 
diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index 3f4a89c3..26423c29 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -1,9 +1,9 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
+PREFIX ?= /usr
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
 SBINDIR ?= $(DESTDIR)/sbin
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
-SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
+SYSTEMDDIR ?= $(DESTDIR)$(PREFIX)/lib/systemd
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 4d3cbfcb..79eb8438 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -1,7 +1,7 @@
 # Installation directories.
-PREFIX ?= $(DESTDIR)/usr
-LIBDIR ?= $(PREFIX)/lib
-SBINDIR ?= $(PREFIX)/sbin
+PREFIX ?= /usr
+LIBDIR ?= $(DESTDIR)$(PREFIX)/lib
+SBINDIR ?= $(DESTDIR)$(PREFIX)/sbin
 LIBSEPOLA ?= $(LIBDIR)/libsepol.a
 
 CFLAGS ?= -Wall
-- 
2.15.1
