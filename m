Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v37MYxbI006432
 for <selinux@tycho.nsa.gov>; Fri, 7 Apr 2017 18:34:59 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 45C10564677
 for <selinux@tycho.nsa.gov>; Fri,  7 Apr 2017 22:44:57 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/6] libsemanage: drop checks on
 semanage_module_info_destroy() value
Date: Fri,  7 Apr 2017 22:44:27 +0200
Message-Id: <20170407204431.8572-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170407204431.8572-1-nicolas.iooss@m4x.org>
References: <20170407204431.8572-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

semanage_module_info_destroy() always returns 0. Nevertheless
semanage_direct_list_all() uses its return value in a surprising way:

    cleanup:
        if (priorities != NULL) {
            /* ... */
            free(priorities);
        }
        /* ... */
        ret = semanage_module_info_destroy(sh, modinfo_tmp);
        if (ret != 0) {
            status = -1;
            goto cleanup;
        }

The last "goto cleanup;" leads clang's static analyzer to believe a
double free is possible. Even though this is a false positive, the
body of condition "if (ret != 0)" contains dead code. Remove it.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/direct_api.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 568732355f54..1d53c0d64e0c 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -2499,11 +2499,7 @@ static int semanage_direct_list_all(semanage_handle_t *sh,
 				goto cleanup;
 			}
 
-			ret = semanage_module_info_destroy(sh, modinfo_tmp);
-			if (ret != 0) {
-				status = -1;
-				goto cleanup;
-			}
+			semanage_module_info_destroy(sh, modinfo_tmp);
 			free(modinfo_tmp);
 			modinfo_tmp = NULL;
 
@@ -2528,11 +2524,7 @@ cleanup:
 		free(modules);
 	}
 
-	ret = semanage_module_info_destroy(sh, modinfo_tmp);
-	if (ret != 0) {
-		status = -1;
-		goto cleanup;
-	}
+	semanage_module_info_destroy(sh, modinfo_tmp);
 	free(modinfo_tmp);
 	modinfo_tmp = NULL;
 
-- 
2.12.0
