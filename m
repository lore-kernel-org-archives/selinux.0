Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uABJCvH9006720
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 14:12:57 -0500
Received: by mail-pf0-f179.google.com with SMTP id i88so12777892pfk.2
 for <selinux@tycho.nsa.gov>; Fri, 11 Nov 2016 11:12:56 -0800 (PST)
From: Daniel Cashman <dcashman@android.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol: cil: remove double-free.
Date: Fri, 11 Nov 2016 11:12:44 -0800
Message-Id: <1478891564-11770-1-git-send-email-dcashman@android.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: dcashman <dcashman@android.com>

Test: Untested patch.
Bug: https://code.google.com/p/android/issues/detail?id=226519
Change-Id: Icaf992ba1487098f2c4f16ac1017012f611281e9
Signed-off-by: Daniel Cashman <dcashman@android.com>
---
 libsepol/cil/src/cil_binary.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 5402272..a813201 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -843,7 +843,6 @@ int cil_catalias_to_policydb(policydb_t *pdb, struct cil_alias *cil_alias)
 	key = cil_strdup(cil_alias->datum.fqn);
 	rc = symtab_insert(pdb, SYM_CATS, key, sepol_alias, SCOPE_DECL, 0, NULL);
 	if (rc != SEPOL_OK) {
-		free(key);
 		goto exit;
 	}
 	sepol_alias->s.value = sepol_cat->s.value;
-- 
2.8.0.rc3.226.g39d4020
