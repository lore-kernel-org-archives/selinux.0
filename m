Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93KlDJ9004088
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 16:47:13 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 0F40B564743
 for <selinux@tycho.nsa.gov>; Mon,  3 Oct 2016 22:47:02 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/3] libsepol/cil: fix memory leak in __cil_fill_expr()
Date: Mon,  3 Oct 2016 22:46:57 +0200
Message-Id: <20161003204657.2635-4-nicolas.iooss@m4x.org>
In-Reply-To: <20161003204657.2635-1-nicolas.iooss@m4x.org>
References: <20161003204657.2635-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

__cil_fill_expr() initializes 'cil_list *sub_expr' but does not destroy
it when __cil_fill_expr_helper() fails. This list is therefore leaked
when __cil_fill_expr() returns.

This occurs when secilc compiles the following policy:

    (class CLASS (PERM))
    (classorder (CLASS))
    (sid SID)
    (sidorder (SID))
    (user USER)
    (role ROLE)
    (type TYPE)
    (category CAT)
    (categoryorder (CAT))
    (sensitivity SENS)
    (sensitivityorder (SENS))
    (sensitivitycategory SENS (CAT))
    (allow TYPE self (CLASS (PERM)))
    (roletype ROLE TYPE)
    (userrole USER ROLE)
    (userlevel USER (SENS))
    (userrange USER ((SENS)(SENS (CAT))))
    (sidcontext SID (USER ROLE TYPE ((SENS)(SENS))))

    (categoryset cats (not (range unknown)))

This bug has been found using gcc address sanitizer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index f57bd21358d3..ee283b535147 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -2562,6 +2562,7 @@ static int __cil_fill_expr(struct cil_tree_node *current, enum cil_flavor flavor
 		cil_list_init(&sub_expr, flavor);
 		rc = __cil_fill_expr_helper(current->cl_head, flavor, sub_expr, depth);
 		if (rc != SEPOL_OK) {
+			cil_list_destroy(&sub_expr, CIL_TRUE);
 			goto exit;
 		}
 		cil_list_append(expr, CIL_LIST, sub_expr);
-- 
2.10.0
