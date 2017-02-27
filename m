Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v1RKdnva023546
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 15:39:50 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 3E0CB5605F9
 for <selinux@tycho.nsa.gov>; Mon, 27 Feb 2017 21:39:47 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/6] libsepol/cil: do not dereference args before checking it
 was not null
Date: Mon, 27 Feb 2017 21:39:31 +0100
Message-Id: <20170227203935.23674-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170227203935.23674-1-nicolas.iooss@m4x.org>
References: <20170227203935.23674-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_resolve_ast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 5e5298d98e61..87817ca29a5f 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -3313,11 +3313,12 @@ int __cil_resolve_ast_node(struct cil_tree_node *node, void *extra_args)
 	int rc = SEPOL_OK;
 	struct cil_args_resolve *args = extra_args;
 	enum cil_pass pass = 0;
-	struct cil_list *ins = args->in_list;
+	struct cil_list *ins;
 
 	if (node == NULL || args == NULL) {
 		goto exit;
 	}
+	ins = args->in_list;
 
 	pass = args->pass;
 	switch (pass) {
-- 
2.11.1
