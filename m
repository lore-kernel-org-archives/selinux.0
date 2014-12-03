Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB3EHNW4019048
 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2014 09:17:26 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: Refpolicy List <refpolicy@oss1.tresys.com>
Subject: [PATCH v2] Update policy for selinux userspace moving the policy
 store to /var/lib/selinux
Date: Wed, 3 Dec 2014 09:16:56 -0500
Message-ID: <1417616216-18296-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

With the new userspace, the only files in /var/lib/selinux are selinux
store related files, so label it and everything inside it as
semanage_store_t. semanage_var_lib_t is completely removed and now
aliases semanage_store_t for backwards compatibility. Also, now that the
store is no longer in /etc/selinux, access to selinux_config_t is no
longer needed to just manage the store.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 policy/modules/system/selinuxutil.fc | 5 ++++-
 policy/modules/system/selinuxutil.if | 6 +++---
 policy/modules/system/selinuxutil.te | 8 +-------
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/policy/modules/system/selinuxutil.fc b/policy/modules/system/selinuxutil.fc
index ec19d63..7616b31 100644
--- a/policy/modules/system/selinuxutil.fc
+++ b/policy/modules/system/selinuxutil.fc
@@ -41,11 +41,14 @@
 /usr/sbin/setsebool		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 /usr/sbin/semanage		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 /usr/sbin/semodule		--	gen_context(system_u:object_r:semanage_exec_t,s0)
+/usr/libexec/selinux/semanage_migrate_store		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 
 #
 # /var/lib
 #
-/var/lib/selinux(/.*)?			gen_context(system_u:object_r:semanage_var_lib_t,s0)
+/var/lib/selinux(/.*)?			gen_context(system_u:object_r:semanage_store_t,s0)
+/var/lib/selinux/[^/]+/semanage\.read\.LOCK -- gen_context(system_u:object_r:semanage_read_lock_t,s0)
+/var/lib/selinux/[^/]+/semanage\.trans\.LOCK -- gen_context(system_u:object_r:semanage_trans_lock_t,s0)
 
 #
 # /var/run
diff --git a/policy/modules/system/selinuxutil.if b/policy/modules/system/selinuxutil.if
index bee06f4..834cec2 100644
--- a/policy/modules/system/selinuxutil.if
+++ b/policy/modules/system/selinuxutil.if
@@ -1037,11 +1037,11 @@ interface(`seutil_run_semanage',`
 #
 interface(`seutil_manage_module_store',`
 	gen_require(`
-		type selinux_config_t, semanage_store_t;
+		type semanage_store_t;
 	')
 
-	files_search_etc($1)
-	manage_dirs_pattern($1, selinux_config_t, semanage_store_t)
+	files_search_var($1)
+	manage_dirs_pattern($1, semanage_store_t, semanage_store_t)
 	manage_files_pattern($1, semanage_store_t, semanage_store_t)
 	manage_lnk_files_pattern($1, semanage_store_t, semanage_store_t)
 ')
diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
index c322a6f..43cf82d 100644
--- a/policy/modules/system/selinuxutil.te
+++ b/policy/modules/system/selinuxutil.te
@@ -100,7 +100,7 @@ application_domain(semanage_t, semanage_exec_t)
 domain_interactive_fd(semanage_t)
 role semanage_roles types semanage_t;
 
-type semanage_store_t;
+type semanage_store_t alias semanage_var_lib_t;
 files_type(semanage_store_t)
 
 type semanage_read_lock_t;
@@ -112,9 +112,6 @@ files_tmp_file(semanage_tmp_t)
 type semanage_trans_lock_t;
 files_type(semanage_trans_lock_t)
 
-type semanage_var_lib_t;
-files_type(semanage_var_lib_t)
-
 type setfiles_t alias restorecon_t, can_relabelto_binary_policy;
 type setfiles_exec_t alias restorecon_exec_t;
 init_system_domain(setfiles_t, setfiles_exec_t)
@@ -454,9 +451,6 @@ allow semanage_t semanage_tmp_t:dir manage_dir_perms;
 allow semanage_t semanage_tmp_t:file manage_file_perms;
 files_tmp_filetrans(semanage_t, semanage_tmp_t, { file dir })
 
-manage_dirs_pattern(semanage_t, semanage_var_lib_t, semanage_var_lib_t)
-manage_files_pattern(semanage_t, semanage_var_lib_t, semanage_var_lib_t)
-
 kernel_read_system_state(semanage_t)
 kernel_read_kernel_sysctls(semanage_t)
 
-- 
1.9.3
