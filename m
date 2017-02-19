Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1JAW5dj005068
 for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2017 05:32:05 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 997855648F6
 for <selinux@tycho.nsa.gov>; Sun, 19 Feb 2017 11:31:34 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/5] libsepol/cil: free the first operand if the second one is
 invalid
Date: Sun, 19 Feb 2017 11:30:56 +0100
Message-Id: <20170219103058.32429-3-nicolas.iooss@m4x.org>
In-Reply-To: <20170219103058.32429-1-nicolas.iooss@m4x.org>
References: <20170219103058.32429-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When __cil_expr_to_bitmap() fails to parse the second operand of an
operation with two operands, it returns an error without destroying the
bitmap which has been created for the first operand. Fix this memory
leak.

This has been tested with the following policy:

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

    (permissionx ioctl_test (ioctl CLASS
        (and (range 0x1600 0x19FF) (.ot (range 0x1750 0x175F)))))

This memory leak has been found by running clang's Address Sanitizer on
a set of policies generated from secilc/test/policy.cil by American
Fuzzy Lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_post.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
index 2de55b562b8f..48a7bd3daeb8 100644
--- a/libsepol/cil/src/cil_post.c
+++ b/libsepol/cil/src/cil_post.c
@@ -1105,6 +1105,7 @@ static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max,
 				rc = __cil_expr_to_bitmap_helper(curr->next->next, flavor, &b2, max, db);
 				if (rc != SEPOL_OK) {
 					cil_log(CIL_INFO, "Failed to get second operand bitmap\n");
+					ebitmap_destroy(&b1);
 					goto exit;
 				}
 
-- 
2.11.1
