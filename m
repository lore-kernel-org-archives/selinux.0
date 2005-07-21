Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LIiYgA029119
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 14:44:34 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LIdurg004392
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 18:39:56 GMT
Subject: Re: [ libsepol 1/6] Fix memory leaks
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <42DFEB26.5020105@tresys.com>
References: <1121967363.9844.21.camel@celtics.boston.redhat.com>
	 <42DFEB26.5020105@tresys.com>
Content-Type: multipart/mixed; boundary="=-B3MTv0wJRNaA63fbYI8G"
Date: Thu, 21 Jul 2005 14:37:27 -0400
Message-Id: <1121971047.9844.74.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-B3MTv0wJRNaA63fbYI8G
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> adding the -p flag to diff would be very helpful
> 
> I'm not sure where these frees are being added to I can't tell if they 
> are correct

Attached is a version with the -p flag



--=-B3MTv0wJRNaA63fbYI8G
Content-Disposition: attachment; filename=libsepol-1.2-fix_memory_leaks.diff
Content-Type: text/x-patch; name=libsepol-1.2-fix_memory_leaks.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

diff -p -aru libsepol.work/src/constraint.c libsepol-1.2-fix_memory_leaks/src/constraint.c
--- libsepol.work/src/constraint.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/constraint.c	2005-07-21 10:58:05.000000000 -0400
@@ -30,6 +30,7 @@ void constraint_expr_destroy(constraint_
         if (expr != NULL) {
                 ebitmap_destroy(&expr->names);
                 type_set_destroy(expr->type_names);
+                free(expr->type_names);
                 free(expr);
         }
 }
diff -p -aru libsepol.work/src/policydb.c libsepol-1.2-fix_memory_leaks/src/policydb.c
--- libsepol.work/src/policydb.c	2005-07-21 14:35:49.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/policydb.c	2005-07-21 10:58:05.000000000 -0400
@@ -870,6 +870,8 @@ void policydb_destroy(policydb_t * p)
 		free(p->role_val_to_struct);
 	if (p->user_val_to_struct)
 		free(p->user_val_to_struct);
+	if (p->type_val_to_struct)
+		free(p->type_val_to_struct);
 
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->scope[i].table, scope_destroy, 0);
@@ -945,6 +947,7 @@ int scope_destroy(hashtab_key_t key, has
         if (cur != NULL) {
                 free (cur->decl_ids);
         }
+	free(cur);
         return 0;
 }
 
@@ -1266,8 +1269,10 @@ static int read_cons_helper(policydb_t *
 				depth++;
 				break;
 			case CEXPR_NAMES:
-				if (!allowxtarget && (e->attr & CEXPR_XTARGET))
+				if (!allowxtarget && (e->attr & CEXPR_XTARGET)) {
+					constraint_expr_destroy(e);
 					return -1;
+				}
 				if (depth == (CEXPR_MAXDEPTH-1)) {
 					constraint_expr_destroy(e);
 					return -1;
diff -p -aru libsepol.work/src/policydb_convert.c libsepol-1.2-fix_memory_leaks/src/policydb_convert.c
--- libsepol.work/src/policydb_convert.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/policydb_convert.c	2005-07-21 11:41:52.000000000 -0400
@@ -34,10 +34,6 @@ int policydb_to_image(
 	policy_file_t pf;
 	struct policydb tmp_policydb;
 
-	if (policydb_init(&tmp_policydb, POLICY_KERN) < 0) {
-		DEBUG(__FUNCTION__, "could not initialize temporary policy\n");
-		goto err;
-	}
 	/* Set the policy version for the new policy image we are
 	   about to generate so that it stays the same as the original,
 	   even if we support a newer one. */
@@ -50,7 +46,7 @@ int policydb_to_image(
 	if (policydb_write(policydb, &pf)) {
 		DEBUG(__FUNCTION__, "could not compute policy length\n"); 
 		errno = EINVAL;	
-		goto err_free;
+		goto err;
 	}
 
 	/* Allocate the new policy image. */
@@ -58,7 +54,7 @@ int policydb_to_image(
 	pf.data = malloc(pf.len);
 	if (!pf.data) {
 		DEBUG(__FUNCTION__, "out of memory\n");
-		goto err_free;
+		goto err;
         }
 
 	/* Need to save len and data prior to modification by policydb_write.*/
@@ -69,7 +65,7 @@ int policydb_to_image(
 	if (policydb_write(policydb, &pf)) {
 		DEBUG(__FUNCTION__, "could not write policy\n");
 		errno = EINVAL;
-		goto err_free;
+		goto err;
         }
 
 	/* Verify the new policy image. */
@@ -79,7 +75,7 @@ int policydb_to_image(
         if (policydb_read(&tmp_policydb, &pf, 0)) {
 		DEBUG(__FUNCTION__, "new policy image is invalid\n");
                 errno = EINVAL;
-		goto err_free;
+		goto err;
         }
 	policydb_destroy(&tmp_policydb);
 
@@ -91,9 +87,6 @@ int policydb_to_image(
 	sepol_set_policyvers(POLICY_KERN, POLICYDB_VERSION_MAX);
         return STATUS_SUCCESS;
 
-	err_free:
-	policydb_destroy(&tmp_policydb);
-
 	err:
 	DEBUG(__FUNCTION__, "could not create policy image\n");
 
diff -p -aru libsepol.work/src/util.c libsepol-1.2-fix_memory_leaks/src/util.c
--- libsepol.work/src/util.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/util.c	2005-07-21 10:39:55.000000000 -0400
@@ -192,6 +192,7 @@ int symtab_insert(policydb_t *pol, uint3
                 scope_datum->decl_ids = NULL;
                 scope_datum->decl_ids_len = 0;
                 if ((rc = hashtab_insert(pol->scope[sym].table, key, scope_datum)) != 0) {
+			free(scope_datum);
                         return rc;
                 }
         }

--=-B3MTv0wJRNaA63fbYI8G--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
