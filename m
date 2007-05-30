Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHpUdY016171
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:51:31 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHpSue005771
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:51:28 GMT
Date: Wed, 30 May 2007 10:16:26 -0400
Message-Id: <200705301416.l4UEGQM9007723@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Changes to xserver
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Remove unconfined_domain
Remove ifdef strict_policy
execmem execstack no longer needed 

--- nsaserefpolicy/policy/modules/services/xserver.if	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/xserver.if	2007-05-30 09:08:15.000000000 -0400
@@ -154,6 +154,8 @@
 
 	modutils_domtrans_insmod($1_xserver_t)
 
+	selinux_get_fs_mount($1_xserver_t)
+
 	seutil_dontaudit_search_config($1_xserver_t)
 
 	sysnet_read_config($1_xserver_t)
@@ -732,12 +734,8 @@
 		attribute xauth_home_type;
 	')
 
-	ifdef(`strict_policy',`
-		allow $1 xauth_home_type:file read_file_perms;
-		userdom_search_all_users_home_dirs($1)
-	',`
-		userdom_read_generic_user_home_content_files($1)
-	')
+	allow $1 xauth_home_type:file read_file_perms;
+	userdom_search_all_users_home_dirs($1)
 ')
 
 ########################################
@@ -1136,7 +1134,7 @@
 		type xdm_xserver_tmp_t;
 	')
 
-	allow $1 xdm_xserver_tmp_t:file { getattr read };
+	read_files_pattern($1,xdm_xserver_tmp_t,xdm_xserver_tmp_t)
 ')
 
 ########################################
--- nsaserefpolicy/policy/modules/services/xserver.te	2007-05-29 14:10:57.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/services/xserver.te	2007-05-30 09:08:15.000000000 -0400
@@ -305,6 +305,8 @@
 
 optional_policy(`
 	consolekit_dbus_chat(xdm_t)
+	dbus_system_bus_client_template(xdm, xdm_t)
+	dbus_send_system_bus(xdm_t)
 ')
 
 optional_policy(`
@@ -347,13 +349,7 @@
 ')
 
 optional_policy(`
-	unconfined_domain(xdm_t)
 	unconfined_domtrans(xdm_t)
-	userdom_generic_user_home_dir_filetrans_generic_user_home_content(xdm_t, {file dir })
-
-	ifndef(`distro_redhat',`
-		allow xdm_t self:process { execheap execmem };
-	')
 
 	ifdef(`distro_rhel4',`
 		allow xdm_t self:process { execheap execmem };
@@ -434,41 +430,15 @@
 ')
 
 optional_policy(`
-	unconfined_domain_noaudit(xdm_xserver_t)
 	unconfined_domtrans(xdm_xserver_t)
 
-	ifndef(`distro_redhat',`
-		allow xdm_xserver_t self:process { execheap execmem };
-	')
-
 	ifdef(`distro_rhel4',`
 		allow xdm_xserver_t self:process { execheap execmem };
 	')
 ')
 
-ifdef(`TODO',`
-# Need to further investigate these permissions and
-# perhaps define derived types.
-allow xdm_t var_lib_t:dir { write search add_name remove_name  create unlink };
-allow xdm_t var_lib_t:file { create write unlink };
-
-# Do not audit attempts to write to index files under /usr
-dontaudit xdm_t usr_t:file write;
-
-ifdef(`rhgb.te', `
-allow xdm_xserver_t ramfs_t:dir rw_dir_perms;
-allow xdm_xserver_t ramfs_t:file manage_file_perms;
-allow rhgb_t xdm_xserver_t:process signal;
-')
-
-tunable_policy(`allow_polyinstantiation',`
-# xdm needs access for linking .X11-unix to poly /tmp
-allow xdm_t polymember:dir { add_name remove_name write };
-allow xdm_t polymember:lnk_file { create unlink };
-# xdm needs access for copying .Xauthority into new home
-allow xdm_t polymember:file { create getattr write };
-')
 
+ifdef(`TODO',`
 #
 # Wants to delete .xsession-errors file
 #

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
