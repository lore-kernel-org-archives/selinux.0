Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1JAW5dk005068
 for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2017 05:32:05 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 4495C5648F8
 for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2017 11:31:35 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 4/5] libsepol/cil: do not leak left-hand side of an invalid
 constraint
Date: Sun, 19 Feb 2017 11:30:57 +0100
Message-Id: <20170219103058.32429-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170219103058.32429-1-nicolas.iooss@m4x.org>
References: <20170219103058.32429-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

__cil_fill_constraint_expr() does not destroy the list associated with
the first operand of a two-operand operation when the second operand is
invalid.

This memory leak can be reproduced with the following policy:

    (constrain (files (read))
        (not (or (and (eq t1 exec_t) (%q t2 bin_t)) (eq r1 r2))))

This memory leak has been found by running clang's Address Sanitizer on
a set of policies generated from secilc/test/policy.cil by American
Fuzzy Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index e4a0539f64ad..d3d663b06512 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2753,6 +2753,7 @@ static int __cil_fill_constraint_expr(struct cil_tree_node *current, enum cil_fl
 		}
 		rc = __cil_fill_constraint_expr(current->next->next->cl_head, flavor, &rexpr, depth);
 		if (rc != SEPOL_OK) {
+			cil_list_destroy(&lexpr, CIL_TRUE);
 			goto exit;
 		}
 		cil_list_init(expr, flavor);
-- 
2.11.1
