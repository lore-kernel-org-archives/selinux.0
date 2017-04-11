Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BLkUKh001912
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 17:46:30 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DFD435647D8
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 23:46:26 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/6] libsemanage: make semanage_..._destroy return void
Date: Tue, 11 Apr 2017 23:45:58 +0200
Message-Id: <20170411214603.28040-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

semanage_module_info_destroy() always return 0 ("success") even though
some of its caller want to check its return value. For example commit
86e6ae67fd17 ("libsemanage: drop checks on
semanage_module_info_destroy() value") removed such a caller which was
buggy.

Discourage using the return value of semanage_..._destroy() functions by
making them return void.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/include/semanage/modules.h | 12 ++++--------
 libsemanage/src/modules.c              | 22 +++++++++-------------
 2 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index 4b93e54e7d21..a35de815abbf 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -79,12 +79,10 @@ int semanage_module_info_create(semanage_handle_t *sh,
 
 /* Frees the members of the module info struct.
  *
- * Returns 0 on success and -1 on failure.
- *
  * The caller should call free() on the struct.
  */
-int semanage_module_info_destroy(semanage_handle_t *handle,
-				 semanage_module_info_t *modinfo);
+void semanage_module_info_destroy(semanage_handle_t *handle,
+				  semanage_module_info_t *modinfo);
 
 /* Module Info Getters */
 
@@ -168,11 +166,9 @@ int semanage_module_key_create(semanage_handle_t *sh,
 
 /* Frees members of the @modkey, but not the struct. The caller should
  * call free() on struct.
- *
- * Returns 0 on success, and -1 on error.
  */
-int semanage_module_key_destroy(semanage_handle_t *sh,
-				semanage_module_key_t *modkey);
+void semanage_module_key_destroy(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey);
 
 /* Module Key Getters */
 
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index 90c5e4917f97..7bbe3aa1e6db 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -281,19 +281,19 @@ int semanage_module_info_create(semanage_handle_t *sh,
 
 hidden_def(semanage_module_info_create)
 
-int semanage_module_info_destroy(semanage_handle_t *sh,
-				 semanage_module_info_t *modinfo)
+void semanage_module_info_destroy(semanage_handle_t *sh,
+				  semanage_module_info_t *modinfo)
 {
 	assert(sh);
 
 	if (!modinfo) {
-		return 0;
+		return;
 	}
 
 	free(modinfo->name);
 	free(modinfo->lang_ext);
 
-	return semanage_module_info_init(sh, modinfo);
+	semanage_module_info_init(sh, modinfo);
 }
 
 hidden_def(semanage_module_info_destroy)
@@ -323,11 +323,7 @@ int semanage_module_info_clone(semanage_handle_t *sh,
 	int status = 0;
 	int ret = 0;
 
-	ret = semanage_module_info_destroy(sh, target);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
+	semanage_module_info_destroy(sh, target);
 
 	ret = semanage_module_info_set_priority(sh, target, source->priority);
 	if (ret != 0) {
@@ -685,18 +681,18 @@ int semanage_module_key_create(semanage_handle_t *sh,
 
 hidden_def(semanage_module_key_create)
 
-int semanage_module_key_destroy(semanage_handle_t *sh,
-				semanage_module_key_t *modkey)
+void semanage_module_key_destroy(semanage_handle_t *sh,
+				 semanage_module_key_t *modkey)
 {
 	assert(sh);
 
 	if (!modkey) {
-		return 0;
+		return;
 	}
 
 	free(modkey->name);
 
-	return semanage_module_key_init(sh, modkey);
+	semanage_module_key_init(sh, modkey);
 }
 
 hidden_def(semanage_module_key_destroy)
-- 
2.12.0
