Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAHLgJNb014490
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 16:42:19 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BA7D756468A
 for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2016 22:42:17 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] mcstrans: fix global "make install"
Date: Thu, 17 Nov 2016 22:42:10 +0100
Message-Id: <20161117214210.22625-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When running "make install" in the root directory of the project, with
variable DESTDIR set and while being on a system without SELinux, the
compiler complains while building:

    fatal error: selinux/selinux.h: No such file or directory

Other subdirectories add -I$(PREFIX)/include to CFLAGS and -L$(LIBDIR)
to the linking command line, in order to find libselinux headers and .so
file. Do this too in mcstrans.

While at it, mcstrans Makefile uses -I../include but this directory does
not exist. Remove this option.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 mcstrans/src/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mcstrans/src/Makefile b/mcstrans/src/Makefile
index ae74a16d278d..ea463bc1ec6f 100644
--- a/mcstrans/src/Makefile
+++ b/mcstrans/src/Makefile
@@ -10,12 +10,12 @@ PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
 PROG=mcstransd
 INITSCRIPT=mcstrans
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
-override CFLAGS += -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I$(PREFIX)/include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 
 all: $(PROG)
 
 $(PROG): $(PROG_OBJS)
-	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a
+	$(CC) $(LDFLAGS) -pie -o $@ $^ -lselinux -lcap -lpcre $(LIBDIR)/libsepol.a -L$(LIBDIR)
 
 %.o:  %.c 
 	$(CC) $(CFLAGS) -fPIE -c -o $@ $<
-- 
2.10.2
