Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SLgbIO030851
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 17:42:40 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3B3EA5646B8
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 23:42:38 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/7] libsepol: constify sepol_genbools()'s boolpath parameter
Date: Tue, 28 Mar 2017 23:41:48 +0200
Message-Id: <20170328214152.17545-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170328214152.17545-1-nicolas.iooss@m4x.org>
References: <20170328214152.17545-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This allows removing an unnecessary cast to (char *) in libselinux.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libselinux/src/load_policy.c       | 5 ++---
 libsepol/include/sepol/booleans.h  | 2 +-
 libsepol/man/man3/sepol_genbools.3 | 2 +-
 libsepol/src/genbools.c            | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index b7e1a6fa6b5c..e788c25cfe68 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -79,7 +79,7 @@ int selinux_mkload_policy(int preservebools)
 	int (*policydb_to_image)(sepol_handle_t *, sepol_policydb_t *, void **, size_t *) = NULL;
 	int (*genbools_array)(void *data, size_t len, char **names, int *values, int nel) = NULL;
 	int (*genusers)(void *data, size_t len, const char *usersdir, void **newdata, size_t * newlen) = NULL;
-	int (*genbools)(void *data, size_t len, char *boolpath) = NULL;
+	int (*genbools)(void *data, size_t len, const char *boolpath) = NULL;
 
 #ifdef SHARED
 	char *errormsg = NULL;
@@ -275,8 +275,7 @@ checkbool:
 				free(names);
 			}
 		} else if (setlocaldefs) {
-			(void)genbools(data, size,
-				       (char *)selinux_booleans_path());
+			(void)genbools(data, size, selinux_booleans_path());
 		}
 	}
 
diff --git a/libsepol/include/sepol/booleans.h b/libsepol/include/sepol/booleans.h
index 02356d18fd5d..2966903d4564 100644
--- a/libsepol/include/sepol/booleans.h
+++ b/libsepol/include/sepol/booleans.h
@@ -17,7 +17,7 @@ extern "C" {
    policy for the boolean settings in the boolean configuration file.
    The binary policy is rewritten in place in memory.
    Returns 0 upon success, or -1 otherwise. */
-extern int sepol_genbools(void *data, size_t len, char *boolpath);
+extern int sepol_genbools(void *data, size_t len, const char *boolpath);
 
 /* Given an existing binary policy (starting at 'data', with length 'len')
    and boolean settings specified by the parallel arrays ('names', 'values')
diff --git a/libsepol/man/man3/sepol_genbools.3 b/libsepol/man/man3/sepol_genbools.3
index ca5b5a63bb8c..dcfb69da4eb9 100644
--- a/libsepol/man/man3/sepol_genbools.3
+++ b/libsepol/man/man3/sepol_genbools.3
@@ -4,7 +4,7 @@ sepol_genbools \- Rewrite a binary policy with different boolean settings
 .SH "SYNOPSIS"
 .B #include <sepol/sepol.h>
 .sp
-.BI "int sepol_genbools(void *" data ", size_t "len ", char *" boolpath );
+.BI "int sepol_genbools(void *" data ", size_t "len ", const char *" boolpath );
 .br
 .BI "int sepol_genbools_array(void *" data ", size_t " len ", char **" names ", int *" values ", int " nel );
 
diff --git a/libsepol/src/genbools.c b/libsepol/src/genbools.c
index d79433531f76..d4a2df62d315 100644
--- a/libsepol/src/genbools.c
+++ b/libsepol/src/genbools.c
@@ -157,7 +157,7 @@ static int load_booleans(struct policydb *policydb, const char *path,
 	return errors ? -1 : 0;
 }
 
-int sepol_genbools(void *data, size_t len, char *booleans)
+int sepol_genbools(void *data, size_t len, const char *booleans)
 {
 	struct policydb policydb;
 	struct policy_file pf;
-- 
2.12.0
