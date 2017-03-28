Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2SLgbIM030851
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 17:42:37 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 554255646B8
 for <selinux@tycho.nsa.gov>; Tue, 28 Mar 2017 23:42:35 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/7] libsepol: do not dereference a NULL pointer when
 stack_init() fails
Date: Tue, 28 Mar 2017 23:41:46 +0200
Message-Id: <20170328214152.17545-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In cond_expr_to_cil() when stack_init(&stack) fails, stack is set to
NULL and the execution flow jumps to label "exit". This triggers a call
to stack_pop(stack) which dereferences a NULL pointer in "if (stack->pos
== -1)".

This issue has been found using clang's static analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 308ada4f1381..5c98c29bcf13 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1363,11 +1363,12 @@ exit:
 	free(new_val);
 	free(val1);
 	free(val2);
-	while ((val1 = stack_pop(stack)) != NULL) {
-		free(val1);
+	if (stack != NULL) {
+		while ((val1 = stack_pop(stack)) != NULL) {
+			free(val1);
+		}
+		stack_destroy(&stack);
 	}
-	stack_destroy(&stack);
-
 	return rc;
 }
 
-- 
2.12.0
