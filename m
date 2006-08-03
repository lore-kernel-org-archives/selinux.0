Subject: [PATCH 2/2] Refactor expander
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: selinux@tycho.nsa.gov
Cc: selinux-dev@tresys.com, sds@tycho.nsa.gov
Content-Type: text/plain
Date: Thu, 03 Aug 2006 09:39:05 -0400
Message-Id: <1154612345.12897.45.camel@Bishop.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch adds a new function called expand_module_avrules that creates
an expand_state object and expands the avrules (including the
neverallows).  This function permits external users of libsepol to
expand the avrules into the same policy.  We refactored and created a
static function called copy_and_expand_avrule_block since its
functionality is needed in the original expand_module and the new
expand_module_avrules functions. 

(This is a resend of the previous patch set with corrections made as per
suggestions on the list.)

Jeremy A. Mowery
Tresys Technology
410-290-1411 x148

diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/include/sepol/policydb/expand.h branch/setools_public-policydb-components/libsepol/include/sepol/policydb/expand.h
--- trunk/libsepol/include/sepol/policydb/expand.h	2006-07-13 10:19:14.000000000 -0400
+++ trunk/libsepol/include/sepol/policydb/expand.h	2006-07-26 11:51:39.000000000 -0400
@@ -29,6 +29,22 @@
 #include <sepol/handle.h>
 #include <sepol/policydb/conditional.h>
 
+/*
+ * Expand only the avrules for a module (optionally including
+ * neverallow rules). It is valid for this function to expand
+ * base into itself (i.e. base == out); the typemap for this
+ * special case should map type[i] to i+1. No assertion or 
+ * hierarchy checking is performed.
+ */
+extern int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
+				 policydb_t * out, uint32_t * typemap,
+				 int verbose, int expand_neverallow);
+/*
+ * Expand all parts of a module. Neverallow rules are not
+ * expanded (only copied). It is not valid to expand base
+ * into itself. If check is non-zero, performs hierarchy
+ * and assertion checking.
+ */
 extern int expand_module(sepol_handle_t * handle,
 			 policydb_t * base, policydb_t * out,
 			 int verbose, int check);
diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' trunk/libsepol/src/expand.c branch/setools_public-policydb-components/libsepol/src/expand.c
--- trunk/libsepol/src/expand.c	2006-08-01 15:36:17.000000000 -0400
+++ trunk/libsepol/src/expand.c	2006-08-01 09:54:12.000000000 -0400
@@ -44,6 +44,11 @@ typedef struct expand_state {
 	int expand_neverallow;
 } expand_state_t;
 
+static void expand_state_init(expand_state_t * state)
+{
+	memset(state, 0, sizeof(expand_state_t));
+}
+
 static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -1897,6 +1902,82 @@ static int copy_neverallow(policydb_t * 
 	return -1;
 }
 
+static int copy_and_expand_avrule_block(expand_state_t * state)
+{
+	avrule_block_t *curblock;
+	int retval = -1;
+
+	for (curblock = state->base->global; curblock != NULL;
+	     curblock = curblock->next) {
+		avrule_decl_t *decl = curblock->enabled;
+		avrule_t *cur_avrule;
+
+		if (decl == NULL) {
+			/* nothing was enabled within this block */
+			continue;
+		}
+
+		/* copy role allows and role trans */
+		if (copy_role_allows(state, decl->role_allow_rules) != 0 ||
+		    copy_role_trans(state, decl->role_tr_rules) != 0) {
+			goto cleanup;
+		}
+
+		/* copy rules */
+		cur_avrule = decl->avrules;
+		while (cur_avrule != NULL) {
+			if (!(state->expand_neverallow)
+			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
+				/* copy this over directly so that assertions are checked later */
+				if (copy_neverallow
+				    (state->out, state->typemap, cur_avrule))
+					ERR(state->handle,
+					    "Error while copying neverallow.");
+			} else {
+				if (cur_avrule->specified & AVRULE_NEVERALLOW) {
+					state->out->unsupported_format = 1;
+				}
+				if (convert_and_expand_rule
+				    (state->handle, state->out, state->typemap,
+				     cur_avrule, &state->out->te_avtab, NULL,
+				     NULL, 0,
+				     state->expand_neverallow) !=
+				    EXPAND_RULE_SUCCESS) {
+					goto cleanup;
+				}
+			}
+			cur_avrule = cur_avrule->next;
+		}
+
+		/* copy conditional rules */
+		if (cond_node_copy(state, decl->cond_list))
+			goto cleanup;
+	}
+
+	retval = 0;
+
+      cleanup:
+	return retval;
+}
+
+int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
+			  policydb_t * out, uint32_t * typemap, int verbose,
+			  int expand_neverallow)
+{
+	expand_state_t state;
+
+	expand_state_init(&state);
+
+	state.base = base;
+	state.out = out;
+	state.typemap = typemap;
+	state.handle = handle;
+	state.verbose = verbose;
+	state.expand_neverallow = expand_neverallow;
+
+	return copy_and_expand_avrule_block(&state);
+}
+
 /* Linking should always be done before calling expand, even if
  * there is only a base since all optionals are dealt with at link time
  * the base passed in should be indexed and avrule blocks should be 
@@ -1910,6 +1991,8 @@ int expand_module(sepol_handle_t * handl
 	expand_state_t state;
 	avrule_block_t *curblock;
 
+	expand_state_init(&state);
+
 	state.verbose = verbose;
 	state.typemap = NULL;
 	state.base = base;
@@ -2026,50 +2109,9 @@ int expand_module(sepol_handle_t * handl
 
 	}
 
-	/* then loop through delcs to copy and expand rules */
-	for (curblock = state.base->global; curblock != NULL;
-	     curblock = curblock->next) {
-		avrule_decl_t *decl = curblock->enabled;
-		avrule_t *cur_avrule;
-
-		if (decl == NULL) {
-			/* nothing was enabled within this block */
-			continue;
-		}
-
-		/* copy role allows and role trans */
-		if (copy_role_allows(&state, decl->role_allow_rules) != 0 ||
-		    copy_role_trans(&state, decl->role_tr_rules) != 0) {
-			goto cleanup;
-		}
-
-		/* copy rules */
-		cur_avrule = decl->avrules;
-		while (cur_avrule != NULL) {
-			if (!(state.expand_neverallow)
-			    && cur_avrule->specified & AVRULE_NEVERALLOW) {
-				/* copy this over directly so that assertions are checked later */
-				if (copy_neverallow
-				    (out, state.typemap, cur_avrule))
-					ERR(handle,
-					    "Error while copying neverallow.");
-			} else {
-				if (cur_avrule->specified & AVRULE_NEVERALLOW) {
-					state.out->unsupported_format = 1;
-				}
-				if (convert_and_expand_rule
-				    (state.handle, out, state.typemap,
-				     cur_avrule, &out->te_avtab, NULL, NULL,
-				     0, 0) != 1) {
-					goto cleanup;
-				}
-			}
-			cur_avrule = cur_avrule->next;
-		}
-
-		/* copy conditional rules */
-		if (cond_node_copy(&state, decl->cond_list))
-			goto cleanup;
+	if (copy_and_expand_avrule_block(&state) < 0) {
+		ERR(handle, "Error during expand");
+		goto cleanup;
 	}
 
 	/* copy constraints */


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
