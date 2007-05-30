Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHatr3013818
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:55 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHar2p008243
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:53 GMT
Date: Wed, 30 May 2007 10:47:44 -0400
Message-Id: <200705301447.l4UEliOR008168@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: inetd changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/services/inetd.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/inetd.te	2007-05-30 07:35:54.000000000 -0400
@@ -135,8 +135,8 @@
 mls_fd_use_all_levels(inetd_t)
 mls_fd_share_all_levels(inetd_t)
 mls_socket_read_to_clearance(inetd_t)
+mls_socket_write_to_clearance(inetd_t)
 mls_process_set_level(inetd_t)
-mls_socket_read_to_clearance(inetd_t)
 
 sysnet_read_config(inetd_t)
 
@@ -177,6 +177,9 @@
 # for identd
 allow inetd_child_t self:netlink_tcpdiag_socket r_netlink_socket_perms;
 allow inetd_child_t self:capability { setuid setgid };
+allow inetd_child_t self:dir search;
+allow inetd_child_t self:{ lnk_file file } { getattr read };
+
 files_search_home(inetd_child_t)
 
 manage_dirs_pattern(inetd_child_t,inetd_child_tmp_t,inetd_child_tmp_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
