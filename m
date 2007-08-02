Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72JxbfT021482
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 15:59:37 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72JxZOD029179
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 19:59:36 GMT
Date: Thu, 2 Aug 2007 15:59:23 -0400
Message-Id: <200708021959.l72JxNPe029534@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: kernel_corecommands changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

More bin_t files

--- nsaserefpolicy/policy/modules/kernel/corecommands.fc	2007-07-03 07:05:38.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/kernel/corecommands.fc	2007-08-02 11:02:02.000000000 -0400
@@ -36,6 +36,11 @@
 /etc/cipe/ip-up.*		--	gen_context(system_u:object_r:bin_t,s0)
 /etc/cipe/ip-down.*		--	gen_context(system_u:object_r:bin_t,s0)
 
+/etc/cron.daily/.*		--	gen_context(system_u:object_r:bin_t,s0)
+/etc/cron.hourly/.*		--	gen_context(system_u:object_r:bin_t,s0)
+/etc/cron.weekly/.*		--	gen_context(system_u:object_r:bin_t,s0)
+/etc/cron.monthly/.*		--	gen_context(system_u:object_r:bin_t,s0)
+
 /etc/hotplug/.*agent		--	gen_context(system_u:object_r:bin_t,s0)
 /etc/hotplug/.*rc		-- 	gen_context(system_u:object_r:bin_t,s0)
 /etc/hotplug/hotplug\.functions --	gen_context(system_u:object_r:bin_t,s0)
@@ -127,7 +132,10 @@
 /usr/lib(64)?/apt/methods.+	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/courier(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/cups/cgi-bin/.*	--	gen_context(system_u:object_r:bin_t,s0)
-/usr/lib(64)?/cups/filter/.*	--	gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/cups/filter(/.*)?		gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/cups/backend(/.*)? 	gen_context(system_u:object_r:bin_t,s0)
+/usr/lib(64)?/cups/daemon(/.*)? 	gen_context(system_u:object_r:bin_t,s0)
+
 /usr/lib(64)?/cyrus-imapd/.*	--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/dpkg/.+		--	gen_context(system_u:object_r:bin_t,s0)
 /usr/lib(64)?/emacsen-common/.*		gen_context(system_u:object_r:bin_t,s0)
@@ -160,6 +168,7 @@
 /usr/libexec/openssh/sftp-server --	gen_context(system_u:object_r:bin_t,s0)
 
 /usr/local/lib(64)?/ipsec/.*	-- 	gen_context(system_u:object_r:bin_t,s0)
+/usr/local/Brother/lpd(/.*)?		gen_context(system_u:object_r:bin_t,s0)
 
 /usr/sbin/sesh			--	gen_context(system_u:object_r:shell_exec_t,s0)
 
@@ -217,6 +226,7 @@
 /usr/share/system-config-network/neat-control\.py -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/system-config-nfs/nfs-export\.py -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/system-config-nfs/system-config-nfs\.py -- gen_context(system_u:object_r:bin_t,s0)
+/usr/share/system-config-printer/applet\.py -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/system-config-rootpassword/system-config-rootpassword -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/system-config-samba/system-config-samba\.py -- gen_context(system_u:object_r:bin_t,s0)
 /usr/share/system-config-securitylevel/system-config-securitylevel\.py -- gen_context(system_u:object_r:bin_t,s0)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
