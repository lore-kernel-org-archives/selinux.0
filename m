Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v45Co7Rg012111
 for <selinux@tycho.nsa.gov>; Fri, 5 May 2017 08:50:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DA10963E09
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 12:50:01 +0000 (UTC)
Received: from Thinkpad_450.brq.redhat.com (unknown [10.40.3.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 527A180693
 for <selinux@tycho.nsa.gov>; Fri,  5 May 2017 12:50:01 +0000 (UTC)
From: Vit Mojzis <vmojzis@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsemanage: remove access() check to make setuid
 programs work
Date: Fri,  5 May 2017 14:49:45 +0200
Message-Id: <20170505124947.21392-2-vmojzis@redhat.com>
In-Reply-To: <20170505124947.21392-1-vmojzis@redhat.com>
References: <1488219577.19819.19.camel@tycho.nsa.gov>
 <20170505124947.21392-1-vmojzis@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

access() uses real UID instead of effective UID which causes false
negative checks in setuid programs (except for F_OK which works
properly). fopen() return values are always checked, which makes
access() checks redundant.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1186431
---
 libsemanage/src/direct_api.c     |  3 ---
 libsemanage/src/semanage_store.c | 17 ++++++++---------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index f4b0416..dc46f8f 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -146,9 +146,6 @@ int semanage_direct_connect(semanage_handle_t * sh)
 		if (semanage_create_store(sh, 1))
 			goto err;
 
-	if (semanage_access_check(sh) < SEMANAGE_CAN_READ)
-		goto err;
-
 	sh->u.direct.translock_file_fd = -1;
 	sh->u.direct.activelock_file_fd = -1;
 
diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 6b75002..0a10032 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -535,7 +535,6 @@ char *semanage_conf_path(void)
 int semanage_create_store(semanage_handle_t * sh, int create)
 {
 	struct stat sb;
-	int mode_mask = R_OK | W_OK | X_OK;
 	const char *path = semanage_files[SEMANAGE_ROOT];
 	int fd;
 
@@ -554,9 +553,9 @@ int semanage_create_store(semanage_handle_t * sh, int create)
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
@@ -577,9 +576,9 @@ int semanage_create_store(semanage_handle_t * sh, int create)
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
@@ -600,9 +599,9 @@ int semanage_create_store(semanage_handle_t * sh, int create)
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
@@ -621,8 +620,8 @@ int semanage_create_store(semanage_handle_t * sh, int create)
 			return -1;
 		}
 	} else {
-		if (!S_ISREG(sb.st_mode) || access(path, R_OK | W_OK) == -1) {
-			ERR(sh, "Could not access lock file at %s.", path);
+		if (!S_ISREG(sb.st_mode)) {
+			ERR(sh, "Lock file at %s missing.", path);
 			return -1;
 		}
 	}
-- 
2.9.3
