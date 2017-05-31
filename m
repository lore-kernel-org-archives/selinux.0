Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v4VK78sc010433
 for <selinux@tycho.nsa.gov>; Wed, 31 May 2017 16:07:09 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id E8DBF56496D
 for <selinux@tycho.nsa.gov>; Wed, 31 May 2017 22:07:05 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/2] libsepol: do not mark db as unused when it is used
Date: Wed, 31 May 2017 22:06:15 +0200
Message-Id: <20170531200615.9166-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170531200615.9166-1-nicolas.iooss@m4x.org>
References: <20170531200615.9166-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

---
 libsepol/cil/src/cil_build_ast.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 0a9a5e57491a..7fcee61042c5 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4256,7 +4256,7 @@ void cil_destroy_filecon(struct cil_filecon *filecon)
 	free(filecon);
 }
 
-int cil_gen_ibpkeycon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+int cil_gen_ibpkeycon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
 		CIL_SYN_STRING,
@@ -4667,7 +4667,7 @@ void cil_destroy_netifcon(struct cil_netifcon *netifcon)
 	free(netifcon);
 }
 
-int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
+int cil_gen_ibendportcon(struct cil_db *db, struct cil_tree_node *parse_current, struct cil_tree_node *ast_node)
 {
 	enum cil_syntax syntax[] = {
 		CIL_SYN_STRING,
-- 
2.12.2
