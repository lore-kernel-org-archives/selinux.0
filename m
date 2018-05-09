From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Date: Wed,  9 May 2018 11:29:04 -0400
Message-Id: <20180509152904.11822-1-sds@tycho.nsa.gov>
Subject: [PATCH] libsepol: cil: prevent stack buffer overflow in
 cil_expr_to_string
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix the test to prevent overflowing the stack buffer for
boolean expressions.

Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
---
 libsepol/cil/src/cil_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_tree.c b/libsepol/cil/src/cil_tree.c
index 2abbb96c..1b04fe68 100644
--- a/libsepol/cil/src/cil_tree.c
+++ b/libsepol/cil/src/cil_tree.c
@@ -339,7 +339,7 @@ static int cil_expr_to_string(struct cil_list *expr, char **out)
 	int pos = 0;
 
 	cil_list_for_each(curr, expr) {
-		if (pos > COND_EXPR_MAXDEPTH) {
+		if (pos >= COND_EXPR_MAXDEPTH) {
 			rc = SEPOL_ERR;
 			goto exit;
 		}
-- 
2.14.3
