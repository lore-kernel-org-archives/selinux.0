Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4VDIa9E027535
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 09:18:37 -0400
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
 by anor.bigon.be (Postfix) with ESMTP id 27AE41A0C0
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 15:18:27 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
 by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id 3BdLB0ceksjD for <selinux@tycho.nsa.gov>;
 Thu, 31 May 2018 15:18:05 +0200 (CEST)
Received: from valinor.bigon.be (unknown [193.53.238.201])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate) (Authenticated sender: bigon)
 by anor.bigon.be (Postfix) with ESMTPSA id 4BED91A055
 for <selinux@tycho.nsa.gov>; Thu, 31 May 2018 15:18:05 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Date: Thu, 31 May 2018 15:18:04 +0200
Message-Id: <20180531131804.8933-1-bigon@debian.org>
Subject: [PATCH] restorecond: Fix consistancy of DESTDIR usage
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Laurent Bigonville <bigon@bigon.be>

---
 restorecond/Makefile | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/restorecond/Makefile b/restorecond/Makefile
index 25be18d4..8a0ada1f 100644
--- a/restorecond/Makefile
+++ b/restorecond/Makefile
@@ -9,8 +9,8 @@ DBUSSERVICEDIR = $(PREFIX)/share/dbus-1/services
 SYSTEMDDIR ?= $(PREFIX)/lib/systemd
 
 autostart_DATA = sealertauto.desktop
-INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
-SELINUXDIR = $(DESTDIR)/etc/selinux
+INITDIR ?= /etc/rc.d/init.d
+SELINUXDIR = /etc/selinux
 
 DBUSFLAGS = -DHAVE_DBUS $(shell $(PKG_CONFIG) --cflags dbus-glib-1)
 DBUSLIB = $(shell $(PKG_CONFIG) --libs dbus-glib-1)
@@ -42,11 +42,11 @@ install: all
 	-mkdir -p $(DESTDIR)$(SBINDIR)
 	install -m 755 restorecond $(DESTDIR)$(SBINDIR)
 	install -m 644 restorecond.8 $(DESTDIR)$(MANDIR)/man8
-	-mkdir -p $(INITDIR)
-	install -m 755 restorecond.init $(INITDIR)/restorecond
-	-mkdir -p $(SELINUXDIR)
-	install -m 644 restorecond.conf $(SELINUXDIR)/restorecond.conf
-	install -m 644 restorecond_user.conf $(SELINUXDIR)/restorecond_user.conf
+	-mkdir -p $(DESTDIR)$(INITDIR)
+	install -m 755 restorecond.init $(DESTDIR)$(INITDIR)/restorecond
+	-mkdir -p $(DESTDIR)$(SELINUXDIR)
+	install -m 644 restorecond.conf $(DESTDIR)$(SELINUXDIR)/restorecond.conf
+	install -m 644 restorecond_user.conf $(DESTDIR)$(SELINUXDIR)/restorecond_user.conf
 	-mkdir -p $(DESTDIR)$(AUTOSTARTDIR)
 	install -m 644 restorecond.desktop $(DESTDIR)$(AUTOSTARTDIR)/restorecond.desktop
 	-mkdir -p $(DESTDIR)$(DBUSSERVICEDIR)
-- 
2.17.1
