Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v3BLkUKi001912
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 17:46:30 -0400
Received: from localhost.localdomain (81-66-120-207.rev.numericable.fr
 [81.66.120.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id B31AA5647D8
 for <selinux@tycho.nsa.gov>; Tue, 11 Apr 2017 23:46:28 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/6] libsepol: cil: check cil_fill_list return value
Date: Tue, 11 Apr 2017 23:45:59 +0200
Message-Id: <20170411214603.28040-2-nicolas.iooss@m4x.org>
In-Reply-To: <20170411214603.28040-1-nicolas.iooss@m4x.org>
References: <20170411214603.28040-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

cil_gen_default() and cil_gen_defaultrange() call cil_fill_list()
without checking its return value. If it failed, propagate the return
value to the caller.

This issue has been found using clang's static analyzer. It reported
"warning: Value stored to 'rc' is never read" four times.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_build_ast.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libsepol/cil/src/cil_build_ast.c b/libsepol/cil/src/cil_build_ast.c
index 8a19df480989..4b03dc35d408 100644
--- a/libsepol/cil/src/cil_build_ast.c
+++ b/libsepol/cil/src/cil_build_ast.c
@@ -5592,9 +5592,11 @@ int cil_gen_default(struct cil_tree_node *parse_current, struct cil_tree_node *a
 	if (parse_current->next->cl_head == NULL) {
 		cil_list_init(&def->class_strs, CIL_CLASS);
 		cil_list_append(def->class_strs, CIL_STRING, parse_current->next->data);
-		rc = SEPOL_OK;
 	} else {
 		rc = cil_fill_list(parse_current->next->cl_head, CIL_CLASS, &def->class_strs);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
 	}
 
 	object = parse_current->next->next->data;
@@ -5657,9 +5659,11 @@ int cil_gen_defaultrange(struct cil_tree_node *parse_current, struct cil_tree_no
 	if (parse_current->next->cl_head == NULL) {
 		cil_list_init(&def->class_strs, CIL_CLASS);
 		cil_list_append(def->class_strs, CIL_STRING, parse_current->next->data);
-		rc = SEPOL_OK;
 	} else {
 		rc = cil_fill_list(parse_current->next->cl_head, CIL_CLASS, &def->class_strs);
+		if (rc != SEPOL_OK) {
+			goto exit;
+		}
 	}
 
 	object = parse_current->next->next->data;
-- 
2.12.0
