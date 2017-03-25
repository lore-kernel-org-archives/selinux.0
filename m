Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2PDnY80029557
 for <selinux@tycho.nsa.gov>; Sat, 25 Mar 2017 09:49:35 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 49F4A564704
 for <selinux@tycho.nsa.gov>; Sat, 25 Mar 2017 14:49:24 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol/cil: do not dereference a NULL pointer when
 calloc() fails
Date: Sat, 25 Mar 2017 14:48:42 +0100
Message-Id: <20170325134842.1414-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When list_init() fails to allocate a list with calloc(), it calls
list_destroy(&l) with l = NULL. This functions starts by dereferencing
its argument ("(*list)->head"), which does not work well when it is
NULL.

This bug can be fixed by returning directly in list_init() when calloc()
fails. Doing so allows making list_init() implementation shorter by
removing label "exit" and local variable "rc".

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 6c33b94da9d9..308ada4f1381 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -250,19 +250,13 @@ static void attr_list_destroy(struct list **attr_list)
 
 static int list_init(struct list **list)
 {
-	int rc = -1;
 	struct list *l = calloc(1, sizeof(*l));
 	if (l == NULL) {
-		goto exit;
+		return -1;
 	}
 
 	*list = l;
-
 	return 0;
-
-exit:
-	list_destroy(&l);
-	return rc;
 }
 
 static int list_prepend(struct list *list, void *data)
-- 
2.11.1
