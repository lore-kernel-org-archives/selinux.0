Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u0VAbIJU020323
 for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2016 05:37:20 -0500
Received: from iosakhe.localdomain (32.206.133.77.rev.sfr.net [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 8B899564885
 for <selinux@tycho.nsa.gov>; Sun, 31 Jan 2016 11:37:13 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol: cil: always initialize
 __cil_permx_to_sepol_class_perms() result
Date: Sun, 31 Jan 2016 11:36:36 +0100
Message-Id: <1454236598-1829-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

clang warns that __cil_permx_to_sepol_class_perms() return value, rc,
may be unitialized:

    ../cil/src/cil_binary.c:4188:9: error: variable 'rc' may be
    uninitialized when used here [-Werror,-Wconditional-uninitialized]
            return rc;
                   ^~
    ../cil/src/cil_binary.c:4148:8: note: initialize the variable 'rc'
    to silence this warning
            int rc;
                  ^
                   = 0

This theoretically happens when cil_expand_class(permx->obj) returns an
empty list.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_binary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
index 433f92e40a8e..47c751c0ef06 100644
--- a/libsepol/cil/src/cil_binary.c
+++ b/libsepol/cil/src/cil_binary.c
@@ -4145,7 +4145,7 @@ exit:
 
 static int __cil_permx_to_sepol_class_perms(policydb_t *pdb, struct cil_permissionx *permx, class_perm_node_t **sepol_class_perms)
 {
-	int rc;
+	int rc = SEPOL_OK;
 	struct cil_list *class_list = NULL;
 	struct cil_list_item *c;
 	class_datum_t *sepol_obj = NULL;
-- 
2.7.0
