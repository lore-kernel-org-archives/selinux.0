Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p71D0YmI010971
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 09:00:34 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p71D0Xo7024855
	for <selinux@tycho.nsa.gov>; Mon, 1 Aug 2011 13:00:33 GMT
Message-ID: <4E36A370.40001@tresys.com>
Date: Mon, 1 Aug 2011 09:00:32 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: SELinux Mail List <selinux@tycho.nsa.gov>
CC: <qingtao.cao@windriver.com>, <harrytaurus2002@hotmail.com>
Subject: Error in monolithic role attribute
Content-Type: multipart/mixed;
	boundary="------------040705030001020407090909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--------------040705030001020407090909
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

I started the Refpolicy implementation for the new role attribute
support.  Unfortunately, I get the following error for monolithic policies:

/usr/bin/checkpolicy policy.conf -o policy.26
/usr/bin/checkpolicy:  loading policy configuration from policy.conf
checkpolicy: expand.c:721: role_fix_callback: Assertion `regular_role !=
((void *)0) && regular_role->flavor == 0' failed.
make: *** [policy.26] Aborted

With the same policy I get a similar error when running 'make validate'
in a modular build:

/usr/bin/semodule_expand tmp/test.lnk tmp/policy.bin
semodule_expand: expand.c:721: role_fix_callback: Assertion
`regular_role != ((void *)0) && regular_role->flavor == 0' failed.
make: *** [validate] Aborted

This is with last week's release of the toolchain.

You should be able to reproduce this by checking out current Refpolicy
and applying the attached patch.

For monolithic:
$ make conf
$ make MONOLITHIC=y.

For modular:

$ make conf
$ make validate

-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com

--------------040705030001020407090909
Content-Type: text/plain; name="refpolicy-roleattr.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="refpolicy-roleattr.diff"

diff --git a/policy/modules/admin/portage.if b/policy/modules/admin/portage.if
index 08b361b..f927f17 100644
--- a/policy/modules/admin/portage.if
+++ b/policy/modules/admin/portage.if
@@ -44,11 +44,11 @@ interface(`portage_domtrans',`
 #
 interface(`portage_run',`
 	gen_require(`
-		type portage_t, portage_fetch_t, portage_sandbox_t;
+		attribute_role portage_roles;
 	')
 
 	portage_domtrans($1)
-	role $2 types { portage_t portage_fetch_t portage_sandbox_t };
+	roleattribute $2 portage_roles;
 ')
 
 ########################################
diff --git a/policy/modules/admin/portage.te b/policy/modules/admin/portage.te
index 563c598..b5ceb47 100644
--- a/policy/modules/admin/portage.te
+++ b/policy/modules/admin/portage.te
@@ -12,6 +12,7 @@ policy_module(portage, 1.11.0)
 ## </desc>
 gen_tunable(portage_use_nfs, false)
 
+attribute_role portage_roles;
 
 type gcc_config_t;
 type gcc_config_exec_t;
@@ -24,6 +25,7 @@ application_domain(portage_t, portage_exec_t)
 domain_obj_id_change_exemption(portage_t)
 rsync_entry_type(portage_t)
 corecmd_shell_entry_type(portage_t)
+role portage_roles types portage_t;
 
 # portage compile sandbox domain
 type portage_sandbox_t;
@@ -31,12 +33,14 @@ application_domain(portage_sandbox_t, portage_exec_t)
 # the shell is the entrypoint if regular sandbox is disabled
 # portage_exec_t is the entrypoint if regular sandbox is enabled
 corecmd_shell_entry_type(portage_sandbox_t)
+role portage_roles types portage_sandbox_t;
 
 # portage package fetching domain
 type portage_fetch_t;
 application_type(portage_fetch_t)
 corecmd_shell_entry_type(portage_fetch_t)
 rsync_entry_type(portage_fetch_t)
+role portage_roles types portage_fetch_t;
 
 type portage_devpts_t;
 term_pty(portage_devpts_t)
@@ -107,7 +111,7 @@ files_list_all(gcc_config_t)
 init_dontaudit_read_script_status_files(gcc_config_t)
 
 libs_read_lib_files(gcc_config_t)
-libs_domtrans_ldconfig(gcc_config_t)
+libs_run_ldconfig(gcc_config_t, portage_roles)
 libs_manage_shared_libs(gcc_config_t)
 # gcc-config creates a temp dir for the libs
 libs_manage_lib_dirs(gcc_config_t)
@@ -177,27 +181,27 @@ auth_manage_shadow(portage_t)
 init_exec(portage_t)
 
 # run setfiles -r
-seutil_domtrans_setfiles(portage_t)
+seutil_run_setfiles(portage_t, portage_roles)
 # run semodule
-seutil_domtrans_semanage(portage_t)
+seutil_run_semanage(portage_t, portage_roles)
 
-portage_domtrans_gcc_config(portage_t)
+portage_run_gcc_config(portage_t, portage_roles)
 # if sesandbox is disabled, compiling is performed in this domain
 portage_compile_domain(portage_t)
 
 optional_policy(`
-	bootloader_domtrans(portage_t)
+	bootloader_run(portage_t, portage_roles)
 ')
 
 optional_policy(`
-	modutils_domtrans_depmod(portage_t)
-	modutils_domtrans_update_mods(portage_t)
+	modutils_run_depmod(portage_t, portage_roles)
+	modutils_run_update_mods(portage_t, portage_roles)
 	#dontaudit update_modules_t portage_tmp_t:dir search_dir_perms;
 ')
 
 optional_policy(`
-	usermanage_domtrans_groupadd(portage_t)
-	usermanage_domtrans_useradd(portage_t)
+	usermanage_run_groupadd(portage_t, portage_roles)
+	usermanage_run_useradd(portage_t, portage_roles)
 ')
 
 ifdef(`TODO',`
diff --git a/policy/modules/admin/rpm.if b/policy/modules/admin/rpm.if
index d33daa8..951d8f6 100644
--- a/policy/modules/admin/rpm.if
+++ b/policy/modules/admin/rpm.if
@@ -78,14 +78,11 @@ interface(`rpm_domtrans_script',`
 #
 interface(`rpm_run',`
 	gen_require(`
-		type rpm_t, rpm_script_t;
+		attribute_role rpm_roles;
 	')
 
 	rpm_domtrans($1)
-	role $2 types { rpm_t rpm_script_t };
-	seutil_run_loadpolicy(rpm_script_t, $2)
-	seutil_run_semanage(rpm_script_t, $2)
-	seutil_run_setfiles(rpm_script_t, $2)
+	roleattribute $2 rpm_roles;
 ')
 
 ########################################
diff --git a/policy/modules/admin/rpm.te b/policy/modules/admin/rpm.te
index 7d964bf..ad01a33 100644
--- a/policy/modules/admin/rpm.te
+++ b/policy/modules/admin/rpm.te
@@ -5,6 +5,8 @@ policy_module(rpm, 1.13.0)
 # Declarations
 #
 
+attribute_role rpm_roles;
+
 type debuginfo_exec_t;
 domain_entry_file(rpm_t, debuginfo_exec_t)
 
@@ -15,6 +17,7 @@ domain_obj_id_change_exemption(rpm_t)
 domain_role_change_exemption(rpm_t)
 domain_system_change_exemption(rpm_t)
 domain_interactive_fd(rpm_t)
+role rpm_roles types rpm_t;
 
 type rpm_file_t;
 files_type(rpm_file_t)
@@ -47,6 +50,7 @@ corecmd_bin_entry_type(rpm_script_t)
 domain_type(rpm_script_t)
 domain_entry_file(rpm_t, rpm_script_exec_t)
 domain_interactive_fd(rpm_script_t)
+role rpm_roles types rpm_script_t;
 role system_r types rpm_script_t;
 
 type rpm_script_tmp_t;
@@ -181,7 +185,7 @@ init_use_script_ptys(rpm_t)
 
 libs_exec_ld_so(rpm_t)
 libs_exec_lib_files(rpm_t)
-libs_domtrans_ldconfig(rpm_t)
+libs_run_ldconfig(rpm_t, rpm_roles)
 
 logging_send_syslog_msg(rpm_t)
 
@@ -210,7 +214,7 @@ optional_policy(`
 ')
 
 optional_policy(`
-	prelink_domtrans(rpm_t)
+	prelink_run(rpm_t, rpm_roles)
 ')
 
 optional_policy(`
@@ -326,18 +330,18 @@ init_telinit(rpm_script_t)
 
 libs_exec_ld_so(rpm_script_t)
 libs_exec_lib_files(rpm_script_t)
-libs_domtrans_ldconfig(rpm_script_t)
+libs_run_ldconfig(rpm_script_t, rpm_roles)
 
 logging_send_syslog_msg(rpm_script_t)
 
 miscfiles_read_localization(rpm_script_t)
 
-modutils_domtrans_depmod(rpm_script_t)
-modutils_domtrans_insmod(rpm_script_t)
+modutils_run_depmod(rpm_script_t, rpm_roles)
+modutils_run_insmod(rpm_script_t, rpm_roles)
 
-seutil_domtrans_loadpolicy(rpm_script_t)
-seutil_domtrans_setfiles(rpm_script_t)
-seutil_domtrans_semanage(rpm_script_t)
+seutil_run_loadpolicy(rpm_script_t, rpm_roles)
+seutil_run_setfiles(rpm_script_t, rpm_roles)
+seutil_run_semanage(rpm_script_t, rpm_roles)
 
 userdom_use_all_users_fds(rpm_script_t)
 
@@ -352,7 +356,7 @@ tunable_policy(`allow_execmem',`
 ')
 
 optional_policy(`
-	bootloader_domtrans(rpm_script_t)
+	bootloader_run(rpm_script_t, rpm_roles)
 ')
 
 optional_policy(`
@@ -360,7 +364,7 @@ optional_policy(`
 ')
 
 optional_policy(`
-	lvm_domtrans(rpm_script_t)
+	lvm_run(rpm_script_t, rpm_roles)
 ')
 
 optional_policy(`
@@ -368,8 +372,8 @@ optional_policy(`
 ')
 
 optional_policy(`
-	tzdata_domtrans(rpm_t)
-	tzdata_domtrans(rpm_script_t)
+	tzdata_run(rpm_t, rpm_roles)
+	tzdata_run(rpm_script_t, rpm_roles)
 ')
 
 optional_policy(`
@@ -390,6 +394,6 @@ optional_policy(`
 ')
 
 optional_policy(`
-	usermanage_domtrans_groupadd(rpm_script_t)
-	usermanage_domtrans_useradd(rpm_script_t)
+	usermanage_run_groupadd(rpm_script_t, rpm_roles)
+	usermanage_run_useradd(rpm_script_t, rpm_roles)
 ')
diff --git a/policy/modules/system/selinuxutil.if b/policy/modules/system/selinuxutil.if
index 170e2c7..2689213 100644
--- a/policy/modules/system/selinuxutil.if
+++ b/policy/modules/system/selinuxutil.if
@@ -1027,13 +1027,11 @@ interface(`seutil_domtrans_semanage',`
 #
 interface(`seutil_run_semanage',`
 	gen_require(`
-		type semanage_t;
+		attribute_role semanage_roles;
 	')
 
 	seutil_domtrans_semanage($1)
-	seutil_run_setfiles(semanage_t, $2)
-	seutil_run_loadpolicy(semanage_t, $2)
-	role $2 types semanage_t;
+	roleattribute $2 semanage_roles;
 ')
 
 ########################################
diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
index e252935..02a5cb8 100644
--- a/policy/modules/system/selinuxutil.te
+++ b/policy/modules/system/selinuxutil.te
@@ -12,6 +12,9 @@ gen_require(`
 attribute can_write_binary_policy;
 attribute can_relabelto_binary_policy;
 
+attribute_role semanage_roles;
+roleattribute system_r semanage_roles;
+
 #
 # selinux_config_t is the type applied to
 # /etc/selinux/config
@@ -89,7 +92,7 @@ type semanage_t;
 type semanage_exec_t;
 application_domain(semanage_t, semanage_exec_t)
 domain_interactive_fd(semanage_t)
-role system_r types semanage_t;
+role semanage_roles types semanage_t;
 
 type semanage_store_t;
 files_type(semanage_store_t)
@@ -468,8 +471,8 @@ miscfiles_read_localization(semanage_t)
 seutil_libselinux_linked(semanage_t)
 seutil_manage_file_contexts(semanage_t)
 seutil_manage_config(semanage_t)
-seutil_domtrans_setfiles(semanage_t)
-seutil_domtrans_loadpolicy(semanage_t)
+seutil_run_setfiles(semanage_t, semanage_roles)
+seutil_run_loadpolicy(semanage_t, semanage_roles)
 seutil_manage_bin_policy(semanage_t)
 seutil_use_newrole_fds(semanage_t)
 seutil_manage_module_store(semanage_t)
diff --git a/support/comment_move_decl.sed b/support/comment_move_decl.sed
index 20ffa6c..601c4f7 100644
--- a/support/comment_move_decl.sed
+++ b/support/comment_move_decl.sed
@@ -5,7 +5,7 @@
 /require \{/,/} # end require/b nextline
 /optional \{/,/} # end optional/b nextline
 
-/^[[:blank:]]*(attribute|type(alias)?) /s/^/# this line was moved by the build process: &/
+/^[[:blank:]]*(attribute(_role)?|type(alias)?) /s/^/# this line was moved by the build process: &/
 /^[[:blank:]]*(port|node|netif|genfs)con /s/^/# this line was moved by the build process: &/
 /^[[:blank:]]*fs_use_(xattr|task|trans) /s/^/# this line was moved by the build process: &/
 /^[[:blank:]]*sid /s/^/# this line was moved by the build process: &/
diff --git a/support/get_type_attr_decl.sed b/support/get_type_attr_decl.sed
index a113f21..69c6ccd 100644
--- a/support/get_type_attr_decl.sed
+++ b/support/get_type_attr_decl.sed
@@ -5,7 +5,7 @@
 /require \{/,/} # end require/b nextline
 /optional \{/,/} # end optional/b nextline
 
-/^[[:blank:]]*(attribute|type(alias)?|bool) /{
+/^[[:blank:]]*(attribute(_role)?|type(alias)?|bool) /{
 	s/^[[:blank:]]+//
 	p
 }

--------------040705030001020407090909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
