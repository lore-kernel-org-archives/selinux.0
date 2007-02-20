Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KGxGh5001731
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 11:59:16 -0500
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1KH0WQc019774
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:00:33 GMT
Message-ID: <45DB2920.6000709@redhat.com>
Date: Tue, 20 Feb 2007 12:00:16 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Changes to init for policy
Content-Type: multipart/mixed;
 boundary="------------010608050502070600010007"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010608050502070600010007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Added init_exec to init_telinit interface

Added daemon attribute so we can add general rules around daemons.  Like 
allowing/disallowing
daemons to talk to terminals.

ricci_modservice needs to be able to manipulate initrc_exec_t scripts.

Remove strict policy ifdef.



--------------010608050502070600010007
Content-Type: text/x-patch;
 name="nsaserefpolicy_policy_modules_system_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsaserefpolicy_policy_modules_system_init.patch"

--- nsaserefpolicy/policy/modules/system/init.if	2007-01-02 12:57:49.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/system/init.if	2007-02-20 10:24:13.000000000 -0500
@@ -202,11 +202,14 @@
 	gen_require(`
 		type initrc_t;
 		role system_r;
+		attribute daemon;
 	')
 
 	domain_type($1)
 	domain_entry_file($1,$2)
 
+	typeattribute $1 daemon;
+
 	role system_r types $1;
 
 	domtrans_pattern(initrc_t,$2,$1)
@@ -489,6 +492,7 @@
 
 	dev_list_all_dev_nodes($1)
 	allow $1 initctl_t:fifo_file rw_fifo_file_perms;
+	can_exec($1,init_exec_t)
 ')
 
 ########################################
@@ -1275,3 +1279,62 @@
 	files_search_pids($1)
 	allow $1 initrc_var_run_t:file manage_file_perms;
 ')
+
+########################################
+## <summary>
+##	Read init scripts.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_create_script_files',`
+	gen_require(`
+		type initrc_exec_t;
+	')
+
+	files_etc_filetrans($1, initrc_exec_t, file)
+	allow $1 initrc_exec_t:file create_file_perms;
+	allow $1 initrc_exec_t:file r_file_perms;
+')
+
+########################################
+## <summary>
+##	Read the process state (/proc/pid) of init.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_read_init_state',`
+	gen_require(`
+		attribute init_t;
+	')
+
+	allow $1 init_t:dir search_dir_perms;
+	read_files_pattern($1,init_t, init_t)
+	read_lnk_files_pattern($1,init_t, init_t)
+')
+
+########################################
+## <summary>
+##	Ptrace init
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+## <rolecap/>
+#
+interface(`init_ptrace_init_domain',`
+	gen_require(`
+		attribute init_t;
+	')
+
+	allow $1 init_t:process ptrace;
+')
--- nsaserefpolicy/policy/modules/system/init.te	2007-02-19 11:32:53.000000000 -0500
+++ serefpolicy-2.5.4/policy/modules/system/init.te	2007-02-20 10:27:56.000000000 -0500
@@ -205,8 +205,7 @@
 allow initrc_t initrc_devpts_t:chr_file rw_term_perms;
 term_create_pty(initrc_t,initrc_devpts_t)
 
-# Going to single user mode
-init_exec(initrc_t)
+init_telinit(initrc_t)
 
 can_exec(initrc_t,initrc_exec_t)
 
@@ -500,6 +502,12 @@
 	')
 ')
 
+optional_policy(`
+	rhgb_use_ptys(daemon)
+')
+
+domain_dontaudit_use_interactive_fds(daemon)
+
 ifdef(`targeted_policy',`
 	domain_subj_id_change_exemption(initrc_t)
 	unconfined_domain(initrc_t)
@@ -512,11 +520,21 @@
 	tunable_policy(`allow_daemons_use_tty',`
 		term_use_unallocated_ttys(daemon)
 		term_use_generic_ptys(daemon)
-	')
-
+ 		unconfined_rw_pipes(daemon)
+ 	', `
+ 		# system-config-services causes avc messages that should be dontaudited
+ 		unconfined_dontaudit_rw_pipes(daemon)
+ 
+ 	')
+ 
 	optional_policy(`
 		mono_domtrans(initrc_t)
 	')
+
+ 	tunable_policy(`allow_daemons_dump_core',`
+ 		files_dump_core(daemon)
+  	')
+
 ',`
 	# cjp: require doesnt work in the else of optionals :\
 	# this also would result in a type transition
@@ -727,6 +745,9 @@
 
 	# why is this needed:
 	rpm_manage_db(initrc_t)
+	# Allow SELinux aware applications to request rpm_script_t execution
+	rpm_transition_script(initrc_t)
+
 ')
 
 optional_policy(`

--------------010608050502070600010007--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
