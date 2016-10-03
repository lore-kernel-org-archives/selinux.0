Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93KrW4q004766
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 16:53:32 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id BD57C564740
 for <selinux@tycho.nsa.gov>; Mon,  3 Oct 2016 22:47:01 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/3] libsepol/cil: fix double-free in cil categories parser
Date: Mon,  3 Oct 2016 22:46:56 +0200
Message-Id: <20161003204657.2635-3-nicolas.iooss@m4x.org>
In-Reply-To: <20161003204657.2635-1-nicolas.iooss@m4x.org>
References: <20161003204657.2635-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When cil_fill_cats() fails to parse an expression and destroys a
category set, it fails to reset *cats to NULL. This makes this object be
destroyed again in cil_destroy_catset().

This bug can be triggered by the following policy:

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

    (categoryset cats (range unknown))

This bug has been found by fuzzing secilc with american fuzzy lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index a96c2a95ca3f..f57bd21358d3 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5481,6 +5481,7 @@ int cil_fill_cats(struct cil_tree_node *curr, struct cil_cats **cats)
 	rc = cil_gen_expr(curr, CIL_CAT, &(*cats)->str_expr);
 	if (rc != SEPOL_OK) {
 		cil_destroy_cats(*cats);
+		*cats = NULL;
 	}
 
 	return rc;
-- 
2.10.0
