Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KSVZl024215
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:28:31 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KSUTm004776
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:28:30 GMT
Date: Thu, 2 Aug 2007 16:27:55 -0400
Message-Id: <200708022027.l72KRtXo032144@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: system_iptables changes  uses nsswitch
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/iptables.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/system/iptables.te	2007-08-02 11:02:02.000000000 -0400
@@ -44,6 +44,8 @@
 
 corenet_relabelto_all_packets(iptables_t)
 
+auth_use_nsswitch(iptables_t)
+
 dev_read_sysfs(iptables_t)
 
 fs_getattr_xattr_fs(iptables_t)
@@ -62,6 +64,7 @@
 init_use_script_ptys(iptables_t)
 # to allow rules to be saved on reboot:
 init_rw_script_tmp_files(iptables_t)
+init_rw_script_stream_sockets(iptables_t)
 
 libs_use_ld_so(iptables_t)
 libs_use_shared_libs(iptables_t)
@@ -96,10 +99,6 @@
 ')
 
 optional_policy(`
-	nscd_socket_use(iptables_t)
-')
-
-optional_policy(`
 	ppp_dontaudit_use_fds(iptables_t)
 ')
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
