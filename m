Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93KrW4r004766
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 16:53:33 -0400
Received: from localhost.localdomain (32.206.133.77.rev.sfr.net
 [77.133.206.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ssl.polytechnique.org (Postfix) with ESMTPSA id 9460D564726
 for <selinux@tycho.nsa.gov>; Mon,  3 Oct 2016 22:47:01 +0200 (CEST)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol/cil: make cil_resolve_name() fail for '.'
Date: Mon,  3 Oct 2016 22:46:55 +0200
Message-Id: <20161003204657.2635-2-nicolas.iooss@m4x.org>
In-Reply-To: <20161003204657.2635-1-nicolas.iooss@m4x.org>
References: <20161003204657.2635-1-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This CIL policy makes secilc crash with a NULL pointer dereference:

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

    (allow . self (CLASS (PERM)))

Using "." in the allow statement makes strtok_r() return NULL in
cil_resolve_name() and this result is then used in a call to
cil_symtab_get_datum(), which is thus invalid.

Instead of crashing, make secilc fail with an error message.

This bug has been found by fuzzing secilc with american fuzzy lop.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/cil/src/cil_resolve_ast.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index 917adf8d23da..5b86908c4120 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -4027,7 +4027,13 @@ int cil_resolve_name(struct cil_tree_node *ast_node, char *name, enum cil_sym_in
 		char *current = strtok_r(name_dup, ".", &sp);
 		char *next = strtok_r(NULL, ".", &sp);
 		symtab_t *symtab = NULL;
-		
+
+		if (current == NULL) {
+			/* Only dots */
+			cil_tree_log(ast_node, CIL_ERR, "Invalid name %s", name);
+			goto exit;
+		}
+
 		node = ast_node;
 		if (*name == '.') {
 			/* Leading '.' */
-- 
2.10.0
