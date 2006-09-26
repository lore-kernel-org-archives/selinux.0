Subject: [PATCH] refpolicy: Add GConf policy
From: James Carter <jwcart2@tycho.nsa.gov>
Reply-To: jwcart2@tycho.nsa.gov
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SELinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 14:28:19 -0400
Message-Id: <1159295299.18973.74.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a GConf policy to refpolicy.  

This policy is much tighter than the GConf policy from the old example
policy.  It only allows gconfd to access configuration data stored by
GConf.  Users can modify configuration data using gconftool-2 or
gconf-editor, both of which use gconfd.  GConf manages multiple
configuration sources, so gconfd should be used to make any changes
anyway.  Normal users who aren't trying to directly edit the
configuration data of GConf won't notice anything different.

There is also a difference between this policy and the old example
policy in handling directories in /tmp.  The old example policy
labeled /tmp/gconfd-USER with ROLE_gconfd_tmp_t, but, since there was no
use of the file_type_auto_trans macro, if that directory was deleted
gconfd would create one labeled as tmp_t.  This policy uses the
files_tmp-filetrans macro to cause a directory in /tmp created by gconfd
to be labeled as $1_tmp_t.  It is not labeled with $1_gconf_tmp_t,
because if /tmp/orbit-USER is deleted, gconfd will create it (through
use of ORBit) and it would get the $1_gconf_tmp_t label.  By having
gconfd create $1_tmp_t directories in /tmp and $1_gconf_tmp_t files and
directories in directories labeled with $1_tmp_t, it can control its
data without requiring any future bonobo or Gnome policies to have
access to $1_gconf_tmp_t.

This patch is related to work that I am doing in making gconfd an
userspace object manager.  If any user program can modify the
configuration data that GConf stores, than making gconfd an userspace
object manager would be useless.

Signed-off-by:  James Carter <jwcart2@tycho.nsa.gov>

services/gconf.fc    |    8 +++
services/gconf.if    |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++
services/gconf.te    |   13 +++++
system/userdomain.if |    4 +
4 files changed, 143 insertions(+)

diff -X /home/jwcart2/dontdiff -rNu refpolicy/policy/modules/services/gconf.fc refpolicy.gconf/policy/modules/services/gconf.fc
--- refpolicy/policy/modules/services/gconf.fc	1969-12-31 19:00:00.000000000 -0500
+++ refpolicy.gconf/policy/modules/services/gconf.fc	2006-09-22 11:10:29.000000000 -0400
@@ -0,0 +1,8 @@
+/usr/libexec/gconfd-2 	--	gen_context(system_u:object_r:gconfd_exec_t,s0)
+/etc/gconf(/.*)?		gen_context(system_u:object_r:gconf_etc_t,s0)
+
+ifdef(`strict_policy',`
+HOME_DIR/\.gconf(d)?(/.*)?	gen_context(system_u:object_r:ROLE_gconf_home_t,s0)
+/tmp/gconfd-USER	-d	gen_context(system_u:object_r:ROLE_tmp_t,s0)
+/tmp/gconfd-USER/(.*)	--	gen_context(system_u:object_r:ROLE_gconf_tmp_t,s0)
+')
diff -X /home/jwcart2/dontdiff -rNu refpolicy/policy/modules/services/gconf.if refpolicy.gconf/policy/modules/services/gconf.if
--- refpolicy/policy/modules/services/gconf.if	1969-12-31 19:00:00.000000000 -0500
+++ refpolicy.gconf/policy/modules/services/gconf.if	2006-09-22 11:10:29.000000000 -0400
@@ -0,0 +1,118 @@
+## <summary>Gnome configuration system</summary>
+
+########################################
+## <summary>
+##	The per user domain template for the gconf module.
+## </summary>
+## <desc>
+##	<p>
+##	This template creates a derived domain which is used
+##	for gconf sessions.
+##	</p>
+##	<p>
+##	This template is invoked automatically for each user, and
+##	generally does not need to be invoked directly
+##	by policy writers.
+##	</p>
+## </desc>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+## <param name="user_domain">
+##	<summary>
+##	The type of the user domain.
+##	</summary>
+## </param>
+## <param name="user_role">
+##	<summary>
+##	The role associated with the user domain.
+##	</summary>
+## </param>
+#
+template(`gconf_per_userdomain_template',`
+	gen_require(`
+		type $1_tmp_t;
+	')
+
+	##############################
+	#
+	# Declarations
+	#
+	type $1_gconfd_t;
+	domain_type($1_gconfd_t)
+	role $3 types $1_gconfd_t;
+
+	type $1_gconf_home_t;
+	files_type($1_gconf_home_t)
+
+	type $1_gconf_tmp_t;
+	files_tmp_file($1_gconf_tmp_t)
+
+	##############################
+	#
+	# Local Policy
+	#
+	domain_entry_file($1_gconfd_t, gconfd_exec_t)
+	domain_auto_trans($2, gconfd_exec_t, $1_gconfd_t)
+	allow $1_gconfd_t self:process getsched;
+	allow $1_gconfd_t $2:fd use;
+	allow $1_gconfd_t $2:unix_stream_socket connectto;
+	allow $1_gconfd_t $2:fifo_file write;
+
+	libs_use_ld_so($1_gconfd_t)
+	libs_use_shared_libs($1_gconfd_t)
+	miscfiles_read_localization($1_gconfd_t)
+	dev_read_urand($1_gconfd_t)
+	logging_send_syslog_msg($1_gconfd_t)
+
+	userdom_user_home_dir_filetrans($1, $1_gconfd_t, $1_gconf_home_t, dir)
+	allow $1_gconfd_t $1_gconf_home_t:dir create_dir_perms;
+	allow $1_gconfd_t $1_gconf_home_t:file create_file_perms;
+
+	userdom_manage_user_tmp_sockets($1, $1_gconfd_t)
+	files_tmp_filetrans($1_gconfd_t, $1_tmp_t, dir)
+	allow $1_gconfd_t $1_tmp_t: dir create_dir_perms;
+	type_transition $1_gconfd_t $1_tmp_t: {dir file} $1_gconf_tmp_t;
+	allow $1_gconfd_t $1_gconf_tmp_t:dir create_dir_perms;
+	allow $1_gconfd_t $1_gconf_tmp_t:file create_file_perms;
+
+	files_read_etc_files($1_gconfd_t)
+	allow $1_gconfd_t gconf_etc_t: dir r_dir_perms;
+	allow $1_gconfd_t gconf_etc_t: file r_file_perms;
+
+	optional_policy(`
+		xserver_use_xdm_fds($1_gconfd_t)
+		xserver_rw_xdm_pipes($1_gconfd_t)
+	')
+	optional_policy(`
+		nscd_dontaudit_search_pid($1_gconfd_t)
+	')
+')
+	
+########################################
+## <summary>
+##	gconf connection template.
+## </summary>
+## <param name="userdomain_prefix">
+##	<summary>
+##	The prefix of the user domain (e.g., user
+##	is the prefix for user_t).
+##	</summary>
+## </param>
+## <param name="user_domain">
+##	<summary>
+##	The type of the user domain.
+##	</summary>
+## </param>
+#
+template(`gconf_connect_template',`
+	gen_require(`
+		type $1_gconfd_t;
+		type $1_gconf_tmp_t;
+	')
+	allow $2 $1_gconfd_t:unix_stream_socket connectto;
+	allow $2 $1_gconf_tmp_t:file r_file_perms;
+')
diff -X /home/jwcart2/dontdiff -rNu refpolicy/policy/modules/services/gconf.te refpolicy.gconf/policy/modules/services/gconf.te
--- refpolicy/policy/modules/services/gconf.te	1969-12-31 19:00:00.000000000 -0500
+++ refpolicy.gconf/policy/modules/services/gconf.te	2006-09-22 11:10:29.000000000 -0400
@@ -0,0 +1,13 @@
+
+policy_module(gconf,1.0.0)
+
+##############################
+#
+# Declarations
+#
+
+type gconf_etc_t;
+files_type(gconf_etc_t)
+
+type gconfd_exec_t;
+corecmd_executable_file(gconfd_exec_t)
diff -X /home/jwcart2/dontdiff -rNu refpolicy/policy/modules/system/userdomain.if refpolicy.gconf/policy/modules/system/userdomain.if
--- refpolicy/policy/modules/system/userdomain.if	2006-09-26 10:20:47.000000000 -0400
+++ refpolicy.gconf/policy/modules/system/userdomain.if	2006-09-26 09:52:40.000000000 -0400
@@ -958,6 +958,10 @@
 	')
 
 	optional_policy(`
+		gconf_connect_template($1, $1_t)
+	')
+
+	optional_policy(`
 		kerberos_use($1_t)
 	')
 

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
