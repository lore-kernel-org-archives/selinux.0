Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u9IIvVjb022041
 for <selinux@tycho.nsa.gov>; Tue, 18 Oct 2016 14:57:31 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 3/7] libsepol/cil: Use an empty list to represent an unknown
 permission
Date: Tue, 18 Oct 2016 14:58:44 -0400
Message-Id: <1476817128-16108-4-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1476817128-16108-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Nicolas Looss found while fuzzing secilc with AFL that the statement
"(classpermissionset CPERM (CLASS (and unknow PERM)))" will cause a
segfault.

In order to support a policy module package using a permission that
does not exist on the system it is loaded on, CIL will only give a
warning when it fails to resolve an unknown permission. CIL itself will
just ignore the unknown permission. This means that an expression like
"(and UNKNOWN p1)" will look like "(and p1)" to CIL, but, since syntax
checking has already been done, CIL won't know that the expression is not
well-formed. When the expression is evaluated a segfault will occur
because all expressions are assumed to be well-formed at evaluation time.

Use an empty list to represent an unknown permission so that expressions
will continue to be well-formed and expression evaluation will work but
the unknown permission will still be ignored.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/cil/src/cil_resolve_ast.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
index c403545..f3f3e92 100644
--- a/libsepol/cil/src/cil_resolve_ast.c
+++ b/libsepol/cil/src/cil_resolve_ast.c
@@ -131,7 +131,11 @@ static int __cil_resolve_perms(symtab_t *class_symtab, symtab_t *common_symtab,
 				}
 			}
 			if (rc != SEPOL_OK) {
+				struct cil_list *empty_list;
 				cil_log(CIL_WARN, "Failed to resolve permission %s\n", (char*)curr->data);
+				/* Use an empty list to represent unknown perm */
+				cil_list_init(&empty_list, perm_strs->flavor);
+				cil_list_append(*perm_datums, CIL_LIST, empty_list);
 			} else {
 				cil_list_append(*perm_datums, CIL_DATUM, perm_datum);
 			}
-- 
2.7.4
