Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5KKUFBg001529
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 16:30:16 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id C80855648B5
 for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2017 22:30:10 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] gui: do not create /etc
Date: Tue, 20 Jun 2017 22:29:54 +0200
Message-Id: <20170620202955.11587-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170620202955.11587-1-nicolas.iooss@m4x.org>
References: <20170620202955.11587-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

selinux-gui does not install anything in /etc. Do not create this
directory when building a package with "make install".

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 gui/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/gui/Makefile b/gui/Makefile
index d49a7ce048c1..4fc2c1a133be 100644
--- a/gui/Makefile
+++ b/gui/Makefile
@@ -1,6 +1,5 @@
 # Installation directories.
 PREFIX ?= ${DESTDIR}/usr
-SYSCONFDIR ?= ${DESTDIR}/etc
 BINDIR ?= $(PREFIX)/bin
 SHAREDIR ?= $(PREFIX)/share/system-config-selinux
 DATADIR ?= $(PREFIX)/share
@@ -30,7 +29,6 @@ install: all
 	-mkdir -p $(BINDIR)
 	-mkdir -p $(DATADIR)/pixmaps
 	-mkdir -p $(DATADIR)/icons/hicolor/24x24/apps
-	-mkdir -p $(SYSCONFDIR)
 	-mkdir -p $(DATADIR)/polkit-1/actions/
 	install -m 755 system-config-selinux.py $(SHAREDIR)
 	install -m 755 system-config-selinux $(BINDIR)
-- 
2.13.1
