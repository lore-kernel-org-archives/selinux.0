Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SLgbIR030851
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 17:42:42 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id D47A35646C0
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 23:42:40 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 6/7] libsemanage: do not dereference a NULL pointer when
 calloc() fails
Date: Tue, 28 Mar 2017 23:41:51 +0200
Message-Id: <20170328214152.17545-6-nicolas.iooss@m4x.org>
In-Reply-To: <20170328214152.17545-1-nicolas.iooss@m4x.org>
References: <20170328214152.17545-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

If "names = calloc(num_modinfos, sizeof(*names))" fails in
semanage_get_cil_paths(), the function tries to frees items in array
"names" even though it is NULL. Avoid this by returning directly.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsemanage/src/semanage_store.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libsemanage/src/semanage_store.c b/libsemanage/src/semanage_store.c
index 47ec93185e06..bf1a448384b9 100644
--- a/libsemanage/src/semanage_store.c
+++ b/libsemanage/src/semanage_store.c
@@ -1012,8 +1012,7 @@ int semanage_get_cil_paths(semanage_handle_t * sh,
 	names = calloc(num_modinfos, sizeof(*names));
 	if (names == NULL) {
 		ERR(sh, "Error allocating space for filenames.");
-		status = -1;
-		goto cleanup;
+		return -1;
 	}
 
 	for (i = 0; i < num_modinfos; i++) {
-- 
2.12.0
