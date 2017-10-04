Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v94GGuHq006748
 for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2017 12:16:57 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 26094C04B92A
 for <selinux@tycho.nsa.gov>; Wed,  4 Oct 2017 15:36:14 +0000 (UTC)
Received: from Thinkpad_450.redhat.com (unknown [10.40.205.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 609E46FF11
 for <selinux@tycho.nsa.gov>; Wed,  4 Oct 2017 15:36:13 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed,  4 Oct 2017 17:36:02 +0200
Message-Id: <20171004153604.5817-1-vmojzis@redhat.com>
In-Reply-To: <1dcea489-7584-e7a3-aa50-99a974440734@redhat.com>
References: <1dcea489-7584-e7a3-aa50-99a974440734@redhat.com>
Subject: [PATCH 1/3] libsemanage: Keep copy of
 file_contexts.homedirs in policy store
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This will allow listing the correct file_contexts.homedirs
using libsemanage regardless of selected policy store.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1409813

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c     | 19 ++++++++++++++-----
 libsemanage/src/genhomedircon.c  |  4 ++--
 libsemanage/src/semanage_store.c |  1 +
 libsemanage/src/semanage_store.h |  1 +
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 65842df..971a08f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1577,11 +1577,20 @@ rebuild:
 	/* run genhomedircon if its enabled, this should be the last operation
 	 * which requires the out policydb */
 	if (!sh->conf->disable_genhomedircon) {
-		if (out && (retval =
-			semanage_genhomedircon(sh, out, sh->conf->usepasswd, sh->conf->ignoredirs)) != 0) {
-			ERR(sh, "semanage_genhomedircon returned error code %d.",
-			    retval);
-			goto cleanup;
+		if (out){
+			if ((retval = semanage_genhomedircon(sh, out, sh->conf->usepasswd,
+								sh->conf->ignoredirs)) != 0) {
+				ERR(sh, "semanage_genhomedircon returned error code %d.", retval);
+				goto cleanup;
+			}
+			/* file_contexts.homedirs was created in SEMANAGE_TMP store */
+			retval = semanage_copy_file(
+						semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS),
+						semanage_final_path(SEMANAGE_FINAL_TMP,	SEMANAGE_FC_HOMEDIRS),
+						sh->conf->file_mode);
+			if (retval < 0) {
+				goto cleanup;
+			}
 		}
 	} else {
 		WARN(sh, "WARNING: genhomedircon is disabled. \
diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index b9a74b7..27a269e 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -1345,8 +1345,8 @@ int semanage_genhomedircon(semanage_handle_t * sh,
 
 	s.homedir_template_path =
 	    semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL);
-	s.fcfilepath = semanage_final_path(SEMANAGE_FINAL_TMP,
-					   SEMANAGE_FC_HOMEDIRS);
+	s.fcfilepath =
+		semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_HOMEDIRS);
 
 	s.fallback = calloc(1, sizeof(genhomedircon_user_entry_t));
 	if (s.fallback == NULL) {
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 6158d08..63c80b0 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -116,6 +116,7 @@ static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] = {
 	"/modules/disabled",
 	"/policy.kern",
 	"/file_contexts.local",
+	"/file_contexts.homedirs",
 	"/file_contexts",
 	"/seusers"
 };
diff --git a/libsemanage/src/semanage_store.h b/libsemanage/src/semanage_store.h
index fcaa505..34bf852 100644
--- a/libsemanage/src/semanage_store.h
+++ b/libsemanage/src/semanage_store.h
@@ -61,6 +61,7 @@ enum semanage_sandbox_defs {
 	SEMANAGE_MODULES_DISABLED,
 	SEMANAGE_STORE_KERNEL,
 	SEMANAGE_STORE_FC_LOCAL,
+	SEMANAGE_STORE_FC_HOMEDIRS,
 	SEMANAGE_STORE_FC,
 	SEMANAGE_STORE_SEUSERS,
 	SEMANAGE_STORE_NUM_PATHS
-- 
2.9.4
