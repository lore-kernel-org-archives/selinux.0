Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLLA3u2031641
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 16:10:04 -0500
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D511B5600B8
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 22:09:57 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libselinux/utils: do not create an empty /sbin directory
Date: Wed, 21 Dec 2016 22:09:51 +0100
Message-Id: <20161221210951.14337-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When building libselinux package, "make install" creates /sbin directory
without putting anything in it. Remove this from the Makefile.

While at it, rename USRBINDIR variable USRSBINDIR (with an S) as it
refers to /usr/sbin.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/utils/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index 774418495dbe..954da450c4d3 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -1,8 +1,7 @@
 # Installation directories.
 PREFIX ?= $(DESTDIR)/usr
 LIBDIR ?= $(PREFIX)/lib
-USRBINDIR ?= $(PREFIX)/sbin
-SBINDIR ?= $(DESTDIR)/sbin
+USRSBINDIR ?= $(PREFIX)/sbin
 INCLUDEDIR ?= $(PREFIX)/include
 
 OS ?= $(shell uname)
@@ -64,9 +63,9 @@ selinux_restorecon: LDLIBS += -lsepol
 all: $(TARGETS)
 
 install: all
-	-mkdir -p $(USRBINDIR)
-	install -m 755 $(TARGETS) $(USRBINDIR)
-	-mkdir -p $(SBINDIR)
+	-mkdir -p $(USRSBINDIR)
+	install -m 755 $(TARGETS) $(USRSBINDIR)
+
 clean:
 	rm -f $(TARGETS) *.o *~
 
-- 
2.11.0
