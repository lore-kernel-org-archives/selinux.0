Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KCxHg022732
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:12:59 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KCvTm001567
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:12:57 GMT
Date: Thu, 2 Aug 2007 16:12:54 -0400
Message-Id: <200708022012.l72KCs5c029959@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: kernel_terminal changes new terminal device
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/kernel/terminal.fc	2007-05-29 14:10:48.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/terminal.fc	2007-08-02 11:02:02.000000000 -0400
@@ -8,6 +8,7 @@
 /dev/dcbri[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/hvc.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/hvsi.*		-c	gen_context(system_u:object_r:tty_device_t,s0)
+/dev/i2c[^/]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/ircomm[0-9]+	-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/ip2[^/]*		-c	gen_context(system_u:object_r:tty_device_t,s0)
 /dev/isdn.*		-c	gen_context(system_u:object_r:tty_device_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
