Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5QCcsAr012131
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 08:38:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 10B2D4ACB3
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 12:38:51 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.43.12.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7DF2977DE5
 for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2017 12:38:50 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsemanage: remove access() check to make setuid
 programs work
Date: Mon, 26 Jun 2017 14:38:34 +0200
Message-Id: <20170626123835.8234-2-vmojzis@redhat.com>
In-Reply-To: <20170626123835.8234-1-vmojzis@redhat.com>
References: <1495202170.2209.3.camel@tycho.nsa.gov>
 <20170626123835.8234-1-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

F_OK access checks only work properly as long as all directories along
the path are accessible to real user running the program.
Replace F_OK access checks by testing return value of open, write, etc.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
---
 libsemanage/src/direct_api.c | 36 +++++++++++++++---------------------
 1 file changed, 15 insertions(+), 21 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index b761b68..ed11a7c 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1538,33 +1538,27 @@ rebuild:
 	}
 
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL);
-	if (access(path, F_OK) == 0) {
-		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
-							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
-							sh->conf->file_mode);
-		if (retval < 0) {
-			goto cleanup;
-		}
+	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
+						sh->conf->file_mode);
+	if (retval < 0 && errno != ENOENT) {
+		goto cleanup;
 	}
 
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC);
-	if (access(path, F_OK) == 0) {
-		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
-							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
-							sh->conf->file_mode);
-		if (retval < 0) {
-			goto cleanup;
-		}
+	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
+						sh->conf->file_mode);
+	if (retval < 0 && errno != ENOENT) {
+		goto cleanup;
 	}
 
 	path = semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS);
-	if (access(path, F_OK) == 0) {
-		retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
-							semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
-							sh->conf->file_mode);
-		if (retval < 0) {
-			goto cleanup;
-		}
+	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
+						sh->conf->file_mode);
+	if (retval < 0 && errno != ENOENT) {
+		goto cleanup;
 	}
 
 	/* run genhomedircon if its enabled, this should be the last operation
-- 
2.9.4
