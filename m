Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LHhAgA028011
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:43:10 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LHbjBa024900
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 17:37:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11/8.12.11) with ESMTP id j6LHcX2V017041
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:38:33 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.11.6/8.11.6) with ESMTP id j6LHcSV29023
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:38:28 -0400
Received: from celtics.boston.redhat.com (celtics.boston.redhat.com [172.16.80.115])
	by mail.boston.redhat.com (8.12.8/8.12.8) with ESMTP id j6LHcRll027304
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 13:38:27 -0400
Subject: [ libsepol 1/6] Fix memory leaks
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-u7q/D7KvPKqvas6xdwO9"
Date: Thu, 21 Jul 2005 13:36:03 -0400
Message-Id: <1121967363.9844.21.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-u7q/D7KvPKqvas6xdwO9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The following patch fixes memory leaks.
The ones in policydb_convert are due to double
initialization (policydb_read does its own init).

libsepol-1.2-fix_memory_leaks.diff

This patch depends on
libsepol-1.1-context.diff





--=-u7q/D7KvPKqvas6xdwO9
Content-Disposition: attachment; filename=libsepol-1.2-fix_memory_leaks.diff
Content-Type: text/x-patch; name=libsepol-1.2-fix_memory_leaks.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -aru libsepol.work/src/constraint.c libsepol-1.2-fix_memory_leaks/src/constraint.c
--- libsepol.work/src/constraint.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/constraint.c	2005-07-21 10:58:05.000000000 -0400
@@ -30,6 +30,7 @@
         if (expr != NULL) {
                 ebitmap_destroy(&expr->names);
                 type_set_destroy(expr->type_names);
+                free(expr->type_names);
                 free(expr);
         }
 }
diff -aru libsepol.work/src/policydb.c libsepol-1.2-fix_memory_leaks/src/policydb.c
--- libsepol.work/src/policydb.c	2005-07-21 13:06:49.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/policydb.c	2005-07-21 10:58:05.000000000 -0400
@@ -870,6 +870,8 @@
 		free(p->role_val_to_struct);
 	if (p->user_val_to_struct)
 		free(p->user_val_to_struct);
+	if (p->type_val_to_struct)
+		free(p->type_val_to_struct);
 
 	for (i = 0; i < SYM_NUM; i++) {
 		hashtab_map(p->scope[i].table, scope_destroy, 0);
@@ -945,6 +947,7 @@
         if (cur != NULL) {
                 free (cur->decl_ids);
         }
+	free(cur);
         return 0;
 }
 
@@ -1266,8 +1269,10 @@
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
diff -aru libsepol.work/src/policydb_convert.c libsepol-1.2-fix_memory_leaks/src/policydb_convert.c
--- libsepol.work/src/policydb_convert.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/policydb_convert.c	2005-07-21 11:41:52.000000000 -0400
@@ -34,10 +34,6 @@
 	policy_file_t pf;
 	struct policydb tmp_policydb;
 
-	if (policydb_init(&tmp_policydb, POLICY_KERN) < 0) {
-		DEBUG(__FUNCTION__, "could not initialize temporary policy\n");
-		goto err;
-	}
 	/* Set the policy version for the new policy image we are
 	   about to generate so that it stays the same as the original,
 	   even if we support a newer one. */
@@ -50,7 +46,7 @@
 	if (policydb_write(policydb, &pf)) {
 		DEBUG(__FUNCTION__, "could not compute policy length\n"); 
 		errno = EINVAL;	
-		goto err_free;
+		goto err;
 	}
 
 	/* Allocate the new policy image. */
@@ -58,7 +54,7 @@
 	pf.data = malloc(pf.len);
 	if (!pf.data) {
 		DEBUG(__FUNCTION__, "out of memory\n");
-		goto err_free;
+		goto err;
         }
 
 	/* Need to save len and data prior to modification by policydb_write.*/
@@ -69,7 +65,7 @@
 	if (policydb_write(policydb, &pf)) {
 		DEBUG(__FUNCTION__, "could not write policy\n");
 		errno = EINVAL;
-		goto err_free;
+		goto err;
         }
 
 	/* Verify the new policy image. */
@@ -79,7 +75,7 @@
         if (policydb_read(&tmp_policydb, &pf, 0)) {
 		DEBUG(__FUNCTION__, "new policy image is invalid\n");
                 errno = EINVAL;
-		goto err_free;
+		goto err;
         }
 	policydb_destroy(&tmp_policydb);
 
@@ -91,9 +87,6 @@
 	sepol_set_policyvers(POLICY_KERN, POLICYDB_VERSION_MAX);
         return STATUS_SUCCESS;
 
-	err_free:
-	policydb_destroy(&tmp_policydb);
-
 	err:
 	DEBUG(__FUNCTION__, "could not create policy image\n");
 
diff -aru libsepol.work/src/util.c libsepol-1.2-fix_memory_leaks/src/util.c
--- libsepol.work/src/util.c	2005-07-18 15:05:30.000000000 -0400
+++ libsepol-1.2-fix_memory_leaks/src/util.c	2005-07-21 10:39:55.000000000 -0400
@@ -192,6 +192,7 @@
                 scope_datum->decl_ids = NULL;
                 scope_datum->decl_ids_len = 0;
                 if ((rc = hashtab_insert(pol->scope[sym].table, key, scope_datum)) != 0) {
+			free(scope_datum);
                         return rc;
                 }
         }

--=-u7q/D7KvPKqvas6xdwO9--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
