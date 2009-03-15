Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2FG9fW7009809
	for <selinux@tycho.nsa.gov>; Sun, 15 Mar 2009 12:09:41 -0400
Received: from ppsw-6.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2FG5sNA020006
	for <selinux@tycho.nsa.gov>; Sun, 15 Mar 2009 16:05:54 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:37739)
	by ppsw-6.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.136]:25)
	with esmtp id 1Listx-0003F2-Lg (Exim 4.70) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Sun, 15 Mar 2009 16:09:25 +0000
Message-ID: <49BD282F.2050609@martinorr.name>
Date: Sun, 15 Mar 2009 16:09:19 +0000
From: Martin Orr <martin@martinorr.name>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] dbus/lvm read domain state
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Both dbus and lvm want to read other processes' command lines.

In the case of dbus, this is for use in log messages, which is probably useful.

In the case of lvm, it is just to print in a warning if the parent process
leaks fds to it, which I doubt is important enough to allow.

Index: policy/modules/services/dbus.te
===================================================================
--- policy/modules/services/dbus.te.orig
+++ policy/modules/services/dbus.te
@@ -94,6 +94,7 @@
 corecmd_read_bin_sockets(system_dbusd_t)
 corecmd_exec_bin(system_dbusd_t)

+domain_read_all_domains_state(system_dbusd_t)
 domain_use_interactive_fds(system_dbusd_t)

 files_read_etc_files(system_dbusd_t)
Index: policy/modules/system/lvm.te
===================================================================
--- policy/modules/system/lvm.te.orig
+++ policy/modules/system/lvm.te
@@ -243,6 +243,7 @@
 corecmd_exec_bin(lvm_t)
 corecmd_exec_shell(lvm_t)

+domain_dontaudit_read_all_domains_state(lvm_t)
 domain_use_interactive_fds(lvm_t)

 files_read_etc_files(lvm_t)

-- 
Martin Orr

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
