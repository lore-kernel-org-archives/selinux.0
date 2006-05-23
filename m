Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4NFil6L016232
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 11:44:47 -0400
Received: from e35.co.us.ibm.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4NFikZL012410
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 15:44:46 GMT
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4NFiWkK018864
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 11:44:32 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id k4NFiQEO179722
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 09:44:31 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id k4NFiQBh003160
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 09:44:26 -0600
Received: from sergelap.hallyn.com ([9.49.200.211])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id k4NFiPN5003060
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 09:44:25 -0600
Date: Tue, 23 May 2006 10:44:24 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: SELinux <selinux@tycho.nsa.gov>
Subject: libsepol and libselinux patches
Message-ID: <20060523154424.GA13237@sergelap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Starting my not-as-regular-as-i'd-like static analysis run of
selinux-usr.  Here are a few patches to libsepol and libselinux.
Hope to go through the rest later this week.

libselinux/src/matchmediacon.c:
	'found' initialized to -1, not 0
libselinux/src/setrans_client.c:
	'ret_val' is being returned, but codpath makes it pretty clear
	the intent is to return ret.
libsepol/src/expand.c:
	accessing new_level->level->cat when new_level->level could
	be NULL
libsepol/src/hierarchy.c
	freeing parent before potential dereference in
	ERR.
libsepol/src/nodes.c:
	jumping to 'omem' before addr_buf and mask_buf
	are declared, but they are used after 'omem:'.
	Testcase suggests these will not be initialized.
libsepol/src/policydb.c:
	'c' is never freed in read_cons_helper?
	newc and newc->u.name are not freed in genfs_read

thanks,
-serge

--- libselinux/src/matchmediacon.c.orig	2006-05-23 09:25:46.000000000 -0500
+++ libselinux/src/matchmediacon.c	2006-05-23 09:25:50.000000000 -0500
@@ -17,7 +17,7 @@ int matchmediacon(const char *media, 
 	const char *path = selinux_media_context_path();
 	FILE *infile;
 	char *ptr, *ptr2=NULL;
-	int found=-1;
+	int found=0;
 	char current_line[PATH_MAX];
 	if ((infile = fopen(path, "r")) == NULL)
 		return -1;
--- libselinux/src/setrans_client.c.orig	2006-05-23 09:41:35.000000000 -0500
+++ libselinux/src/setrans_client.c	2006-05-23 09:41:40.000000000 -0500
@@ -196,7 +196,7 @@ static int trans_to_raw_context(char *tr
 	ret = ret_val;
 out:
 	close(fd);
-	return ret_val;
+	return ret;
 }
 
 
--- libsepol/src/expand.c.orig	2006-05-23 07:28:24.000000000 -0500
+++ libsepol/src/expand.c	2006-05-23 07:28:54.000000000 -0500
@@ -650,7 +650,7 @@ static int sens_copy_callback(hashtab_ke
         
  out_of_mem:
         ERR(state->handle, "Out of memory!");
-        if (new_level != NULL) {
+        if (new_level != NULL && new_level->level != NULL) {
                 ebitmap_destroy(&new_level->level->cat);
                 free(new_level->level);
         }
--- libsepol/src/hierarchy.c.orig	2006-05-23 07:30:21.000000000 -0500
+++ libsepol/src/hierarchy.c	2006-05-23 07:30:40.000000000 -0500
@@ -336,10 +336,10 @@ static int check_role_hierarchy_callback
 		free(parent);
 		return 1;
 	}
-	free(parent);
 
 	if (ebitmap_or(&eb, &r->types.types, &rp->types.types)) {
 		/* Memory error */
+		free(parent);
 		return -1;
 	}
 	
@@ -349,10 +349,12 @@ static int check_role_hierarchy_callback
 		ERR(a->handle, "Role hierarchy violation, %s exceeds %s",
 				   a->p->p_role_val_to_name[r->value - 1],
 				   parent);
+		free(parent);
 		return 1;
 	}
 
 	ebitmap_destroy(&eb);
+	free(parent);
 
 	return 0;
 }
--- libsepol/src/nodes.c.orig	2006-05-23 07:43:19.000000000 -0500
+++ libsepol/src/nodes.c	2006-05-23 07:43:30.000000000 -0500
@@ -19,12 +19,12 @@ static int node_from_record(
 
 	ocontext_t* tmp_node = NULL;
 	context_struct_t* tmp_con = NULL;
+	char *addr_buf = NULL, *mask_buf = NULL;
 
 	tmp_node = (ocontext_t *) calloc(1, sizeof(ocontext_t));
 	if (!tmp_node) 
 		goto omem;
 
-	char *addr_buf = NULL, *mask_buf = NULL;
 	size_t addr_bsize, mask_bsize;
 
 	/* Address and netmask */	
--- libsepol/src/policydb.c.orig	2006-05-23 07:48:58.000000000 -0500
+++ libsepol/src/policydb.c	2006-05-23 08:36:50.000000000 -0500
@@ -1435,22 +1435,28 @@ static int read_cons_helper(policydb_t *
 		if (!c)
 			return -1;
 		buf = next_entry(fp, (sizeof(uint32_t) * 2));
-		if (!buf)
+		if (!buf) {
+			free(c);
 			return -1;
+		}
 		c->permissions = le32_to_cpu(buf[0]);
 		nexpr = le32_to_cpu(buf[1]);
 		le = NULL;
 		depth = -1;
 		for (j = 0; j < nexpr; j++) {
 			e = malloc(sizeof(constraint_expr_t));
-			if (!e)
+			if (!e) {
+				free(c);
 				return -1;
+			}
                         if (constraint_expr_init(e) == -1) {
+				free(c);
                                 free(e);
                                 return -1;
                         }
 			buf = next_entry(fp, (sizeof(uint32_t) * 3));
 			if (!buf) {
+				free(c);
                                 constraint_expr_destroy(e);
 				return -1;
 			}
@@ -1461,6 +1467,7 @@ static int read_cons_helper(policydb_t *
 			switch (e->expr_type) {
 			case CEXPR_NOT:
 				if (depth < 0) {
+					free(c);
 					constraint_expr_destroy(e);
 					return -1;
 				}
@@ -1468,6 +1475,7 @@ static int read_cons_helper(policydb_t *
 			case CEXPR_AND:
 			case CEXPR_OR:
 				if (depth < 1) {
+					free(c);
 					constraint_expr_destroy(e);
 					return -1;
 				}
@@ -1475,6 +1483,7 @@ static int read_cons_helper(policydb_t *
 				break;
 			case CEXPR_ATTR:
 				if (depth == (CEXPR_MAXDEPTH-1)) {
+					free(c);
 					constraint_expr_destroy(e);
 					return -1;
 				}
@@ -1482,25 +1491,30 @@ static int read_cons_helper(policydb_t *
 				break;
 			case CEXPR_NAMES:
 				if (!allowxtarget && (e->attr & CEXPR_XTARGET)) {
+					free(c);
 					constraint_expr_destroy(e);
 					return -1;
 				}
 				if (depth == (CEXPR_MAXDEPTH-1)) {
+					free(c);
 					constraint_expr_destroy(e);
 					return -1;
 				}
 				depth++;
 				if (ebitmap_read(&e->names, fp)) {
+					free(c);
 					constraint_expr_destroy(e);
 					return -1;
 				}
                                 if (p->policy_type != POLICY_KERN &&
                                     type_set_read(e->type_names, fp)) {
+					free(c);
 					constraint_expr_destroy(e);
                                         return -1;
                                 }
 				break;
 			default:
+				free(c);
                                 constraint_expr_destroy(e);
 				return -1;
 				break;
@@ -1949,23 +1963,23 @@ static int genfs_read (policydb_t *p, st
                         }
                         buf = next_entry(fp, sizeof(uint32_t));
                         if (!buf)
-                                goto bad;
+                                goto bad_freenewc;
                         len = le32_to_cpu(buf[0]);
                         buf = next_entry(fp, len);
                         if (!buf)
-                                goto bad;
+                                goto bad_freenewc;
                         newc->u.name = malloc(len + 1);
                         if (!newc->u.name) {
-                                goto bad;
+                                goto bad_freenewc;
                         }
                         memcpy(newc->u.name, buf, len);
                         newc->u.name[len] = 0;
                         buf = next_entry(fp, sizeof(uint32_t));
                         if (!buf)
-                                goto bad;
+                                goto bad_freename;
                         newc->v.sclass = le32_to_cpu(buf[0]);
                         if (context_read_and_validate(&newc->context[0], p, fp))
-                                goto bad;
+                                goto bad_freename;
                         for (l = NULL, c = newgenfs->head; c;
                              l = c, c = c->next) {
                                 if (!strcmp(newc->u.name, c->u.name) &&
@@ -1974,7 +1988,7 @@ static int genfs_read (policydb_t *p, st
 					ERR(fp->handle, "dup genfs entry "
 						"(%s,%s)", newgenfs->fstype, 
 							c->u.name);
-                                        goto bad;
+                                        goto bad_context;
                                 }
                                 len = strlen(newc->u.name);
                                 len2 = strlen(c->u.name);
@@ -1991,6 +2005,12 @@ static int genfs_read (policydb_t *p, st
 
         return 0;
 
+bad_context:
+	context_destroy(&newc->context[0]);
+bad_freename:
+	free(newc->u.name);
+bad_freenewc:
+	free(newc);
 bad:
 	return -1;
 }
@@ -2461,14 +2481,17 @@ static int avrule_block_read(policydb_t 
                 num_decls = le32_to_cpu(buf[0]);
                 while (num_decls > 0) {
                         if ((curdecl = avrule_decl_create(0)) == NULL) {
+				free(curblock);
                                 return -1;
                         }
                         if (avrule_decl_read(p, curdecl, num_scope_syms, fp) == -1) {
+				free(curblock);
                                 return -1;
                         }
                         if (curdecl->enabled) {
                                 if (curblock->enabled != NULL) {
                                         /* probably a corrupt file */
+					free(curblock);
                                         return -1;
                                 }
                                 curblock->enabled = curdecl;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
