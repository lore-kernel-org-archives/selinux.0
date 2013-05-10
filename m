Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r4ACk2P5015840
	for <selinux@tycho.nsa.gov>; Fri, 10 May 2013 08:46:02 -0400
From: Laurent Bigonville <bigon@debian.org>
To: Daniel J Walsh <dwalsh@redhat.com>, Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: [PATCH 01/16] Policycoreutils: Allow overriding INITDIR in restorecond Makefile
Date: Fri, 10 May 2013 14:45:09 +0200
Message-Id: <1368189924-8501-2-git-send-email-bigon@debian.org>
In-Reply-To: <1368189924-8501-1-git-send-email-bigon@debian.org>
References: <1368189924-8501-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 policycoreutils/restorecond/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/policycoreutils/restorecond/Makefile b/policycoreutils/restorecond/Makefile
index 3074542..23f458d 100644
--- a/policycoreutils/restorecond/Makefile
+++ b/policycoreutils/restorecond/Makefile
@@ -7,7 +7,7 @@ AUTOSTARTDIR = $(DESTDIR)/etc/xdg/autostart
 DBUSSERVICEDIR = $(DESTDIR)/usr/share/dbus-1/services
 
 autostart_DATA = sealertauto.desktop
-INITDIR = $(DESTDIR)/etc/rc.d/init.d
+INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
 DBUSFLAGS = -DHAVE_DBUS -I/usr/include/dbus-1.0 -I/usr/lib64/dbus-1.0/include -I/usr/lib/dbus-1.0/include
-- 
1.8.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
