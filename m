From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov, jason@perfinion.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libsepol, libsemanage: fix linker scripts / map files
Date: Wed,  5 Oct 2016 13:00:59 -0400
Message-Id: <1475686859-11735-1-git-send-email-sds@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The local: * entry should only be in the base entry, not in each of them.
This is part of resolving gold linker build failures reported by
Jason Zaman.

Reported-by: Jason Zaman <jason@perfinion.com>
Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsemanage/src/libsemanage.map | 1 -
 libsepol/src/libsepol.map.in    | 1 -
 2 files changed, 2 deletions(-)

diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 34b553d..9f8a754 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -60,5 +60,4 @@ LIBSEMANAGE_1.1 {
 	  semanage_module_upgrade_info;
 	  semanage_module_remove_key;
 	  semanage_set_store_root;
-  local: *;
 } LIBSEMANAGE_1.0;
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 0a46b09..9683caf 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -48,5 +48,4 @@ LIBSEPOL_1.1 {
 	sepol_ppfile_to_module_package;
 	sepol_module_package_to_cil;
 	sepol_module_policydb_to_cil;
-  local: *;
 } LIBSEPOL_1.0;
-- 
2.7.4
