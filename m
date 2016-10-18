Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVja022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:31 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/7] libsepol/cil: Use empty list for category expression
 evaluated as empty
Date: Tue, 18 Oct 2016 14:58:43 -0400
Message-Id: <1476817128-16108-3-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nicolas Looss found while fuzzing secilc with AFL that the following
policy will cause a segfault.

(category c0)
(category c1)
(categoryorder (c0 c1))
(sensitivity s0)
(sensitivitycategory s0 (not (all)))

The expression "(not (all))" is evaluated as containing no categories.
There is a check for the resulting empty list and the category datum
expression is set to NULL. The segfault occurs because the datum
expression is assumed to be non-NULL after evaluation.

Assign the list to the datum expression even if it is empty.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_post.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index caf3321..687962e 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -865,13 +865,7 @@ static int __evaluate_cat_expression(struct cil_cats *cats, struct cil_db *db)
 
 	ebitmap_destroy(&bitmap);
 	cil_list_destroy(&cats->datum_expr, CIL_FALSE);
-	if (new->head != NULL) { 
-		cats->datum_expr = new;
-	} else {
-		/* empty list */
-		cil_list_destroy(&new, CIL_FALSE);
-		cats->datum_expr = NULL;
-	}
+	cats->datum_expr = new;
 
 	cats->evaluated = CIL_TRUE;
 
-- 
2.7.4
