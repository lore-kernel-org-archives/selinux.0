Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72KqKGF027142
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 16:52:20 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72KqJM1010326
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 20:52:19 GMT
Date: Thu, 2 Aug 2007 16:52:15 -0400
Message-Id: <200708022052.l72KqFwx000510@redsox.boston.devel.redhat.com>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: [PATCH] refpolicy: services_kerberos changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Kerberos using ldap

--- nsaserefpolicy/policy/modules/services/kerberos.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.5/policy/modules/services/kerberos.te	2007-08-02 11:02:02.000000000 -0400
@@ -91,6 +91,7 @@
 kernel_read_kernel_sysctls(kadmind_t)
 kernel_list_proc(kadmind_t)
 kernel_read_proc_symlinks(kadmind_t)
+kernel_read_system_state(kadmind_t)
 
 corenet_all_recvfrom_unlabeled(kadmind_t)
 corenet_all_recvfrom_netlabel(kadmind_t)
@@ -118,6 +119,9 @@
 domain_use_interactive_fds(kadmind_t)
 
 files_read_etc_files(kadmind_t)
+files_read_usr_symlinks(kadmind_t)
+files_read_usr_files(kadmind_t)
+files_read_var_files(kadmind_t)
 
 libs_use_ld_so(kadmind_t)
 libs_use_shared_libs(kadmind_t)
@@ -127,6 +131,7 @@
 miscfiles_read_localization(kadmind_t)
 
 sysnet_read_config(kadmind_t)
+sysnet_use_ldap(kadmind_t)
 
 userdom_dontaudit_use_unpriv_user_fds(kadmind_t)
 userdom_dontaudit_search_sysadm_home_dirs(kadmind_t)
@@ -223,6 +228,7 @@
 miscfiles_read_localization(krb5kdc_t)
 
 sysnet_read_config(krb5kdc_t)
+sysnet_use_ldap(krb5kdc_t)
 
 userdom_dontaudit_use_unpriv_user_fds(krb5kdc_t)
 userdom_dontaudit_search_sysadm_home_dirs(krb5kdc_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
