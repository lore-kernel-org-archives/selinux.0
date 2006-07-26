Subject: [PATCH] helpful heirarchy check errors
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 26 Jul 2006 07:35:03 -0400
Message-Id: <1153913703.19259.21.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes the hierarchy violations errors more helpful by adding
object class and permissions that were violated instead of just the
types. Additionally it makes assertion violations not fatal
so that all the violations can been seen before the checking fails.


diff -purN -x.svn trunk/libsepol/src/hierarchy.c branch/helpful-hierarchy-check-errors/libsepol/src/hierarchy.c
--- trunk/libsepol/src/hierarchy.c	2006-06-29 14:54:12.000000000 -0400
+++ branch/helpful-hierarchy-check-errors/libsepol/src/hierarchy.c	2006-07-03 10:58:00.000000000 -0400
@@ -28,6 +28,7 @@
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/expand.h>
+#include <sepol/policydb/util.h>
 
 #include "debug.h"
 
@@ -37,6 +38,7 @@ typedef struct hierarchy_args {
 	/* This tells check_avtab_hierarchy to check this list in addition to the unconditional avtab */
 	cond_av_list_t *opt_cond_list;
 	sepol_handle_t *handle;
+	int numerr;
 } hierarchy_args_t;
 
 /* This merely returns the string part before the last '.'
@@ -81,7 +83,6 @@ static int check_type_hierarchy_callback
 	hierarchy_args_t *a;
 	type_datum_t *t, *t2;
 	char *key;
-	int rc;
 
 	a = (hierarchy_args_t *) args;
 	t = (type_datum_t *) d;
@@ -100,21 +101,20 @@ static int check_type_hierarchy_callback
 		return 0;
 	}
 
-	rc = 0;
 	t2 = hashtab_search(a->p->p_types.table, parent);
 	if (!t2) {
 		/* If the parent does not exist this type is an orphan, not legal */
 		ERR(a->handle, "type %s does not exist, %s is an orphan",
 		    parent, a->p->p_type_val_to_name[t->value - 1]);
-		rc = 1;
+		a->numerr++;
 	} else if (t2->flavor == TYPE_ATTRIB) {
 		/* The parent is an attribute but the child isn't, not legal */
 		ERR(a->handle, "type %s is a child of an attribute",
 		    a->p->p_type_val_to_name[t->value - 1]);
-		rc = 1;
+		a->numerr++;
 	}
 	free(parent);
-	return rc;
+	return 0;
 }
 
 /* This function only verifies that the avtab node passed in does not violate any
@@ -146,12 +146,9 @@ static int check_avtab_hierarchy_callbac
 	if (parent) {
 		t = hashtab_search(a->p->p_types.table, parent);
 		if (!t) {
-			/* If the parent does not exist this type is an orphan, not legal */
-			ERR(a->handle, "type %s doesn't exist, %s is an orphan",
-			    parent,
-			    a->p->p_type_val_to_name[k->source_type - 1]);
+			/* This error was already covered by type_check_hierarchy */
 			free(parent);
-			return 1;
+			return 0;
 		}
 		free(parent);
 
@@ -188,11 +185,9 @@ static int check_avtab_hierarchy_callbac
 	if (parent) {
 		t2 = hashtab_search(a->p->p_types.table, parent);
 		if (!t2) {
-			ERR(a->handle, "type %s doesn't exist, %s is an orphan",
-			    parent,
-			    a->p->p_type_val_to_name[k->target_type - 1]);
+			/* This error was already covered by type_check_hierarchy */
 			free(parent);
-			return 1;
+			return 0;
 		}
 		free(parent);
 
@@ -254,10 +249,13 @@ static int check_avtab_hierarchy_callbac
 	}
 
 	/* At this point there is a violation of the hierarchal constraint, send error condition back */
-	ERR(a->handle, "hierarchy violation between types %s and %s",
-	    a->p->p_type_val_to_name[k->source_type - 1],
-	    a->p->p_type_val_to_name[k->target_type - 1]);
-	return 1;
+	ERR(a->handle,"hierarchy violation between types %s and %s : %s { %s }",
+			a->p->p_type_val_to_name[k->source_type - 1],
+			a->p->p_type_val_to_name[k->target_type - 1],
+			a->p->p_class_val_to_name[k->target_class - 1],
+			sepol_av_to_string(a->p, k->target_class, d->data & ~av));
+	a->numerr++;
+	return 0;
 }
 
 static int check_cond_avtab_hierarchy(cond_list_t * cond_list,
@@ -267,6 +265,7 @@ static int check_cond_avtab_hierarchy(co
 	cond_list_t *cur_node;
 	cond_av_list_t *cur_av, *expl = NULL;
 	avtab_t expa;
+	hierarchy_args_t *a = (hierarchy_args_t *)args;
 
 	for (cur_node = cond_list; cur_node != NULL; cur_node = cur_node->next) {
 		if (avtab_init(&expa))
@@ -281,12 +280,8 @@ static int check_cond_avtab_hierarchy(co
 			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
 							    &cur_av->node->
 							    datum, args);
-			if (rc == 0)
-				continue;
-			/* error condition */
-			cond_av_list_destroy(expl);
-			avtab_destroy(&expa);
-			return rc;
+			if (rc)
+				a->numerr++;
 		}
 		cond_av_list_destroy(expl);
 		avtab_destroy(&expa);
@@ -302,12 +297,8 @@ static int check_cond_avtab_hierarchy(co
 			rc = check_avtab_hierarchy_callback(&cur_av->node->key,
 							    &cur_av->node->
 							    datum, args);
-			if (rc == 0)
-				continue;
-			/* error condition */
-			cond_av_list_destroy(expl);
-			avtab_destroy(&expa);
-			return rc;
+			if (rc)
+				a->numerr++;
 		}
 		cond_av_list_destroy(expl);
 		avtab_destroy(&expa);
@@ -350,7 +341,8 @@ static int check_role_hierarchy_callback
 		ERR(a->handle, "role %s doesn't exist, %s is an orphan",
 		    parent, a->p->p_role_val_to_name[r->value - 1]);
 		free(parent);
-		return 1;
+		a->numerr++;
+		return 0;
 	}
 
 	if (ebitmap_or(&eb, &r->types.types, &rp->types.types)) {
@@ -360,12 +352,10 @@ static int check_role_hierarchy_callback
 	}
 
 	if (!ebitmap_cmp(&eb, &rp->types.types)) {
-		ebitmap_destroy(&eb);
 		/* This is a violation of the hiearchal constraint, return error condition */
 		ERR(a->handle, "Role hierarchy violation, %s exceeds %s",
 		    a->p->p_role_val_to_name[r->value - 1], parent);
-		free(parent);
-		return 1;
+		a->numerr++;
 	}
 
 	ebitmap_destroy(&eb);
@@ -390,6 +380,7 @@ int hierarchy_check_constraints(sepol_ha
 	args.expa = &expa;
 	args.opt_cond_list = NULL;
 	args.handle = handle;
+	args.numerr = 0;
 
 	if (hashtab_map(p->p_types.table, check_type_hierarchy_callback, &args))
 		goto bad;
@@ -403,6 +394,11 @@ int hierarchy_check_constraints(sepol_ha
 	if (hashtab_map(p->p_roles.table, check_role_hierarchy_callback, &args))
 		goto bad;
 
+	if (args.numerr) {
+		ERR(handle, "%d total errors found during hierarchy check", args.numerr);
+		goto bad;
+	}
+
 	avtab_destroy(&expa);
 	return 0;
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
