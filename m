Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA6CODuI011595
	for <selinux@tycho.nsa.gov>; Wed, 6 Nov 2013 07:24:15 -0500
Received: from anor.bigon.be (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 647871A00F
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2013 13:24:06 +0100 (CET)
Received: from anor.bigon.be ([127.0.0.1])
	by anor.bigon.be (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id a7xVF_qxErzl for <selinux@tycho.nsa.gov>;
	Wed,  6 Nov 2013 13:24:02 +0100 (CET)
Received: from soldur.bigon.be (unknown [193.53.238.195])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 3157F1A1A4
	for <selinux@tycho.nsa.gov>; Wed,  6 Nov 2013 13:24:02 +0100 (CET)
From: Laurent Bigonville <bigon@debian.org>
To: SELinux <selinux@tycho.nsa.gov>
Subject: [PATCH 1/3] Add systemd unit file for mcstrans daemon
Date: Wed,  6 Nov 2013 13:23:59 +0100
Message-Id: <1383740641-9927-1-git-send-email-bigon@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Laurent Bigonville <bigon@bigon.be>

---
 policycoreutils/mcstrans/src/Makefile         | 3 +++
 policycoreutils/mcstrans/src/mcstrans.service | 9 +++++++++
 2 files changed, 12 insertions(+)
 create mode 100644 policycoreutils/mcstrans/src/mcstrans.service

diff --git a/policycoreutils/mcstrans/src/Makefile b/policycoreutils/mcstrans/src/Makefile
index fb44490..907a1f1 100644
--- a/policycoreutils/mcstrans/src/Makefile
+++ b/policycoreutils/mcstrans/src/Makefile
@@ -17,6 +17,7 @@ endif
 PREFIX  ?= $(DESTDIR)/usr
 SBINDIR ?= $(DESTDIR)/sbin
 INITDIR ?= $(DESTDIR)/etc/rc.d/init.d
+SYSTEMDDIR ?= $(DESTDIR)/usr/lib/systemd
 
 PROG_SRC=mcstrans.c  mcscolor.c  mcstransd.c  mls_level.c
 PROG_OBJS= $(patsubst %.c,%.o,$(PROG_SRC))
@@ -38,6 +39,8 @@ install: all
 	install -m 755 $(PROG) $(SBINDIR)
 	test -d $(INITDIR) || install -m 755 -d $(INITDIR)
 	install -m 755 $(INITSCRIPT).init $(INITDIR)/$(INITSCRIPT)
+	test -d $(SYSTEMDDIR)/system || install -m 755 -d $(SYSTEMDDIR)/system
+	install -m 644 mcstrans.service $(SYSTEMDDIR)/system/
 
 clean: 
 	-rm -f $(OBJS) $(LOBJS) $(TARGET) $(PROG) $(PROG_OBJS) *~ \#*
diff --git a/policycoreutils/mcstrans/src/mcstrans.service b/policycoreutils/mcstrans/src/mcstrans.service
new file mode 100644
index 0000000..64bb361
--- /dev/null
+++ b/policycoreutils/mcstrans/src/mcstrans.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=Translates SELinux MCS/MLS labels to human readable form
+ConditionSecurity=selinux
+
+[Service]
+ExecStart=/sbin/mcstransd -f
+
+[Install]
+WantedBy=multi-user.target
-- 
1.8.4.2


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
