Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v83CLxhn026271
 for <selinux@tycho.nsa.gov>; Sun, 3 Sep 2017 08:21:59 -0400
Received: from localhost.localdomain (abo-140-56-69.avi.modulonet.fr
 [85.69.56.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 5E0395646D2
 for <selinux@tycho.nsa.gov>; Sun,  3 Sep 2017 14:20:05 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Date: Sun,  3 Sep 2017 14:19:26 +0200
Message-Id: <20170903121928.24024-4-nicolas.iooss@m4x.org>
In-Reply-To: <20170903121928.24024-1-nicolas.iooss@m4x.org>
References: <20170903121928.24024-1-nicolas.iooss@m4x.org>
Subject: [PATCH 4/6] libsepol/cil: drop wrong unused attribute
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

cil_gen_node() has been using its argument "db" since commit
fafe4c212bf6 ("libsepol: cil: Add ability to redeclare
types[attributes]"). Drop attribute "unused" on this argument.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 9fc8ab87dec2..e84336bfbe73 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -104,7 +104,7 @@ int cil_is_datum_multiple_decl(__attribute__((unused)) struct cil_symtab_datum *
 	return rc;
 }
 
-int cil_gen_node(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor)
+int cil_gen_node(struct cil_db *db, struct cil_tree_node *ast_node, struct cil_symtab_datum *datum, hashtab_key_t key, enum cil_sym_index sflavor, enum cil_flavor nflavor)
 {
 	int rc = SEPOL_ERR;
 	symtab_t *symtab = NULL;
-- 
2.14.1
