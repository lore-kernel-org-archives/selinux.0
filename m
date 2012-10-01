Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q91GWubd017392
	for <selinux@tycho.nsa.gov>; Mon, 1 Oct 2012 12:32:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 8F2541AAED
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:13 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dSA7QW-q-q3B for <selinux@tycho.nsa.gov>;
	Mon,  1 Oct 2012 18:32:11 +0200 (CEST)
Received: from eldamar.bigon.be (d54C6D43E.access.telenet.be [84.198.212.62])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id D7F3D1AAD9
	for <selinux@tycho.nsa.gov>; Mon,  1 Oct 2012 18:32:10 +0200 (CEST)
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 01/15] Policycoreutils: Allow overriding INITDIR in restorecond Makefile
Date: Mon,  1 Oct 2012 18:31:43 +0200
Message-Id: <1349109117-593-2-git-send-email-bigon@debian.org>
In-Reply-To: <1349109117-593-1-git-send-email-bigon@debian.org>
References: <1349109117-593-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 policycoreutils/restorecond/Makefile |    2 +-
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
1.7.10.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
