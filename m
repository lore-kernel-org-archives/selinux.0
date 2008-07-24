Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6O0OFZS018577
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2008 20:24:16 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6O0OF4b023811
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 00:24:15 GMT
Message-ID: <4887CBA8.2020801@redhat.com>
Date: Wed, 23 Jul 2008 20:24:08 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Chris PeBenito <pebenito@gentoo.org>
CC: david@hardeman.nu, selinux@tycho.nsa.gov
Subject: Re: [refpolicy-patch 14/23] rhgb policy update
References: <20080719205002.462190042@hardeman.nu>	 <20080719210253.302868396@hardeman.nu> <1216758563.4954.35.camel@defiant.pebenito.net>
In-Reply-To: <1216758563.4954.35.camel@defiant.pebenito.net>
Content-Type: multipart/mixed;
 boundary="------------000904010600030304020208"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000904010600030304020208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Chris PeBenito wrote:
> On Sat, 2008-07-19 at 22:50 +0200, david@hardeman.nu wrote:
>> plain text document attachment (policy_modules_services_rhgb.patch)
>> rhgb (RedHat Graphical Boot) is RH specific so this should be uncontroversial...
>>
>> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rhgb.if serefpolicy-3.5.0/policy/modules/services/rhgb.if
>> --- nsaserefpolicy/policy/modules/services/rhgb.if	2008-07-10 11:38:46.000000000 -0400
>> +++ serefpolicy-3.5.0/policy/modules/services/rhgb.if	2008-07-15 14:05:13.000000000 -0400
>> @@ -4,7 +4,7 @@
>>  ## <summary>
>>  ##	RHGB stub interface.  No access allowed.
>>  ## </summary>
>> -## <param name="domain" unused="true">
>> +## <param name="domain">
>>  ##	<summary>
>>  ##	N/A
>>  ##	</summary>
> 
> This reverses an upstream change.
> 
>> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/services/rhgb.te serefpolicy-3.5.0/policy/modules/services/rhgb.te
>> --- nsaserefpolicy/policy/modules/services/rhgb.te	2008-07-10 11:38:46.000000000 -0400
>> +++ serefpolicy-3.5.0/policy/modules/services/rhgb.te	2008-07-15 14:05:13.000000000 -0400
>> @@ -92,6 +92,7 @@
>>  term_getattr_pty_fs(rhgb_t)
>>  
>>  init_write_initctl(rhgb_t)
>> +init_chat(rhgb_t)
>>  
>>  libs_use_ld_so(rhgb_t)
>>  libs_use_shared_libs(rhgb_t)
> 
> This interface doesn't exist.
> 
Here is the patch I sent you a couple of weeks ago with the init_chat
patch.  This patch also includes the critical change to using labeled
initrc scripts.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkiHy6gACgkQrlYvE4MpobNo2gCgnDQuCMROpY8tO5+kJpKjgu2t
0hMAoIEKVK9/jQ8k+PM5sfAOxtNoHgCe
=Jiew
-----END PGP SIGNATURE-----

--------------000904010600030304020208
Content-Type: text/plain;
 name="system_init.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="system_init.patch"

--- nsaserefpolicy/policy/modules/system/init.fc	2008-06-12 23:25:07.000000000 -0400
+++ serefpolicy-3.5.1/policy/modules/system/init.fc	2008-07-23 20:17:11.000000000 -0400
@@ -4,8 +4,7 @@
 /etc/init\.d/.*		--	gen_context(system_u:object_r:initrc_exec_t,s0)
 
 /etc/rc\.d/rc		--	gen_context(system_u:object_r:initrc_exec_t,s0)
-/etc/rc\.d/rc\.sysinit	--	gen_context(system_u:object_r:initrc_exec_t,s0)
-/etc/rc\.d/rc\.local	--	gen_context(system_u:object_r:initrc_exec_t,s0)
+/etc/rc\.d/rc\.[^/]+	--	gen_context(system_u:object_r:initrc_exec_t,s0)
 
 /etc/rc\.d/init\.d/.*	--	gen_context(system_u:object_r:initrc_exec_t,s0)
 
--- nsaserefpolicy/policy/modules/system/init.if	2008-07-16 10:26:25.000000000 -0400
+++ serefpolicy-3.5.1/policy/modules/system/init.if	2008-07-23 20:17:11.000000000 -0400
@@ -211,6 +211,19 @@
 			kernel_dontaudit_use_fds($1)
 		')
 	')
+
+	sysadm_dontaudit_search_home_dirs($1)
+
+	tunable_policy(`allow_daemons_use_tty',`
+	   term_use_all_user_ttys($1)
+	   term_use_all_user_ptys($1)
+	', `
+	   term_dontaudit_use_all_user_ttys($1)
+	   term_dontaudit_use_all_user_ptys($1)
+	 ')
+
+	 # these apps are often redirect output to random log files
+	 logging_rw_all_logs($1)
 ')
 
 ########################################
@@ -550,18 +563,19 @@
 #
 interface(`init_spec_domtrans_script',`
 	gen_require(`
-		type initrc_t, initrc_exec_t;
+		type initrc_t;
+		attribute initscript;
 	')
 
 	files_list_etc($1)
-	spec_domtrans_pattern($1,initrc_exec_t,initrc_t)
+	spec_domtrans_pattern($1,initscript,initrc_t)
 
 	ifdef(`enable_mcs',`
-		range_transition $1 initrc_exec_t:process s0;
+		range_transition $1 initscript:process s0;
 	')
 
 	ifdef(`enable_mls',`
-		range_transition $1 initrc_exec_t:process s0 - mls_systemhigh;
+		range_transition $1 initscript:process s0 - mls_systemhigh;
 	')
 ')
 
@@ -577,19 +591,66 @@
 #
 interface(`init_domtrans_script',`
 	gen_require(`
-		type initrc_t, initrc_exec_t;
+		type initrc_t;
+		attribute initscript;
+	')
+
+	files_list_etc($1)
+	domtrans_pattern($1,initscript,initrc_t)
+
+	ifdef(`enable_mcs',`
+		range_transition $1 initscript:process s0;
+	')
+
+	ifdef(`enable_mls',`
+		range_transition $1 initscript:process s0 - mls_systemhigh;
+	')
+')
+
+########################################
+## <summary>
+##	Execute init a specific script with an automatic domain transition.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_script_domtrans_spec',`
+	gen_require(`
+		type initrc_t;
 	')
 
 	files_list_etc($1)
-	domtrans_pattern($1,initrc_exec_t,initrc_t)
+	domtrans_pattern($1,$2,initrc_t)
 
 	ifdef(`enable_mcs',`
-		range_transition $1 initrc_exec_t:process s0;
+		range_transition $1 $2:process s0;
 	')
 
 	ifdef(`enable_mls',`
-		range_transition $1 initrc_exec_t:process s0 - mls_systemhigh;
+		range_transition $1 $2:process s0 - mls_systemhigh;
+	')
+')
+
+########################################
+## <summary>
+##	Execute a file in a bin directory
+##	in the initrc_t domain 
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_bin_domtrans_spec',`
+	gen_require(`
+		type initrc_t;
 	')
+
+	corecmd_bin_domtrans($1, initrc_t)
 ')
 
 ########################################
@@ -619,11 +680,11 @@
 # cjp: added for gentoo integrated run_init
 interface(`init_script_file_domtrans',`
 	gen_require(`
-		type initrc_exec_t;
+		attribute initscript;
 	')
 
 	files_list_etc($1)
-	domain_auto_trans($1,initrc_exec_t,$2)
+	domain_auto_trans($1,initscript,$2)
 ')
 
 ########################################
@@ -694,11 +755,11 @@
 #
 interface(`init_getattr_script_files',`
 	gen_require(`
-		type initrc_exec_t;
+		attribute initscript;
 	')
 
 	files_list_etc($1)
-	allow $1 initrc_exec_t:file getattr;
+	allow $1 initscript:file getattr;
 ')
 
 ########################################
@@ -713,11 +774,11 @@
 #
 interface(`init_exec_script_files',`
 	gen_require(`
-		type initrc_exec_t;
+		attribute initscript;
 	')
 
 	files_list_etc($1)
-	can_exec($1,initrc_exec_t)
+	can_exec($1,initscript)
 ')
 
 ########################################
@@ -941,6 +1002,7 @@
 
 	dontaudit $1 initrc_t:unix_stream_socket connectto;
 ')
+
 ########################################
 ## <summary>
 ##	Send messages to init scripts over dbus.
@@ -1040,11 +1102,11 @@
 #
 interface(`init_read_script_files',`
 	gen_require(`
-		type initrc_exec_t;
+		attribute initscript;
 	')
 
 	files_search_etc($1)
-	allow $1 initrc_exec_t:file read_file_perms;
+	allow $1 initscript:file read_file_perms;
 ')
 
 ########################################
@@ -1107,6 +1169,25 @@
 
 ########################################
 ## <summary>
+##	Read init script temporary data.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_read_script_tmp_files',`
+	gen_require(`
+		type initrc_tmp_t;
+	')
+
+	files_search_tmp($1)
+	read_files_pattern($1,initrc_tmp_t,initrc_tmp_t)
+')
+
+########################################
+## <summary>
 ##	Create files in a init script
 ##	temporary data directory.
 ## </summary>
@@ -1262,7 +1343,7 @@
 		type initrc_var_run_t;
 	')
 
-	dontaudit $1 initrc_var_run_t:file { getattr read write append };
+	dontaudit $1 initrc_var_run_t:file rw_file_perms;
 ')
 
 ########################################
@@ -1283,3 +1364,113 @@
 	files_search_pids($1)
 	allow $1 initrc_var_run_t:file manage_file_perms;
 ')
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
+	allow $1 init_t:file read_file_perms;
+	allow $1 init_t:lnk_file read_file_perms;
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
+
+########################################
+## <summary>
+##	Make the specified type usable for initscripts
+##	in a filesystem.
+## </summary>
+## <param name="type">
+##	<summary>
+##	Type to be used for files.
+##	</summary>
+## </param>
+#
+interface(`init_script_type',`
+	gen_require(`
+		type initrc_t;
+		attribute initscript;
+	')
+
+	typeattribute $1 initscript;
+	domain_entry_file(initrc_t,$1)
+
+')
+
+########################################
+## <summary>
+##	Transition to system_r when execute an init script
+## </summary>
+## <desc>
+##      <p>
+##	Execute a init script in a specified role
+##      </p>
+##      <p>
+##      No interprocess communication (signals, pipes,
+##      etc.) is provided by this interface since
+##      the domains are not owned by this module.
+##      </p>
+## </desc>
+## <param name="source_role">
+##	<summary>
+##	Role to transition from.
+##	</summary>
+## </param>
+# cjp: added for gentoo integrated run_init
+interface(`init_script_role_transition',`
+	gen_require(`
+		attribute initscript;
+	')
+
+	role_transition $1 initscript system_r;
+')
+
+########################################
+## <summary>
+##	Send and receive unix_stream_messages with 
+##	init
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`init_chat',`
+	gen_require(`
+		type init_t;
+	')
+
+	allow $1 init_t:unix_dgram_socket sendto;
+	allow init_t $1:unix_dgram_socket sendto;
+')
+
--- nsaserefpolicy/policy/modules/system/init.te	2008-07-16 10:33:56.000000000 -0400
+++ serefpolicy-3.5.1/policy/modules/system/init.te	2008-07-23 20:17:11.000000000 -0400
@@ -17,6 +17,20 @@
 ## </desc>
 gen_tunable(init_upstart,false)
 
+## <desc>
+## <p>
+## Allow all daemons the ability to read/write terminals
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
@@ -26,6 +40,8 @@
 # Mark process types as daemons
 attribute daemon;
 
+attribute initscript;
+
 #
 # init_t is the domain of the init process.
 #
@@ -52,7 +68,7 @@
 mls_trusted_object(initctl_t)
 
 type initrc_t;
-type initrc_exec_t;
+type initrc_exec_t, initscript;
 domain_type(initrc_t)
 domain_entry_file(initrc_t,initrc_exec_t)
 role system_r types initrc_t;
@@ -84,7 +100,7 @@
 #
 
 # Use capabilities. old rule:
-allow init_t self:capability ~sys_module;
+allow init_t self:capability ~{ audit_control audit_write sys_module };
 # is ~sys_module really needed? observed: 
 # sys_boot
 # sys_tty_config
@@ -97,7 +113,7 @@
 # Re-exec itself
 can_exec(init_t,init_exec_t)
 
-allow init_t initrc_t:unix_stream_socket connectto;
+allow init_t initrc_t:unix_stream_socket { connectto rw_stream_socket_perms };
 
 # For /var/run/shutdown.pid.
 allow init_t init_var_run_t:file manage_file_perms;
@@ -113,6 +129,8 @@
 kernel_read_system_state(init_t)
 kernel_share_state(init_t)
 
+fs_list_inotifyfs(init_t)
+
 corecmd_exec_chroot(init_t)
 corecmd_exec_bin(init_t)
 
@@ -165,6 +183,8 @@
 
 miscfiles_read_localization(init_t)
 
+allow init_t self:process setsched;
+
 ifdef(`distro_gentoo',`
 	allow init_t self:process { getcap setcap };
 ')
@@ -187,6 +207,14 @@
 ')
 
 optional_policy(`
+	# /var/run/dovecot/login/ssl-parameters.dat is a hard link to
+	# /var/lib/dovecot/ssl-parameters.dat and init tries to clean up
+	# the directory. But we do not want to allow this.
+	# The master process of dovecot will manage this file.
+	dovecot_dontaudit_unlink_lib_files(initrc_t)
+')
+
+optional_policy(`
 	nscd_socket_use(init_t)
 ')
 
@@ -200,7 +228,7 @@
 #
 
 allow initrc_t self:process { getpgid setsched setpgid setrlimit getsched };
-allow initrc_t self:capability ~{ sys_admin sys_module };
+allow initrc_t self:capability ~{ audit_control audit_write sys_admin sys_module };
 dontaudit initrc_t self:capability sys_module; # sysctl is triggering this
 allow initrc_t self:passwd rootok;
 
@@ -214,10 +242,10 @@
 allow initrc_t initrc_devpts_t:chr_file rw_term_perms;
 term_create_pty(initrc_t,initrc_devpts_t)
 
-# Going to single user mode
-init_exec(initrc_t)
+init_telinit(initrc_t)
+init_chat(initrc_t)
 
-can_exec(initrc_t,initrc_exec_t)
+can_exec(initrc_t,initscript)
 
 manage_dirs_pattern(initrc_t,initrc_state_t,initrc_state_t)
 manage_files_pattern(initrc_t,initrc_state_t,initrc_state_t)
@@ -270,7 +298,7 @@
 dev_read_sound_mixer(initrc_t)
 dev_write_sound_mixer(initrc_t)
 dev_setattr_all_chr_files(initrc_t)
-dev_read_lvm_control(initrc_t)
+dev_rw_lvm_control(initrc_t)
 dev_delete_lvm_control_dev(initrc_t)
 dev_manage_generic_symlinks(initrc_t)
 dev_manage_generic_files(initrc_t)
@@ -515,6 +543,31 @@
 	')
 ')
 
+domain_dontaudit_use_interactive_fds(daemon)
+
+sysadm_dontaudit_search_home_dirs(daemon)
+
+tunable_policy(`allow_daemons_use_tty',`
+	term_use_unallocated_ttys(daemon)
+	term_use_generic_ptys(daemon)
+	term_use_all_user_ttys(daemon)
+	term_use_all_user_ptys(daemon)
+', `
+	term_dontaudit_use_unallocated_ttys(daemon)
+	term_dontaudit_use_generic_ptys(daemon)
+	term_dontaudit_use_all_user_ttys(daemon)
+	term_dontaudit_use_all_user_ptys(daemon)
+ ')
+ 
+# system-config-services causes avc messages that should be dontaudited
+tunable_policy(`allow_daemons_dump_core',`
+	files_dump_core(daemon)
+')
+
+optional_policy(`
+	unconfined_dontaudit_rw_pipes(daemon)
+')
+ 
 optional_policy(`
 	amavis_search_lib(initrc_t)
 	amavis_setattr_pid_files(initrc_t)
@@ -573,6 +626,10 @@
 	dbus_read_config(initrc_t)
 
 	optional_policy(`
+		consolekit_dbus_chat(initrc_t)
+	')
+
+	optional_policy(`
 		networkmanager_dbus_chat(initrc_t)
 	')
 ')
@@ -658,12 +715,6 @@
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
@@ -724,6 +775,9 @@
 
 	# why is this needed:
 	rpm_manage_db(initrc_t)
+	# Allow SELinux aware applications to request rpm_script_t execution
+	rpm_transition_script(initrc_t)
+
 ')
 
 optional_policy(`
@@ -736,9 +790,11 @@
 	squid_manage_logs(initrc_t)
 ')
 
-optional_policy(`
-	# allow init scripts to su
-	su_restricted_domain_template(initrc,initrc_t,system_r)
+ifndef(`targeted_policy',`
+	optional_policy(`
+		# allow init scripts to su
+		su_restricted_domain_template(initrc,initrc_t,system_r)
+	')
 ')
 
 optional_policy(`
@@ -757,6 +813,11 @@
 	uml_setattr_util_sockets(initrc_t)
 ')
 
+# Cron jobs used to start and stop services
+optional_policy(`
+	cron_rw_pipes(daemon)
+')
+
 optional_policy(`
 	unconfined_domain(initrc_t)
 
@@ -771,6 +832,10 @@
 ')
 
 optional_policy(`
+	rpm_dontaudit_rw_pipes(daemon)
+')
+
+optional_policy(`
 	vmware_read_system_config(initrc_t)
 	vmware_append_system_config(initrc_t)
 ')
@@ -793,3 +858,8 @@
 optional_policy(`
 	zebra_read_config(initrc_t)
 ')
+
+unprivuser_append_home_content_files(daemon)
+unprivuser_write_tmp_files(daemon)
+logging_append_all_logs(daemon)
+

--------------000904010600030304020208
Content-Type: application/octet-stream;
 name="system_init.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="system_init.patch.sig"

iEYEABECAAYFAkiHy6gACgkQrlYvE4MpobM15gCgoznifltydZjDACe0f81QyXAlTxAAn1UQ
CMtHA1fdgn9+QpPPJVDOLyK6
--------------000904010600030304020208--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
