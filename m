Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3KJUkFg027474
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 15:30:46 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3KJUjP1004272
	for <selinux@tycho.nsa.gov>; Fri, 20 Apr 2007 19:30:45 GMT
From: dwalsh@redhat.com
Date: Fri, 20 Apr 2007 15:30:43 -0400
Message-Id: <200704201930.l3KJUhev027327@redsox.boston.devel.redhat.com>
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: amtu policy/used for MLS Test suite, needs to run in the field
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- nsaserefpolicy/policy/modules/admin/amtu.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/admin/amtu.fc	2007-04-11 17:07:34.000000000 -0400
@@ -0,0 +1,3 @@
+
+/usr/bin/amtu    --    gen_context(system_u:object_r:amtu_exec_t,s0)
+
--- nsaserefpolicy/policy/modules/admin/amtu.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.12/policy/modules/admin/amtu.if	2007-04-11 17:07:34.000000000 -0400
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
+++ serefpolicy-2.5.12/policy/modules/admin/amtu.te	2007-04-11 17:07:34.000000000 -0400
@@ -0,0 +1,56 @@
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
+allow amtu_t self:capability { audit_write net_raw };
+allow amtu_t self:netlink_audit_socket { create nlmsg_relay read write };
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
