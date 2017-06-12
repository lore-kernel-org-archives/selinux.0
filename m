Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5C8VLwg005836
 for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2017 04:31:21 -0400
From: Richard Haines <richard_c_haines@btinternet.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsepol/cil: ibendportcon fails to resolve in CIL policy
Date: Mon, 12 Jun 2017 09:31:10 +0100
Message-Id: <20170612083110.5042-1-richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Fix named ibendportcon context not resolving correctly.

Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
---
 libsepol/cil/src/cil_build_ast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 4258b18..04492e5 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -4698,7 +4698,7 @@ int cil_gen_ibendportcon(__attribute__((unused)) struct cil_db *db, struct cil_t
 	}
 
 	if (!parse_current->next->next->next->cl_head) {
-		ibendportcon->context_str = parse_current->next->next->data;
+		ibendportcon->context_str = parse_current->next->next->next->data;
 	} else {
 		cil_context_init(&ibendportcon->context);
 
-- 
2.9.4
