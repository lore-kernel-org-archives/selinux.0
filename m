Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w26BwQ1A025649
 for <selinux@tycho.nsa.gov>; Tue, 6 Mar 2018 06:58:31 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC04.oob.disa.mil (Postfix) with SMTP id 3zwZzl44Dkz63cH
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:27 +0000 (UTC)
Received: from UPBD19PA02.eemsg.mil (unknown [192.168.18.3])
 by UPDCF3IC04.oob.disa.mil (Postfix) with ESMTP id 3zwZzl3Gn0z63cK
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:27 +0000 (UTC)
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 927D2404085A
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:25 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.43.12.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 37CF52026DFD
 for <selinux@tycho.nsa.gov>; Tue,  6 Mar 2018 11:58:25 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Date: Tue,  6 Mar 2018 12:58:06 +0100
Message-Id: <20180306115808.17470-2-vmojzis@redhat.com>
In-Reply-To: <20180306115808.17470-1-vmojzis@redhat.com>
References: <20180306115808.17470-1-vmojzis@redhat.com>
Subject: [PATCH 1/3] libsemanage: remove access() check to make
 setuid programs work
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

access() uses real UID instead of effective UID which causes false
negative checks in setuid programs. Remove redundant access() checks

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 libsemanage/src/direct_api.c     |  7 -------
 libsemanage/src/semanage_store.c | 17 ++++++++---------
 2 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 88873c43..b7899d68 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -148,9 +148,6 @@ int semanage_direct_connect(semanage_handle_t * sh)
 		if (semanage_create_store(sh, 1))
 			goto err;
 
-	if (semanage_access_check(sh) < SEMANAGE_CAN_READ)
-		goto err;
-
 	sh->u.direct.translock_file_fd = -1;
 	sh->u.direct.activelock_file_fd = -1;
 
@@ -398,10 +395,6 @@ static int semanage_direct_disconnect(semanage_handle_t *sh)
 
 static int semanage_direct_begintrans(semanage_handle_t * sh)
 {
-
-	if (semanage_access_check(sh) != SEMANAGE_CAN_WRITE) {
-		return -1;
-	}
 	if (semanage_get_trans_lock(sh) < 0) {
 		return -1;
 	}
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 936e6495..4bd1d651 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -538,7 +538,6 @@ char *semanage_conf_path(void)
 int semanage_create_store(semanage_handle_t * sh, int create)
 {
 	struct stat sb;
-	int mode_mask = R_OK | W_OK | X_OK;
 	const char *path = semanage_files[SEMANAGE_ROOT];
 	int fd;
 
@@ -557,9 +556,9 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
+		if (!S_ISDIR(sb.st_mode)) {
 			ERR(sh,
-			    "Could not access module store at %s, or it is not a directory.",
+			    "Module store at %s is not a directory.",
 			    path);
 			return -1;
 		}
@@ -580,9 +579,9 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
+		if (!S_ISDIR(sb.st_mode)) {
 			ERR(sh,
-			    "Could not access module store active subdirectory at %s, or it is not a directory.",
+			    "Module store active subdirectory at %s is not a directory.",
 			    path);
 			return -1;
 		}
@@ -603,9 +602,9 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) == -1) {
+		if (!S_ISDIR(sb.st_mode)) {
 			ERR(sh,
-			    "Could not access module store active modules subdirectory at %s, or it is not a directory.",
+			    "Module store active modules subdirectory at %s is not a directory.",
 			    path);
 			return -1;
 		}
@@ -624,8 +623,8 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISREG(sb.st_mode) || access(path, R_OK | W_OK) == -1) {
-			ERR(sh, "Could not access lock file at %s.", path);
+		if (!S_ISREG(sb.st_mode)) {
+			ERR(sh, "Object at %s is not a lock file.", path);
 			return -1;
 		}
 	}
-- 
2.14.3
