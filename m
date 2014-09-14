Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s8ELg5sM009297
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 17:42:20 -0400
Received: by mail-wi0-f174.google.com with SMTP id n3so3196572wiv.13
 for <selinux@tycho.nsa.gov>; Sun, 14 Sep 2014 14:42:27 -0700 (PDT)
Received: from eversmanni.localdomain (193.147.102.84.rev.sfr.net.
 [84.102.147.193])
 by mx.google.com with ESMTPSA id bj7sm12547688wjc.33.2014.09.14.14.42.25
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 14 Sep 2014 14:42:26 -0700 (PDT)
From: Nicolas Iooss <nicolas.iooss@m4x.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 11/20] libsepol: fix most gcc -Wwrite-strings warnings
Date: Sun, 14 Sep 2014 23:41:42 +0200
Message-Id: <1410730911-14512-12-git-send-email-nicolas.iooss@m4x.org>
In-Reply-To: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
References: <1410730911-14512-1-git-send-email-nicolas.iooss@m4x.org>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

gcc puts literal strings lie in read-only memory.  On x86_64, trying to
write to them triggers a segmentation fault.

To detect such issues at build time, variables holding a pointer to such
strings should be "const char*".  "gcc -Wwrite-strings" warns when using
non-const pointers to literal strings.

Remove gcc warnings by adding const to local variables and argumens of
internal functions.

This does *not* fix this warning:

  policydb_public.c:208:10: warning: passing argument 2 of 'hashtab_search' discards 'const' qualifier from pointer target type
    return (hashtab_search(p->p.p_classes.table, PACKET_CLASS_NAME) ==
            ^
  In file included from ../include/sepol/policydb/symtab.h:16:0,
                   from ../include/sepol/policydb/policydb.h:60,
                   from policydb_public.c:4:
  ../include/sepol/policydb/hashtab.h:98:24: note: expected 'hashtab_key_t' but argument is of type 'const char *'
  extern hashtab_datum_t hashtab_search(hashtab_t h, const hashtab_key_t k);
                         ^

Moreover the "const" word in hashtab_search prototype does not make the
second parameter "const char*" but "char* const".
---
 libsepol/include/sepol/policydb/services.h |  2 +-
 libsepol/src/link.c                        |  6 +++---
 libsepol/src/policydb.c                    |  2 +-
 libsepol/src/policydb_internal.h           |  2 +-
 libsepol/src/services.c                    | 12 ++++++------
 libsepol/src/write.c                       |  2 +-
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/libsepol/include/sepol/policydb/services.h b/libsepol/include/sepol/policydb/services.h
index e4e8362cdfb3..bcde47b8d618 100644
--- a/libsepol/include/sepol/policydb/services.h
+++ b/libsepol/include/sepol/policydb/services.h
@@ -223,7 +223,7 @@ extern int sepol_fs_use(const char *fstype,	/* IN */
  * fixed labeling behavior like transition SIDs or task SIDs.
  */
 extern int sepol_genfs_sid(const char *fstype,	/* IN */
-			   char *name,	/* IN */
+			   const char *name,	/* IN */
 			   sepol_security_class_t sclass,	/* IN */
 			   sepol_security_id_t * sid);	/* OUT  */
 
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index c8c510a7da9e..e0bb1988d72d 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -2089,7 +2089,7 @@ static int debug_requirements(link_state_t * state, policydb_t * p)
 		if (ret < 0) {
 			return ret;
 		} else if (ret == 0) {
-			char *mod_name = cur->branch_list->module_name ?
+			const char *mod_name = cur->branch_list->module_name ?
 			    cur->branch_list->module_name : "BASE";
 			if (req.symbol_type == SYM_CLASSES) {
 				struct find_perm_arg fparg;
@@ -2148,7 +2148,7 @@ static void print_missing_requirements(link_state_t * state,
 				       missing_requirement_t * req)
 {
 	policydb_t *p = state->base;
-	char *mod_name = cur->branch_list->module_name ?
+	const char *mod_name = cur->branch_list->module_name ?
 	    cur->branch_list->module_name : "BASE";
 
 	if (req->symbol_type == SYM_CLASSES) {
@@ -2220,7 +2220,7 @@ static int enable_avrules(link_state_t * state, policydb_t * pol)
 			}
 			decl = block->branch_list;
 			if (state->verbose) {
-				char *mod_name = decl->module_name ?
+				const char *mod_name = decl->module_name ?
 				    decl->module_name : "BASE";
 				INFO(state->handle, "check module %s decl %d\n",
 				     mod_name, decl->decl_id);
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 19fbfea93c5a..f077b9312dd3 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -55,7 +55,7 @@
 #include "mls.h"
 
 #define POLICYDB_TARGET_SZ   ARRAY_SIZE(policydb_target_strings)
-char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
+const char *policydb_target_strings[] = { POLICYDB_STRING, POLICYDB_XEN_STRING };
 
 /* These need to be updated if SYM_NUM or OCON_NUM changes */
 static struct policydb_compat_info policydb_compat[] = {
diff --git a/libsepol/src/policydb_internal.h b/libsepol/src/policydb_internal.h
index 8a31506e870d..f7bcdfa3df31 100644
--- a/libsepol/src/policydb_internal.h
+++ b/libsepol/src/policydb_internal.h
@@ -6,5 +6,5 @@
 
 hidden_proto(sepol_policydb_create)
     hidden_proto(sepol_policydb_free)
-extern char *policydb_target_strings[];
+extern const char *policydb_target_strings[];
 #endif
diff --git a/libsepol/src/services.c b/libsepol/src/services.c
index a1a0b98c73da..d64a8e8d7bcf 100644
--- a/libsepol/src/services.c
+++ b/libsepol/src/services.c
@@ -174,7 +174,7 @@ static char **expr_list;
 static int expr_buf_used;
 static int expr_buf_len;
 
-static void cat_expr_buf(char *e_buf, char *string)
+static void cat_expr_buf(char *e_buf, const char *string)
 {
 	int len, new_buf_len;
 	char *p, *new_buf = e_buf;
@@ -209,7 +209,7 @@ static void cat_expr_buf(char *e_buf, char *string)
  * POLICYDB_VERSION_CONSTRAINT_NAMES) just read the e->names list.
  */
 static void get_name_list(constraint_expr_t *e, int type,
-							char *src, char *op, int failed)
+							const char *src, const char *op, int failed)
 {
 	ebitmap_t *types;
 	int rc = 0;
@@ -273,7 +273,7 @@ static void get_name_list(constraint_expr_t *e, int type,
 	return;
 }
 
-static void msgcat(char *src, char *tgt, char *op, int failed)
+static void msgcat(const char *src, const char *tgt, const char *op, int failed)
 {
 	char tmp_buf[128];
 	if (failed)
@@ -303,7 +303,7 @@ static char *get_class_info(sepol_security_class_t tclass,
 	}
 
 	/* Determine statement type */
-	char *statements[] = {
+	const char *statements[] = {
 		"constrain ",			/* 0 */
 		"mlsconstrain ",		/* 1 */
 		"validatetrans ",		/* 2 */
@@ -771,7 +771,7 @@ mls_ops:
 	 * These contain the constraint components that are added to the
 	 * callers reason buffer.
 	 */
-	char *buffers[] = { class_buf, a, "); ", tmp_buf, 0 };
+	const char *buffers[] = { class_buf, a, "); ", tmp_buf, 0 };
 
 	/*
 	 * This will add the constraints to the callers reason buffer (who is
@@ -2085,7 +2085,7 @@ int hidden sepol_get_user_sids(sepol_security_id_t fromsid,
  * fixed labeling behavior like transition SIDs or task SIDs.
  */
 int hidden sepol_genfs_sid(const char *fstype,
-			   char *path,
+			   const char *path,
 			   sepol_security_class_t sclass,
 			   sepol_security_id_t * sid)
 {
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 6fe73e6e5a3a..2e6541da1e4d 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1880,7 +1880,7 @@ int policydb_write(policydb_t * p, struct policy_file *fp)
 	size_t items, items2, len;
 	struct policydb_compat_info *info;
 	struct policy_data pd;
-	char *policydb_str;
+	const char *policydb_str;
 
 	if (p->unsupported_format)
 		return POLICYDB_UNSUPPORTED;
-- 
2.1.0
