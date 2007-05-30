Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHaqcL013758
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:36:52 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHao2p008207
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:36:50 GMT
Date: Wed, 30 May 2007 11:30:43 -0400
Message-Id: <200705301530.l4UFUhob010631@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: admin_amtu changes
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can you upstream this policy?

--- nsaserefpolicy/policy/modules/admin/amtu.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/admin/amtu.fc	2007-05-30 09:25:53.000000000 -0400
@@ -0,0 +1,3 @@
+
+/usr/bin/amtu    --    gen_context(system_u:object_r:amtu_exec_t,s0)
+
--- nsaserefpolicy/policy/modules/admin/amtu.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/admin/amtu.if	2007-05-30 09:25:53.000000000 -0400
@@ -0,0 +1,53 @@
+## <summary>
+##	abstract Machine Test Utility 
+## </summary>
+
+########################################
+## <summary>
+##	Execute amtu in the amtu domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+#
+interface(`amtu_domtrans',`
+	gen_require(`
+		type amtu_t, amtu_exec_t;
+	')
+
+	corecmd_search_bin($1)
+	domtrans_pattern($1,amtu_exec_t,amtu_t)
+')
+
+########################################
+## <summary>
+##	Execute amtu in the amtu domain, and
+##	allow the specified role the amtu domain.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	The type of the process performing this action.
+##	</summary>
+## </param>
+## <param name="role">
+##	<summary>
+##	The role to be allowed the amtu domain.
+##	</summary>
+## </param>
+## <param name="terminal">
+##	<summary>
+##	The type of the terminal allow the amtu domain to use.
+##	</summary>
+## </param>
+#
+interface(`amtu_run',`
+	gen_require(`
+		type amtu_t;
+	')
+
+	amtu_domtrans($1)
+	role $2 types amtu_t;
+	allow amtu_t $3:chr_file rw_term_perms;
+')
--- nsaserefpolicy/policy/modules/admin/amtu.te	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-3.0.1/policy/modules/admin/amtu.te	2007-05-30 09:25:53.000000000 -0400
@@ -0,0 +1,57 @@
+policy_module(amtu,1.0.23)
+
+########################################
+#
+# Declarations
+#
+
+type amtu_t;
+type amtu_exec_t;
+domain_type(amtu_t)
+domain_entry_file(amtu_t, amtu_exec_t)
+
+########################################
+#
+# amtu local policy
+#
+
+# Specific allow rules required for amtu
+allow amtu_t self:capability net_raw;
+allow amtu_t self:packet_socket { bind create read write };
+allow amtu_t self:udp_socket { create ioctl };
+
+files_manage_boot_files(amtu_t)
+files_read_etc_runtime_files(amtu_t)
+files_read_etc_files(amtu_t)
+
+kernel_read_system_state(amtu_t)
+
+libs_use_ld_so(amtu_t)
+libs_use_shared_libs(amtu_t)
+
+logging_send_audit_msg(amtu_t)
+
+optional_policy(`
+    seutil_use_newrole_fds(amtu_t)
+');
+
+optional_policy(`
+    userdom_use_sysadm_fds(amtu_t)
+');
+
+optional_policy(`
+    userdom_sigchld_sysadm(amtu_t)
+');
+
+optional_policy(`
+    nscd_dontaudit_search_pid(amtu_t)
+');
+
+optional_policy(`
+    kernel_dontaudit_read_system_state(amtu_t)
+');
+
+optional_policy(`
+    term_dontaudit_search_ptys(amtu_t)
+');
+

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
