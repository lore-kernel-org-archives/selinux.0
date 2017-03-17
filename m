Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2HLUoEi026224
 for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2017 17:30:50 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 87FDA564924
 for <selinux@tycho.nsa.gov>; Fri, 17 Mar 2017 22:30:47 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/1] libsepol/cil: avoid freeing uninitialized values
Date: Fri, 17 Mar 2017 22:30:40 +0100
Message-Id: <20170317213040.21714-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

cil_resolve_ast() begins by checking whether one of its parameters is
NULL and "goto exit;" when it is the case. As extra_args has not been
initialized there, this leads to calling cil_destroy_tree_node_stack(),
__cil_ordered_lists_destroy()... on garbage values.

In practise this cannot happen because cil_resolve_ast() is only called
by cil_compile() after cil_build_ast() succeeded. As the if condition
exists nonetheless, fix the body of the if block in order to silence a
warning reported by clang Static Analyzer.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_resolve_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 87817ca29a5f..187050116379 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3797,7 +3797,7 @@ int cil_resolve_ast(struct cil_db *db, struct cil_tree_node *current)
 	uint32_t changed = 0;
 
 	if (db == NULL || current == NULL) {
-		goto exit;
+		return rc;
 	}
 
 	extra_args.db = db;
-- 
2.12.0
