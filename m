Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t1REpE8T002463
 for <selinux@tycho.nsa.gov>; Fri, 27 Feb 2015 09:51:14 -0500
From: Steve Lawrence <slawrence@tresys.com>
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [PATCH 2/2] libsemanage: use the new CIL API
Date: Fri, 27 Feb 2015 09:50:42 -0500
Message-ID: <1425048642-22860-2-git-send-email-slawrence@tresys.com>
In-Reply-To: <1425048642-22860-1-git-send-email-slawrence@tresys.com>
References: <1425048642-22860-1-git-send-email-slawrence@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

- Do not pass in the policydb where not necessary
- Tell CIL what policy version and target platform to use when building
  the policydb

Signed-off-by: Steve Lawrence <slawrence@tresys.com>
---
 libsemanage/src/direct_api.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index e631d7d..5922fcc 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -557,7 +557,7 @@ static int write_file(semanage_handle_t * sh,
 	return 0;
 }
 
-static int semanage_direct_update_user_extra(semanage_handle_t * sh, cil_db_t *cildb, sepol_policydb_t *policydb)
+static int semanage_direct_update_user_extra(semanage_handle_t * sh, cil_db_t *cildb)
 {
 	const char *ofilename = NULL;
 	int retval = -1;
@@ -566,7 +566,7 @@ static int semanage_direct_update_user_extra(semanage_handle_t * sh, cil_db_t *c
 
 	dbase_config_t *pusers_extra = semanage_user_extra_dbase_policy(sh);
 
-	retval = cil_userprefixes_to_string(cildb, policydb, &data, &size);
+	retval = cil_userprefixes_to_string(cildb, &data, &size);
 	if (retval != SEPOL_OK) {
 		goto cleanup;
 	}
@@ -592,7 +592,7 @@ cleanup:
 	return retval;
 }
 
-static int semanage_direct_update_seuser(semanage_handle_t * sh, cil_db_t *cildb, sepol_policydb_t *policydb)
+static int semanage_direct_update_seuser(semanage_handle_t * sh, cil_db_t *cildb)
 {
 	const char *ofilename = NULL;
 	int retval = -1;
@@ -601,7 +601,7 @@ static int semanage_direct_update_seuser(semanage_handle_t * sh, cil_db_t *cildb
 
 	dbase_config_t *pseusers = semanage_seuser_dbase_policy(sh);
 
-	retval = cil_selinuxusers_to_string(cildb, policydb, &data, &size);
+	retval = cil_selinuxusers_to_string(cildb, &data, &size);
 	if (retval != SEPOL_OK) {
 		goto cleanup;
 	}
@@ -1180,6 +1180,9 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		cil_set_disable_dontaudit(cildb, disable_dontaudit);
 		cil_set_disable_neverallow(cildb, !(sh->conf->expand_check));
 		cil_set_preserve_tunables(cildb, preserve_tunables);
+		cil_set_target_platform(cildb, sh->conf->target_platform);
+		cil_set_policy_version(cildb, sh->conf->policyvers);
+
 		if (sh->conf->handle_unknown != -1) {
 			cil_set_handle_unknown(cildb, sh->conf->handle_unknown);
 		}
@@ -1188,22 +1191,17 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		if (retval < 0) {
 			goto cleanup;
 		}
-		
-		sepol_policydb_create(&out);
-		out->p.policy_type = POLICY_KERN;
-		sepol_policydb_set_vers(out, sh->conf->policyvers);
-		sepol_policydb_set_target_platform(out, sh->conf->target_platform);
 
-		retval = cil_compile(cildb, out);
+		retval = cil_compile(cildb);
 		if (retval < 0)
 			goto cleanup;
 
-		retval = cil_build_policydb(cildb, out);
+		retval = cil_build_policydb(cildb, &out);
 		if (retval < 0)
 			goto cleanup;
 
 		/* File Contexts */
-		retval = cil_filecons_to_string(cildb, out, &fc_buffer, &fc_buffer_len);
+		retval = cil_filecons_to_string(cildb, &fc_buffer, &fc_buffer_len);
 		if (retval < 0)
 			goto cleanup;
 
@@ -1225,12 +1223,12 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 		pfcontexts->dtable->drop_cache(pfcontexts->dbase);
 
 		/* SEUsers */
-		retval = semanage_direct_update_seuser(sh, cildb, out);
+		retval = semanage_direct_update_seuser(sh, cildb);
 		if (retval < 0)
 			goto cleanup;
 
 		/* User Extra */
-		retval = semanage_direct_update_user_extra(sh, cildb, out);
+		retval = semanage_direct_update_user_extra(sh, cildb);
 		if (retval < 0)
 			goto cleanup;
 
-- 
2.1.0
