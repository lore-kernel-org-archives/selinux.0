Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4T7Wdeg027570
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 03:32:39 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 278981A0C0
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 09:31:38 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 56UFelC3llBV for <selinux@tycho.nsa.gov>;
 Tue, 29 May 2018 09:31:17 +0200 (CEST)
Received: from valinor.bigon.be (unknown [109.134.145.1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id EE1B01A055
 for <selinux@tycho.nsa.gov>; Tue, 29 May 2018 09:31:16 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Date: Tue, 29 May 2018 09:29:04 +0200
Message-Id: <20180529072904.26084-1-bigon@debian.org>
Subject: [PATCH] restorecond: Fix consistancy of DESTDIR usage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

---
 restorecond/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 25be18d4..fed65bba 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -9,7 +9,7 @@ DBUSSERVICEDIR = $(PREFIX)/share/dbus-1/services
 SYSTEMDDIR ?= $(PREFIX)/lib/systemd
 
 autostart_DATA = sealertauto.desktop
-INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
+INITDIR ?= /etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
 DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
@@ -42,8 +42,8 @@ install: all
 	-mkdir -p $(DESTDIR)$(SBINDIR)
 	install -m 755 restorecond $(DESTDIR)$(SBINDIR)
 	install -m 644 restorecond.8 $(DESTDIR)$(MANDIR)/man8
-	-mkdir -p $(INITDIR)
-	install -m 755 restorecond.init $(INITDIR)/restorecond
+	-mkdir -p $(DESTDIR)$(INITDIR)
+	install -m 755 restorecond.init $(DESTDIR)$(INITDIR)/restorecond
 	-mkdir -p $(SELINUXDIR)
 	install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
 	install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
-- 
2.17.0
