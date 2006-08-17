Subject: [PATCH 2/2 v3] Refactor expander
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Thu, 17 Aug 2006 10:33:12 -0400
Message-Id: <1155825193.2921.114.camel@Bishop.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a new function called expand_module_avrules that creates
an expand_state object and expands the avrules (optionally including the
neverallows). This function permits external users of libsepol to
expand the avrules into the same policy.  We refactored and created a
static function called copy_and_expand_avrule_block since its
functionality is needed in the original expand_module and the new
expand_module_avrules functions.

Jeremy A. Mowery
Tresys Technology
410-290-1411 x148

Index: trunk/libsepol/include/sepol/policydb/expand.h
===================================================================
--- trunk/libsepol/include/sepol/policydb/expand.h	(revision 1110)
+++ trunk/libsepol/include/sepol/policydb/expand.h	(working copy)
@@ -29,6 +29,24 @@
 #include <sepol/handle.h>
 #include <sepol/policydb/conditional.h>
 
+/*
+ * Expand only the avrules for a module. It is valid for this function to
+ * expand base into itself (i.e.  base == out); the typemap for this special
+ * case should map type[i] to i+1.  This function optionally expands neverallow
+ * rules. If neverallow rules are expanded, there is no need to copy them and
+ * doing so could cause duplicate entries when base == out. If the neverallow
+ * rules are not expanded, they are just copied to the destination policy so
+ * that assertion checking can be performed after expand. No assertion or
+ * hierarchy checking is performed by this function.
+ */
+extern int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
+				 policydb_t * out, uint32_t * typemap,
+				 int verbose, int expand_neverallow);
+/*
+ * Expand all parts of a module. Neverallow rules are not expanded (only
+ * copied). It is not valid to expand base into itself. If check is non-zero,
+ * performs hierarchy and assertion checking.
+ */
 extern int expand_module(sepol_handle_t * handle,
 			 policydb_t * base, policydb_t * out,
 			 int verbose, int check);
Index: trunk/libsepol/src/expand.c
===================================================================
--- trunk/libsepol/src/expand.c	(revision 1110)
+++ trunk/libsepol/src/expand.c	(working copy)
@@ -1906,6 +1906,93 @@
 	return -1;
 }
 
+/* 
+ * Expands the avrule blocks for a policy. RBAC rules are copied. Neverallow
+ * rules are copied or expanded as per the settings in the state object; all
+ * other AV rules are expanded.  If neverallow rules are expanded, they are not
+ * copied, otherwise they are copied for later use by the assertion checker.
+ */
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
+/* 
+ * This function allows external users of the library (such as setools) to
+ * expand only the avrules and optionally perform expansion of neverallow rules
+ * or expand into the same policy for analysis purposes.
+ */
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
@@ -2037,47 +2124,9 @@
 
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
-				if (convert_and_expand_rule
-				    (state.handle, out, state.typemap,
-				     cur_avrule, &out->te_avtab, NULL, NULL,
-				     0, state.expand_neverallow) != EXPAND_RULE_SUCCESS) {
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
