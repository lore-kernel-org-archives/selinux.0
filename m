Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uAMMOHjs010064
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 17:24:18 -0500
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id DB5AD56481F
 for <selinux@tycho.nsa.gov>; Tue, 22 Nov 2016 23:24:14 +0100 (CET)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/5] libsepol: do not call a NULL function in
 additive_scopes_to_cil()
Date: Tue, 22 Nov 2016 23:23:38 +0100
Message-Id: <20161122222342.16771-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When hll/pp operates on an invalid policy module which defines blocks
with non-empty decl->symtab[SYM_COMMONS], additive_scopes_to_cil_map()
calls func_to_cil[SYM_COMMONS], which is NULL.

In additive_scopes_to_cil(), filter out NULL elements of func_to_cil
before calling additive_scopes_to_cil_map().

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/module_to_cil.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
index b7d3b5eb57eb..ab3ac03d7895 100644
--- a/libsepol/src/module_to_cil.c
+++ b/libsepol/src/module_to_cil.c
@@ -3530,6 +3530,9 @@ static int additive_scopes_to_cil(int indent, struct policydb *pdb, struct avrul
 	struct avrule_decl *decl = stack_peek(decl_stack);
 
 	for (args.sym_index = 0; args.sym_index < SYM_NUM; args.sym_index++) {
+		if (func_to_cil[args.sym_index] == NULL) {
+			continue;
+		}
 		rc = hashtab_map(decl->symtab[args.sym_index].table, additive_scopes_to_cil_map, &args);
 		if (rc != 0) {
 			goto exit;
-- 
2.10.2
