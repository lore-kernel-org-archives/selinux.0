Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26BwQ1B025649
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 06:58:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 266868182D0C
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:27 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C02272026DFD
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:26 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue,  6 Mar 2018 12:58:07 +0100
Message-Id: <20180306115808.17470-3-vmojzis@redhat.com>
In-Reply-To: <20180306115808.17470-1-vmojzis@redhat.com>
References: <20180306115808.17470-1-vmojzis@redhat.com>
Subject: [PATCH 2/3] libsemanage: remove access() check to make
 setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

F_OK access checks only work properly as long as all directories along
the path are accessible to real user running the program.
Replace F_OK access checks by testing return value of open, write, etc.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c | 47 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index b7899d68..49cac14f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1171,6 +1171,14 @@ cleanup:
 	return status;
 }
 
+/* Copies a file from src to dst. If dst already exists then
+ * overwrite it. If source doesn't exist then return success.
+ * Returns 0 on success, -1 on error. */
+static int copy_file_if_exists(const char *src, const char *dst, mode_t mode){
+	int rc = semanage_copy_file(src, dst, mode);
+	return (rc < 0 && errno != ENOENT) ? rc : 0;
+}
+
 /********************* direct API functions ********************/
 
 /* Commits all changes in sandbox to the actual kernel policy.
@@ -1563,34 +1571,25 @@ rebuild:
 		goto cleanup;
 	}
 
-	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL);
-	if (access(path, F_OK) == 0) {
-		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
-							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
-							sh->conf->file_mode);
-		if (retval < 0) {
-			goto cleanup;
-		}
+	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
+						sh->conf->file_mode);
+	if (retval < 0) {
+		goto cleanup;
 	}
 
-	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
-	if (access(path, F_OK) == 0) {
-		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
-							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
-							sh->conf->file_mode);
-		if (retval < 0) {
-			goto cleanup;
-		}
+	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
+						sh->conf->file_mode);
+	if (retval < 0) {
+		goto cleanup;
 	}
 
-	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
-	if (access(path, F_OK) == 0) {
-		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
-							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
-							sh->conf->file_mode);
-		if (retval < 0) {
-			goto cleanup;
-		}
+	retval = copy_file_if_exists(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
+						sh->conf->file_mode);
+	if (retval < 0) {
+		goto cleanup;
 	}
 
 	/* run genhomedircon if its enabled, this should be the last operation
-- 
2.14.3
