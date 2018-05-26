Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4QIhiaJ004239
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 14:43:44 -0400
Received: from localhost.localdomain (abo-251-56-69.avi.modulonet.fr
 [85.69.56.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 694EF56069F
 for <selinux@tycho.nsa.gov>; Sat, 26 May 2018 20:42:48 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sat, 26 May 2018 20:42:09 +0200
Message-Id: <20180526184213.4896-4-nicolas.iooss@m4x.org>
In-Reply-To: <20180526184213.4896-1-nicolas.iooss@m4x.org>
References: <20180526184213.4896-1-nicolas.iooss@m4x.org>
Subject: [PATCH 3/7] libsepol: remove some dead assignments
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang's static analyzer warns about dead assignments to local variables.
In module_to_cil.c, there are some which are quite straightforward to
review. Remove them.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index ba8311ea7c75..310cf1a7b1c1 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -1099,7 +1099,6 @@ static int roletype_role_in_ancestor_to_cil(struct policydb *pdb, struct stack *
 		goto exit;
 	}
 
-	curr = role_list->head;
 	for (curr = role_list->head; curr != NULL; curr = curr->next) {
 		role_node = curr->data;
 		if (!is_id_in_ancestor_scope(pdb, decl_stack, role_node->role_name, SYM_ROLES)) {
@@ -1291,7 +1290,6 @@ static int cond_expr_to_cil(int indent, struct policydb *pdb, struct cond_expr *
 				rc = -1;
 				goto exit;
 			}
-			num_params = 0;
 		} else {
 			switch(curr->expr_type) {
 			case COND_NOT:	op = "not";	break;
@@ -1831,8 +1829,6 @@ static int constraint_expr_to_string(struct policydb *pdb, struct constraint_exp
 				free(names);
 				names = NULL;
 			}
-
-			num_params = 0;
 		} else {
 			switch (expr->expr_type) {
 			case CEXPR_NOT: op = "not"; break;
-- 
2.17.0
