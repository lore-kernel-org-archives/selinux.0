Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CpNb1015394
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:51:23 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CpHpq017620
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:51:17 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id 4F6E741C
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:51:21 +0200 (CEST)
Message-Id: <20080804123739.200605175@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:24 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 28/35] iscsi policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RH updates to the iscsi module, none of which seem controversial...
Index: refpolicy/policy/modules/system/iscsi.fc
===================================================================
--- refpolicy.orig/policy/modules/system/iscsi.fc	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/iscsi.fc	2008-08-03 21:29:52.000000000 +0200
@@ -1,5 +1,5 @@
 /sbin/iscsid		--	gen_context(system_u:object_r:iscsid_exec_t,s0)
 
-/var/lib/iscsi(/.*)?	--	gen_context(system_u:object_r:iscsi_var_lib_t,s0)
-/var/lock/iscsi(/.*)?	--	gen_context(system_u:object_r:iscsi_lock_t,s0)
+/var/lib/iscsi(/.*)?		gen_context(system_u:object_r:iscsi_var_lib_t,s0)
+/var/lock/iscsi(/.*)?		gen_context(system_u:object_r:iscsi_lock_t,s0)
 /var/run/iscsid\.pid	--	gen_context(system_u:object_r:iscsi_var_run_t,s0)
Index: refpolicy/policy/modules/system/iscsi.te
===================================================================
--- refpolicy.orig/policy/modules/system/iscsi.te	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/iscsi.te	2008-08-03 21:29:52.000000000 +0200
@@ -29,7 +29,7 @@
 #
 
 allow iscsid_t self:capability { dac_override ipc_lock net_admin sys_nice sys_resource };
-allow iscsid_t self:process { setrlimit setsched };
+allow iscsid_t self:process { setrlimit setsched signal };
 allow iscsid_t self:fifo_file { read write };
 allow iscsid_t self:unix_stream_socket { create_stream_socket_perms connectto };
 allow iscsid_t self:unix_dgram_socket create_socket_perms;
@@ -63,6 +63,7 @@
 corenet_tcp_sendrecv_all_ports(iscsid_t)
 corenet_tcp_connect_http_port(iscsid_t)
 corenet_tcp_connect_iscsi_port(iscsid_t)
+corenet_tcp_connect_isns_port(iscsid_t)
 
 dev_rw_sysfs(iscsid_t)
 

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
