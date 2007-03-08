Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l28EUmIw004065
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 09:30:48 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l28EUlko002402
	for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2007 14:30:47 GMT
Message-ID: <45F01E16.5070002@redhat.com>
Date: Thu, 08 Mar 2007 09:30:46 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: amtu policy
Content-Type: multipart/mixed;
 boundary="------------010802060002050903000501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010802060002050903000501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Mostly written by Emily Ratliff <ratliff@ratliff.net>

--------------010802060002050903000501
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_admin_amtu.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_admin_amtu.patch"

--- nsaserefpolicy/policy/modules/admin/amtu.fc	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/admin/amtu.fc	2007-03-08 08:42:36.000000000 -0500
@@ -0,0 +1,3 @@
+
+/usr/bin/amtu    --    gen_context(system_u:object_r:amtu_exec_t,s0)
+
--- nsaserefpolicy/policy/modules/admin/amtu.if	1969-12-31 19:00:00.000000000 -0500
+++ serefpolicy-2.5.8/policy/modules/admin/amtu.if	2007-03-08 08:42:36.000000000 -0500
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
+	corecmd_search_sbin($1)
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
+++ serefpolicy-2.5.8/policy/modules/admin/amtu.te	2007-03-08 08:42:36.000000000 -0500
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

--------------010802060002050903000501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
