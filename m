Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3DL2Vxg008162
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 17:02:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC05.oob.disa.mil (Postfix) with SMTP id 40N9Fw4nMqzrMHV
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 21:02:28 +0000 (UTC)
Received: from UPDC3CPA03.eemsg.mil (unknown [192.168.18.10])
 by UPDCF3IC05.oob.disa.mil (Postfix) with ESMTP id 40N9Fw48CyzrKY3
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 21:02:28 +0000 (UTC)
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 30719564946
 for <selinux@tycho.nsa.gov>; Fri, 13 Apr 2018 23:01:14 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Fri, 13 Apr 2018 22:34:20 +0200
Message-Id: <20180413203424.20542-1-nicolas.iooss@m4x.org>
Subject: [PATCH 1/5] libsepol: do not dereference NULL if stack_init
 fails
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

In cond_expr_to_cil(), when stack_init() fails to allocate a stack, the
function calls stack_pop() with stack = NULL. Then stack_pop()
dereferences the pointer ("if (stack->pos == -1) {"), which is NULL.

Fix this by moving the stack cleaning loop in a "if (stack != NULL)"
block.

This issue is reported by clang's static analyzer with the following
message:

    module_to_cil.c:463:6: warning: Access to field 'pos' results in a
    dereference of a null pointer (loaded from variable 'stack')
        if (stack->pos == -1) {
            ^~~~~~~~~~

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index 5b8ed19eaa14..c6f1659c84ef 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1917,10 +1917,12 @@ exit:
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
 
 	return rc;
 }
-- 
2.17.0
