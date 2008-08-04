Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m74CeQVV012575
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 08:40:26 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m74CeKpq014764
	for <selinux@tycho.nsa.gov>; Mon, 4 Aug 2008 12:40:21 GMT
Received: from basil.haag.hardeman.nu (nsabfw1.nsab.se [217.28.34.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "basil.haag.hardeman.nu", Issuer "hardeman.nu CA" (verified OK))
	by palpatine.hardeman.nu (Postfix) with ESMTP id B0A1926E
	for <selinux@tycho.nsa.gov>; Mon,  4 Aug 2008 14:40:23 +0200 (CEST)
Message-Id: <20080804123739.357107258@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
Date: Mon, 04 Aug 2008 14:35:25 +0200
From: david@hardeman.nu
To: selinux@tycho.nsa.gov
Subject: [patch 29/35] ipsec policy update
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ipsec changes including a new interface which is used by the sysnetwork
module...

Index: refpolicy/policy/modules/system/ipsec.if
===================================================================
--- refpolicy.orig/policy/modules/system/ipsec.if	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/ipsec.if	2008-08-03 21:32:40.000000000 +0200
@@ -150,6 +150,26 @@
 	manage_files_pattern($1,ipsec_var_run_t,ipsec_var_run_t)
 ')
 
+
+########################################
+## <summary>
+##	write the ipsec_var_run_t files.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`ipsec_write_pid',`
+	gen_require(`
+		type ipsec_var_run_t;
+	')
+
+	files_search_pids($1)
+	write_files_pattern($1,ipsec_var_run_t,ipsec_var_run_t)
+')
+
 ########################################
 ## <summary>
 ##	Execute racoon in the racoon domain.
Index: refpolicy/policy/modules/system/ipsec.te
===================================================================
--- refpolicy.orig/policy/modules/system/ipsec.te	2008-07-19 19:15:43.000000000 +0200
+++ refpolicy/policy/modules/system/ipsec.te	2008-08-03 21:33:27.000000000 +0200
@@ -69,8 +69,8 @@
 read_files_pattern(ipsec_t,ipsec_key_file_t,ipsec_key_file_t)
 read_lnk_files_pattern(ipsec_t,ipsec_key_file_t,ipsec_key_file_t)
 
-allow ipsec_t ipsec_var_run_t:file manage_file_perms;
-allow ipsec_t ipsec_var_run_t:sock_file manage_sock_file_perms;
+manage_files_pattern(ipsec_t, ipsec_var_run_t, ipsec_var_run_t)
+manage_sock_files_pattern(ipsec_t, ipsec_var_run_t, ipsec_var_run_t)
 files_pid_filetrans(ipsec_t,ipsec_var_run_t,{ file sock_file })
 
 can_exec(ipsec_t, ipsec_mgmt_exec_t)
Index: refpolicy/policy/modules/system/sysnetwork.te
===================================================================
--- refpolicy.orig/policy/modules/system/sysnetwork.te	2008-08-03 21:37:35.000000000 +0200
+++ refpolicy/policy/modules/system/sysnetwork.te	2008-08-03 21:38:27.000000000 +0200
@@ -332,6 +332,10 @@
 ')
 
 optional_policy(`
+	ipsec_write_pid(ifconfig_t)
+')
+
+optional_policy(`
 	kernel_read_xen_state(ifconfig_t)
 	kernel_write_xen_state(ifconfig_t)
 	xen_append_log(ifconfig_t)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
