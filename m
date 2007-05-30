Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHauBR013830
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:56 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHar2p008245
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:53 GMT
Date: Wed, 30 May 2007 10:15:57 -0400
Message-Id: <200705301415.l4UEFvXv007719@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: rpc domains do not need to bubd to all ports, just rpc porst
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

If I create a file in a homedir in nfs it needs to transition properly

--- nsaserefpolicy/policy/modules/services/rpc.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/rpc.if	2007-05-30 09:08:15.000000000 -0400
@@ -89,8 +89,11 @@
 	# bind to arbitary unused ports
 	corenet_tcp_bind_generic_port($1_t)
 	corenet_udp_bind_generic_port($1_t)
-	corenet_udp_bind_reserved_port($1_t)
+	corenet_dontaudit_tcp_bind_all_ports($1_t)
+	corenet_dontaudit_udp_bind_all_ports($1_t)
 	corenet_sendrecv_generic_server_packets($1_t)
+	corenet_tcp_bind_all_rpc_ports($1_t)
+	corenet_udp_bind_all_rpc_ports($1_t)
 
 	fs_rw_rpc_named_pipes($1_t) 
 	fs_search_auto_mountpoints($1_t)
--- nsaserefpolicy/policy/modules/services/rpc.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/rpc.te	2007-05-30 09:08:15.000000000 -0400
@@ -79,6 +79,7 @@
 
 optional_policy(`
 	nis_read_ypserv_config(rpcd_t)
+	nis_use_ypbind(rpcd_t)
 ')
 
 ########################################
@@ -123,6 +124,7 @@
 tunable_policy(`nfs_export_all_rw',`
 	fs_read_noxattr_fs_files(nfsd_t) 
 	auth_manage_all_files_except_shadow(nfsd_t)
+	userdom_generic_user_home_dir_filetrans_generic_user_home_content(nfsd_t, { file dir })
 ')
 
 tunable_policy(`nfs_export_all_ro',`
@@ -159,8 +161,6 @@
 miscfiles_read_certs(gssd_t)
 
 ifdef(`targeted_policy',`
-	files_read_generic_tmp_files(gssd_t) 
-	files_read_generic_tmp_symlinks(gssd_t) 
 	# Manage the users kerberos tgt file
 	files_manage_generic_tmp_files(gssd_t) 
 ')

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
