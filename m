Subject: [PATCH 2/2] Refactor expansion of avtab
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 25 Jul 2006 10:56:27 -0400
Message-Id: <1153839387.19259.18.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The patch adds a new function called expand_module_avrules that creates
an expand_state object and expands the avrules (including the
neverallows).  This function permits external users of libsepol to
expand the avrules into the same policy.  We refactored and created a
static function called expand_avrule_decls since its functionality is
needed in the original expand_module and the new expand_module_avrules
functions.

diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' -x '*.o' -x '*.lo' ../../../trunk/libsepol/include/sepol/policydb/expand.h ./include/sepol/policydb/expand.h
--- trunk/libsepol/include/sepol/policydb/expand.h	2006-07-13 10:19:14.000000000 -0400
+++ trunk/libsepol/include/sepol/policydb/expand.h	2006-07-19 13:04:03.000000000 -0400
@@ -29,6 +29,9 @@
 #include <sepol/handle.h>
 #include <sepol/policydb/conditional.h>
 
+extern int expand_module_avrules(sepol_handle_t *handle, policydb_t *base,
+				policydb_t *out, uint32_t *typemap, 
+				int verbose, int expand_neverallow);
 extern int expand_module(sepol_handle_t * handle,
 			 policydb_t * base, policydb_t * out,
 			 int verbose, int check);
diff -urpN -x 'Change*' -x entries -x '*.orig' -x '*.rej' -x '*.svn*' -x '*.swp' -x '*.o' -x '*.lo' ../../../trunk/libsepol/src/expand.c ./src/expand.c
--- trunk/libsepol/src/expand.c	2006-07-13 13:57:39.000000000 -0400
+++ trunk/libsepol/src/expand.c	2006-07-19 13:04:06.000000000 -0400
@@ -1895,6 +1895,72 @@ static int copy_neverallow(policydb_t * 
 	return -1;
 }
 
+static int expand_avrule_decls(expand_state_t *state)
+{
+	avrule_block_t *curblock;
+	int retval = -1;
+
+	for (curblock = state->base->global; curblock != NULL; curblock = curblock->next) {
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
+			if (!(state->expand_neverallow) && cur_avrule->specified & AVRULE_NEVERALLOW) {
+				/* copy this over directly so that assertions are checked later */
+				if (copy_neverallow(state->out, state->typemap, cur_avrule))
+					ERR(state->handle, "Error while copying neverallow.");
+			} else {
+				if (convert_and_expand_rule(state->handle, state->out,
+							    state->typemap, cur_avrule,
+							    &state->out->te_avtab,
+							    NULL, NULL,
+							    0, state->expand_neverallow) != 1) {
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
+int expand_module_avrules(sepol_handle_t *handle, policydb_t *base, policydb_t *out, uint32_t *typemap, int verbose, int expand_neverallow)
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
+	return expand_avrule_decls(&state);
+}
+
 /* Linking should always be done before calling expand, even if
  * there is only a base since all optionals are dealt with at link time
  * the base passed in should be indexed and avrule blocks should be 
@@ -2026,46 +2092,9 @@ int expand_module(sepol_handle_t * handl
 
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
-			if (!(state->expand_neverallow) && cur_avrule->specified & AVRULE_NEVERALLOW) {
-				/* copy this over directly so that assertions are checked later */
-				if (copy_neverallow
-				    (out, state.typemap, cur_avrule))
-					ERR(handle,
-					    "Error while copying neverallow.");
-			} else {
-				if (convert_and_expand_rule
-				    (state.handle, out, state.typemap,
-				     cur_avrule, &out->te_avtab, NULL, NULL,
-				     0, state->expand_neverallow) != 1) {
-					goto cleanup;
-				}
-			}
-			cur_avrule = cur_avrule->next;
-		}
-
-		/* copy conditional rules */
-		if (cond_node_copy(&state, decl->cond_list))
-			goto cleanup;
+	if (expand_avrule_decls(&state) < 0) {
+		ERR(handle, "Error during expand");
+		goto cleanup;
 	}
 
 	/* copy constraints */



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
