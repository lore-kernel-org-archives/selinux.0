Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1SAFYKE020868
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 05:15:34 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC14.oob.disa.mil (Postfix) with SMTP id 3zrrzm1QXkzJ3f3
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 10:15:32 +0000 (UTC)
Received: from UPDC3CPA08_EEMSG_MP24.eemsg.mil (unknown [192.168.18.19])
 by UPDCF3IC14.oob.disa.mil (Postfix) with ESMTP id 3zrrzm0dxpzJ3dt
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 10:15:32 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 97950FE3BA
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 10:15:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0AE10B0F45
 for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2018 10:15:30 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Wed, 28 Feb 2018 11:15:09 +0100
Message-Id: <20180228101510.21023-2-vmojzis@redhat.com>
In-Reply-To: <20180228101510.21023-1-vmojzis@redhat.com>
References: <1498485334.13301.9.camel@tycho.nsa.gov>
 <20180228101510.21023-1-vmojzis@redhat.com>
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
 libsemanage/src/direct_api.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index b7899d68..f4d57cf8 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1563,34 +1563,25 @@ rebuild:
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
+	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC_LOCAL),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC_LOCAL),
+						sh->conf->file_mode);
+	if (retval < 0 && errno != ENOENT) {
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
+	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_FC),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_FC),
+						sh->conf->file_mode);
+	if (retval < 0 && errno != ENOENT) {
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
+	retval = semanage_copy_file(semanage_path(SEMANAGE_TMP, SEMANAGE_STORE_SEUSERS),
+						semanage_final_path(SEMANAGE_FINAL_TMP, SEMANAGE_SEUSERS),
+						sh->conf->file_mode);
+	if (retval < 0 && errno != ENOENT) {
+		goto cleanup;
 	}
 
 	/* run genhomedircon if its enabled, this should be the last operation
-- 
2.14.3
