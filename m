Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l72IX2u3013790
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 14:33:02 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l72IX1OD012384
	for <selinux@tycho.nsa.gov>; Thu, 2 Aug 2007 18:33:01 GMT
Message-ID: <46B2235A.4090003@redhat.com>
Date: Thu, 02 Aug 2007 14:32:58 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: [PATCH] refpolicy: system_init changes]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

init booleans to allow daemons to dump core and talk to terminals

initrc needs to be able to change run level
remove commented out secsions

--- nsaserefpolicy/policy/modules/system/init.te	2007-07-25 10:37:42.000000000 -0400
+++ serefpolicy-3.0.4/policy/modules/system/init.te	2007-07-25 12:27:26.000000000 -0400
@@ -10,6 +10,20 @@
 # Declarations
 #
 
+## <desc>
+## <p>
+## Allow all daemons the ability to use unallocated ttys
+## </p>
+## </desc>
+gen_tunable(allow_daemons_use_tty,false)
+
+## <desc>
+## <p>
+## Allow all daemons to write corefiles to /
+## </p>
+## </desc>
+gen_tunable(allow_daemons_dump_core,false)
+
 # used for direct running of init scripts
 # by admin domains
 attribute direct_run_init;
@@ -73,7 +87,7 @@
 #
 
 # Use capabilities. old rule:
-allow init_t self:capability ~sys_module;
+allow init_t self:capability ~{ audit_control audit_write sys_module };
 # is ~sys_module really needed? observed: 
 # sys_boot
 # sys_tty_config
@@ -189,7 +203,7 @@
 #
 
 allow initrc_t self:process { getpgid setsched setpgid setrlimit getsched };
-allow initrc_t self:capability ~{ sys_admin sys_module };
+allow initrc_t self:capability ~{ audit_control audit_write sys_admin sys_module };
 dontaudit initrc_t self:capability sys_module; # sysctl is triggering this
 allow initrc_t self:passwd rootok;
 
@@ -204,8 +218,7 @@
 allow initrc_t initrc_devpts_t:chr_file rw_term_perms;
 term_create_pty(initrc_t,initrc_devpts_t)
 
-# Going to single user mode
-init_exec(initrc_t)
+init_telinit(initrc_t)
 
 can_exec(initrc_t,initrc_exec_t)
 
@@ -501,6 +514,39 @@
 ')
 
 optional_policy(`
+	rhgb_use_ptys(daemon)
+')
+
+domain_dontaudit_use_interactive_fds(daemon)
+
+ifdef(`targeted_policy',`
+	domain_subj_id_change_exemption(initrc_t)
+
+	tunable_policy(`allow_daemons_use_tty',`
+		term_use_unallocated_ttys(daemon)
+		term_use_generic_ptys(daemon)
+ 	', `
+		term_dontaudit_use_unallocated_ttys(daemon)
+		term_dontaudit_use_generic_ptys(daemon)
+ 	')
+ 
+	# system-config-services causes avc messages that should be dontaudited
+ 	tunable_policy(`allow_daemons_dump_core',`
+ 		files_dump_core(daemon)
+  	')
+')
+
+optional_policy(`
+	unconfined_dontaudit_rw_pipes(daemon)
+
+	tunable_policy(`allow_daemons_use_tty',`
+		unconfined_use_terminals(daemon)
+ 	', `
+		unconfined_dontaudit_use_terminals(daemon)
+ 	')
+')
+ 
+optional_policy(`
 	amavis_search_lib(initrc_t)
 	amavis_setattr_pid_files(initrc_t)
 ')
@@ -636,12 +682,6 @@
 	mta_read_config(initrc_t)
 	mta_dontaudit_read_spool_symlinks(initrc_t)
 ')
-# cjp: require doesnt work in the else of optionals :\
-# this also would result in a type transition
-# conflict if sendmail is enabled
-#optional_policy(`',`
-#	mta_send_mail(initrc_t)
-#')
 
 optional_policy(`
 	ifdef(`distro_redhat',`
@@ -707,6 +747,9 @@
 
 	# why is this needed:
 	rpm_manage_db(initrc_t)
+	# Allow SELinux aware applications to request rpm_script_t execution
+	rpm_transition_script(initrc_t)
+
 ')
 
 optional_policy(`


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
