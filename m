Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3AJCwq0022698
 for <selinux@tycho.nsa.gov>; Mon, 10 Apr 2017 15:12:58 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 1C7495613AE
 for <selinux@tycho.nsa.gov>; Mon, 10 Apr 2017 21:12:48 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol: do not free attr_name twice
Date: Mon, 10 Apr 2017 21:11:47 +0200
Message-Id: <20170410191149.17419-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When set_to_names() fails to allocate *names, it frees variable
attr_name even though it either came from attr_list or was newly created
and added to attr_list. By doing so, the name is freed a second time
when attr_list is destroyed (with "attr_list_destroy(&attr_list)").

Avoid this double free by not freeing attr_name when it belongs to
attr_list.

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 3f633fbb0a3f..18b2a6f86fe3 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -962,7 +962,6 @@ static int set_to_names(struct policydb *pdb, int is_type, void *set, struct lis
 	*names = malloc(sizeof(char *));
 	if (!*names) {
 		log_err("Out of memory");
-		free(attr_name);
 		rc = -1;
 		goto exit;
 	}
-- 
2.12.0
