Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uASLf6X7026162
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 16:41:07 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1F611560799
 for <selinux@tycho.nsa.gov>; Mon, 28 Nov 2016 22:40:52 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/4] mcstrans/utils: make "make all" use $DESTDIR
Date: Mon, 28 Nov 2016 22:40:15 +0100
Message-Id: <20161128214018.7861-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running "make all" in the root directory on a system where SELinux
is not installed and where $DESTDIR targets a directory where the
libraries have been installed, the build fails in mcstrans/utils with
the following error:

    transcon.c:7:10: fatal error: 'selinux/selinux.h' file not found

and then:

    /usr/bin/ld: cannot find -lselinux

Fix this by adding -I$(PREFIX)/include to CFLAGS and -L$(LIBDIR) to
LDLIBS like other subdirectories do.

While at it, remove the useless -L../src parameter.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/utils/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/utils/Makefile b/mcstrans/utils/Makefile
index 43608dbb5331..a0f93f548557 100644
--- a/mcstrans/utils/Makefile
+++ b/mcstrans/utils/Makefile
@@ -4,8 +4,8 @@ LIBDIR ?= $(PREFIX)/lib
 BINDIR ?= $(PREFIX)/sbin
 
 CFLAGS ?= -Wall
-override CFLAGS += -I../src -D_GNU_SOURCE
-LDLIBS += -L../src ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
+override CFLAGS += -I../src -I$(PREFIX)/include -D_GNU_SOURCE
+LDLIBS += -L$(LIBDIR) ../src/mcstrans.o ../src/mls_level.o -lselinux -lpcre $(LIBDIR)/libsepol.a
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
 
-- 
2.10.2
