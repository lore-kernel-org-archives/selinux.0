Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB2GX8SL020203
 for <selinux@tycho.nsa.gov>; Tue, 2 Dec 2014 11:33:16 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: Refpolicy List <refpolicy@oss1.tresys.com>
Subject: [PATCH] Update policy for selinux userspace moving the policy store
 to /var/lib/selinux
Date: Tue, 2 Dec 2014 11:32:44 -0500
Message-ID: <1417537964-16125-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This keeps /var/lib/selinux labeled as semanage_var_lib_t, but all
directories inside it are now labeled semanage_store_t, except for lock
files.

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 policy/modules/system/selinuxutil.fc | 6 +++++-
 policy/modules/system/selinuxutil.if | 3 ++-
 policy/modules/system/selinuxutil.te | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/policy/modules/system/selinuxutil.fc b/policy/modules/system/selinuxutil.fc
index ec19d63..8f1eb3c 100644
--- a/policy/modules/system/selinuxutil.fc
+++ b/policy/modules/system/selinuxutil.fc
@@ -41,11 +41,15 @@
 /usr/sbin/setsebool		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 /usr/sbin/semanage		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 /usr/sbin/semodule		--	gen_context(system_u:object_r:semanage_exec_t,s0)
+/usr/libexec/selinux/semanage_migrate_store		--	gen_context(system_u:object_r:semanage_exec_t,s0)
 
 #
 # /var/lib
 #
-/var/lib/selinux(/.*)?			gen_context(system_u:object_r:semanage_var_lib_t,s0)
+/var/lib/selinux		-d	gen_context(system_u:object_r:semanage_var_lib_t,s0)
+/var/lib/selinux/.*			gen_context(system_u:object_r:semanage_store_t,s0)
+/var/lib/selinux/[^/]+/semanage\.read\.LOCK -- gen_context(system_u:object_r:semanage_read_lock_t,s0)
+/var/lib/selinux/[^/]+/semanage\.trans\.LOCK -- gen_context(system_u:object_r:semanage_trans_lock_t,s0)
 
 #
 # /var/run
diff --git a/policy/modules/system/selinuxutil.if b/policy/modules/system/selinuxutil.if
index bee06f4..ae280bd 100644
--- a/policy/modules/system/selinuxutil.if
+++ b/policy/modules/system/selinuxutil.if
@@ -1037,11 +1037,12 @@ interface(`seutil_run_semanage',`
 #
 interface(`seutil_manage_module_store',`
 	gen_require(`
-		type selinux_config_t, semanage_store_t;
+		type selinux_config_t, semanage_store_t, semanage_var_lib_t;
 	')
 
 	files_search_etc($1)
 	manage_dirs_pattern($1, selinux_config_t, semanage_store_t)
+	manage_dirs_pattern($1, semanage_var_lib_t, semanage_store_t)
 	manage_files_pattern($1, semanage_store_t, semanage_store_t)
 	manage_lnk_files_pattern($1, semanage_store_t, semanage_store_t)
 ')
diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
index c322a6f..a73874c 100644
--- a/policy/modules/system/selinuxutil.te
+++ b/policy/modules/system/selinuxutil.te
@@ -454,6 +454,7 @@ allow semanage_t semanage_tmp_t:dir manage_dir_perms;
 allow semanage_t semanage_tmp_t:file manage_file_perms;
 files_tmp_filetrans(semanage_t, semanage_tmp_t, { file dir })
 
+filetrans_pattern(semanage_t, semanage_var_lib_t, semanage_store_t, dir)
 manage_dirs_pattern(semanage_t, semanage_var_lib_t, semanage_var_lib_t)
 manage_files_pattern(semanage_t, semanage_var_lib_t, semanage_var_lib_t)
 
-- 
1.9.3
