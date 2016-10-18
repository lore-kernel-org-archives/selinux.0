Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVjZ022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:31 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/7] libsepol/cil: Check for improper category range
Date: Tue, 18 Oct 2016 14:58:42 -0400
Message-Id: <1476817128-16108-2-git-send-email-jwcart2@tycho.nsa.gov>
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
(sensitivitycategory s0 (range c1 c0))

The category range "(range c1 c0)" is invalid because c1 comes after c0
in order.

The invalid range is evaluated as containing no categories. There is a
check for the resulting empty list and the category datum expression is
set to NULL. The segfault occurs because the datum expression is assumed
to be non-NULL after evaluation.

Add a check for an invalid range when evaluating category ranges.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_post.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index f8447c9..caf3321 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -952,6 +952,11 @@ static int __cil_cat_expr_range_to_bitmap_helper(struct cil_list_item *i1, struc
 		c2 = alias->actual;
 	}
 
+	if (c1->value > c2->value) {
+		cil_log(CIL_ERR, "Invalid category range\n");
+		goto exit;
+	}
+
 	for (i = c1->value; i <= c2->value; i++) {
 		if (ebitmap_set_bit(bitmap, i, 1)) {
 			cil_log(CIL_ERR, "Failed to set cat bit\n");
-- 
2.7.4
