Message-ID: <4213C04F.1000307@trustedcs.com>
Date: Wed, 16 Feb 2005 15:51:11 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: "'SELinux List'" <SELinux@tycho.nsa.gov>
CC: Chad Hanson <chanson@TrustedCS.com>
Subject: [PATCH] policy defined range transitions
Content-Type: multipart/mixed;
 boundary="------------010803020902030900010808"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010803020902030900010808
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached are patches that implement range_transition statements for the policy. 
  The range_transitions will be used for admin users invoking certain programs. 
  Examples include starting/stopping daemons, working with log files, etc.  This 
allows the admin to perform tasks that need to be done at a certain MLS level 
without the need to manually switch level before doing so.  It is the MLS 
counterpart to type_transition and role_transition (more akin to role_transition 
because it only deals with process transitions).  The syntax is:

range_transition "process domain" "executable type" "new range";

The mlsconstraints (for process transition) requires either that the current 
domain has the privilege to change its level (mlsprocsetsl), or that the current 
domain has the privilege to "use" a range_transition (privrangetrans) AND that 
the new domain has the mlsrangetrans attribute.  The patch does not currently 
add the privrangetrans to any domains (a likely candidate is sysadm_t).  The MLS 
range that is transitioned to is also subject to the usual restriction of 
falling within the user's allowed MLS range.

PLEASE NOTE:  This patch changes the binary policy format.  However, it does not 
change the binary policy version.  The binary policy version was bumped to 19 
for the previous mls changes and has not yet been included in an official 
release - these changes would become a part of the version 18 to 19 update. 
People keeping up with the latest CVS snapshot will need to recompile the 
kernel, libsepol, checkpolicy, and the policy.

Questions/comments?

Thanks,

-- 

Darrel

--------------010803020902030900010808
Content-Type: text/x-patch;
 name="range_transition_kern.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="range_transition_kern.patch"

diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/mls.c linux-2.6-20050216/security/selinux/ss/mls.c
--- linux-2.6-nsa-20050215/security/selinux/ss/mls.c	2005-01-27 16:48:31.000000000 -0600
+++ linux-2.6-20050216/security/selinux/ss/mls.c	2005-02-16 09:36:40.584230477 -0600
@@ -374,32 +374,23 @@ static inline int mls_scopy_context(stru
 }
 
 /*
- * Copy the MLS level into the context.
+ * Copies the MLS range `range' into `context'.
  */
-int mls_level_cpy_and_set(struct context *scontext, struct mls_level *nlevel,
-                          struct context *ncontext)
+static inline int mls_range_set(struct context *context,
+                                struct mls_range *range)
 {
-	int rc;
+	int l, rc = 0;
 
-	/* copy in the current clearance */
-	ncontext->range.level[1].sens = scontext->range.level[1].sens;
-	rc = ebitmap_cpy(&ncontext->range.level[1].cat,
-	                 &scontext->range.level[1].cat);
-	if (rc)
-		return rc;
-
-	/* copy in the new level */
-	ncontext->range.level[0].sens = nlevel->sens;
-	rc = ebitmap_cpy(&ncontext->range.level[0].cat, &nlevel->cat);
-	if (rc)
-		return rc;
-
-	/* check validity of new context */
-	rc = mls_context_isvalid(&policydb, ncontext);
-	if (!rc)
-		return -EINVAL;
+	/* Copy the MLS range into the  context */
+	for (l = 0; l < 2; l++) {
+		context->range.level[l].sens = range->level[l].sens;
+		rc = ebitmap_cpy(&context->range.level[l].cat,
+				 &range->level[l].cat);
+		if (rc)
+			break;
+	}
 
-	return 0;
+	return rc;
 }
 
 int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
@@ -497,6 +488,20 @@ int mls_compute_sid(struct context *scon
 
 	switch (specified) {
 	case AVTAB_TRANSITION:
+		if (tclass == SECCLASS_PROCESS) {
+			struct range_trans *rangetr;
+			/* Look for a range transition rule. */
+			for (rangetr = policydb.range_tr; rangetr;
+			     rangetr = rangetr->next) {
+				if (rangetr->dom == scontext->type &&
+				    rangetr->type == tcontext->type) {
+					/* Set the range from the rule */
+					return mls_range_set(newcontext,
+					                     &rangetr->range);
+				}
+			}
+		}
+		/* Fallthrough */
 	case AVTAB_CHANGE:
 		if (tclass == SECCLASS_PROCESS)
 			/* Use the process MLS attributes. */
diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/mls.h linux-2.6-20050216/security/selinux/ss/mls.h
--- linux-2.6-nsa-20050215/security/selinux/ss/mls.h	2005-01-27 16:48:31.000000000 -0600
+++ linux-2.6-20050216/security/selinux/ss/mls.h	2005-02-16 09:36:40.589229175 -0600
@@ -38,8 +38,5 @@ int mls_compute_sid(struct context *scon
 int mls_setup_user_range(struct context *fromcon, struct user_datum *user,
                          struct context *usercon);
 
-int mls_level_cpy_and_set(struct context *scontext, struct mls_level *nlevel,
-                          struct context *ncontext);
-
 #endif	/* _SS_MLS_H */
 
diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/policydb.c linux-2.6-20050216/security/selinux/ss/policydb.c
--- linux-2.6-nsa-20050215/security/selinux/ss/policydb.c	2005-02-15 10:30:46.000000000 -0600
+++ linux-2.6-20050216/security/selinux/ss/policydb.c	2005-02-16 09:36:40.598226832 -0600
@@ -1395,6 +1395,7 @@ int policydb_read(struct policydb *p, vo
 	u32 buf[8], len, len2, config, nprim, nel, nel2;
 	char *policydb_str;
 	struct policydb_compat_info *info;
+	struct range_trans *rt, *lrt;
 
 	config = 0;
 
@@ -1800,6 +1801,35 @@ int policydb_read(struct policydb *p, vo
 		}
 	}
 
+	if (p->policyvers >= POLICYDB_VERSION_MLS) {
+		rc = next_entry(buf, fp, sizeof(u32));
+		if (rc < 0)
+			goto bad;
+		nel = le32_to_cpu(buf[0]);
+		lrt = NULL;
+		for (i = 0; i < nel; i++) {
+			rt = kmalloc(sizeof(*rt), GFP_KERNEL);
+			if (!rt) {
+				rc = -ENOMEM;
+				goto bad;
+			}
+			memset(rt, 0, sizeof(*rt));
+			if (lrt)
+				lrt->next = rt;
+			else
+				p->range_tr = rt;
+			rc = next_entry(buf, fp, (sizeof(u32) * 2));
+			if (rc < 0)
+				goto bad;
+			rt->dom = le32_to_cpu(buf[0]);
+			rt->type = le32_to_cpu(buf[1]);
+			rc = mls_read_range_helper(&rt->range, fp);
+			if (rc)
+				goto bad;
+			lrt = rt;
+		}
+	}
+
 	rc = 0;
 out:
 	return rc;
diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/policydb.h linux-2.6-20050216/security/selinux/ss/policydb.h
--- linux-2.6-nsa-20050215/security/selinux/ss/policydb.h	2005-01-27 16:48:31.000000000 -0600
+++ linux-2.6-20050216/security/selinux/ss/policydb.h	2005-02-16 09:36:40.604225271 -0600
@@ -105,6 +105,13 @@ struct cat_datum {
 	unsigned char isalias;  /* is this category an alias for another? */
 };
 
+struct range_trans {
+	u32 dom;			/* current process domain */
+	u32 type;			/* program executable type */
+	struct mls_range range;		/* new range */
+	struct range_trans *next;
+};
+
 /* Boolean data type */
 struct cond_bool_datum {
 	__u32 value;		/* internal type value */
@@ -227,6 +234,9 @@ struct policydb {
 	   fixed labeling behavior. */
   	struct genfs *genfs;
 
+	/* range transitions */
+	struct range_trans *range_tr;
+
 	unsigned int policyvers;
 };
 
diff -ruNp linux-2.6-nsa-20050215/security/selinux/ss/services.c linux-2.6-20050216/security/selinux/ss/services.c
--- linux-2.6-nsa-20050215/security/selinux/ss/services.c	2005-01-27 16:48:31.000000000 -0600
+++ linux-2.6-20050216/security/selinux/ss/services.c	2005-02-16 09:36:40.612223188 -0600
@@ -844,13 +888,6 @@ static int security_compute_sid(u32 ssid
 				}
 			}
 		}
-
-		if (!type_change && !roletr) {
-			/* No change in process role or type. */
-			*out_sid = ssid;
-			goto out_unlock;
-
-		}
 		break;
 	default:
 		break;

--------------010803020902030900010808
Content-Type: text/x-patch;
 name="range_transition_usr.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="range_transition_usr.patch"

diff -ruNp selinux-usr-nsa-20050215/checkpolicy/policy_parse.y selinux-usr-20050216/checkpolicy/policy_parse.y
--- selinux-usr-nsa-20050215/checkpolicy/policy_parse.y	2005-02-16 11:35:44.000000000 -0600
+++ selinux-usr-20050216/checkpolicy/policy_parse.y	2005-02-16 09:50:03.000000000 -0600
@@ -80,6 +80,7 @@ static int define_role_types(void);
 static role_datum_t *merge_roles_dom(role_datum_t *r1,role_datum_t *r2);
 static role_datum_t *define_role_dom(role_datum_t *r);
 static int define_role_trans(void);
+static int define_range_trans(void);
 static int define_role_allow(void);
 static int define_constraint(constraint_expr_t *expr);
 static int define_validatetrans(constraint_expr_t *expr);
@@ -140,6 +141,7 @@ static int define_ipv6_node_context(void
 %token TYPE_MEMBER
 %token TYPE_CHANGE
 %token ROLE_TRANSITION
+%token RANGE_TRANSITION
 %token SENSITIVITY
 %token DOMINANCE
 %token DOM DOMBY INCOMP
@@ -287,6 +289,7 @@ te_decl			: attribute_def
                         | typeattribute_def
                         | bool_def
                         | transition_def
+                        | range_trans_def
                         | te_avtab_def
                         | cond_stmt_def
 			;
@@ -407,6 +410,9 @@ transition_def		: TYPE_TRANSITION names 
                         | TYPE_CHANGE names names ':' names identifier ';'
                         {if (define_compute_type(AVTAB_CHANGE)) return -1;}
     			;
+range_trans_def		: RANGE_TRANSITION names names mls_range_def ';'
+			{ if (define_range_trans()) return -1; }
+			;
 te_avtab_def		: allow_def
 			| auditallow_def
 			| auditdeny_def
@@ -4856,6 +4862,188 @@ static int define_genfs_context(int has_
 	return define_genfs_context_helper(queue_remove(id_queue), has_type);
 }
 
+static int define_range_trans(void)
+{
+	char *id;
+	char *levid;
+	level_datum_t *levdatum = 0;
+	cat_datum_t *catdatum = NULL;
+	cat_datum_t *catdatum_r = NULL;
+	mls_range_t range;
+	ebitmap_t doms, types, negset;
+	range_trans_t *rt = 0;
+	unsigned int i, j;
+	int l, add = 1;
+
+	if (!mlspol) {
+		yyerror("range_transition rule in non-MLS configuration");
+		return -1;
+	}
+
+	if (pass == 1) {
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		while ((id = queue_remove(id_queue))) 
+			free(id);
+		id = queue_remove(id_queue); free(id); 
+		for (l = 0; l < 2; l++) {
+			while ((id = queue_remove(id_queue))) {
+				free(id);
+			}
+			id = queue_remove(id_queue);
+			if (!id)
+				break;
+			free(id); 
+		}
+		return 0;
+	}
+
+	ebitmap_init(&doms);
+	ebitmap_init(&types);
+
+	ebitmap_init(&negset);
+	while ((id = queue_remove(id_queue))) {
+		if (set_types(&doms, &negset, id, &add))
+			return -1;
+	}
+	ebitmap_destroy(&negset);
+
+	ebitmap_init(&negset);
+	while ((id = queue_remove(id_queue))) {
+		if (set_types(&types, &negset, id, &add))
+			return -1;
+	}
+	ebitmap_destroy(&negset);
+
+	id = (char *)queue_remove(id_queue);
+	if (!id) {
+		yyerror("no range in range_transition definition?");
+		return -1;
+	}
+	for (l = 0; l < 2; l++) {
+		levdatum = hashtab_search(policydbp->p_levels.table, id);
+		if (!levdatum) {
+			sprintf(errormsg, "unknown level %s used in range_transition definition", id);
+			yyerror(errormsg);
+			return -1;
+		}
+		range.level[l].sens = levdatum->level->sens;
+
+		levid = id;
+		ebitmap_init(&range.level[l].cat);
+		while ((id = queue_remove(id_queue))) {
+			/* Check for ranged entry */
+			if (strcmp(id, "MLS_CAT_RANGE") == 0) {
+				free(id);
+				if (catdatum_r->value >= catdatum->value) {
+					yyerror("category range is negative");
+					free(levid);
+					return -1;
+				}
+
+				for (i = catdatum_r->value; i < catdatum->value - 1; i++) {
+					if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
+						sprintf(errormsg, "category value=%d cannot be associated with level %s", i+1, levid);
+						yyerror(errormsg);
+						continue;
+					}
+					if (ebitmap_set_bit(&range.level[l].cat, i, TRUE)) {
+						yyerror("out of memory");
+						free(levid);
+						return -1;
+					}
+				}
+				continue;
+			}
+
+			/* Save previous entry */
+			catdatum_r = catdatum;
+
+			catdatum = hashtab_search(policydbp->p_cats.table, id);
+			if (!catdatum) {
+				sprintf(errormsg, "unknown category %s used in range_transition definition", id);
+				yyerror(errormsg);
+				return -1;
+			}
+			if (!ebitmap_get_bit(&levdatum->level->cat, catdatum->value - 1)) {
+				sprintf(errormsg, "category %s not allowed with specified sensitivity", id);
+				yyerror(errormsg);
+				return -1;
+			}		
+			if (ebitmap_set_bit(&range.level[l].cat, catdatum->value - 1, TRUE)) {
+				yyerror("out of memory");
+				return -1;
+			}
+			free(id);
+		}
+		free(levid);
+
+		id = (char *)queue_remove(id_queue);
+		if (!id)
+			break;
+	}
+	if (l == 0) {
+		range.level[1].sens = range.level[0].sens;
+		if (ebitmap_cpy(&range.level[1].cat, &range.level[0].cat)) {
+			yyerror("out of memory");
+			return -1;
+		}
+	}
+
+	if (!mls_level_dom(&range.level[1], &range.level[0])) {
+		yyerror("range_transition high level does not dominate low level");
+		return -1;
+	}
+
+	for (i = ebitmap_startbit(&doms); i < ebitmap_length(&doms); i++) {
+		if (!ebitmap_get_bit(&doms, i))
+			continue;
+		for (j = ebitmap_startbit(&types); j < ebitmap_length(&types); j++) {
+			if (!ebitmap_get_bit(&types, j))
+				continue;
+
+			for (rt = policydbp->range_tr; rt; rt = rt->next) {
+				if (rt->dom == (i + 1) && rt->type == (j + 1)) {
+					sprintf(errormsg, "duplicate range_transition defined for (%s,%s)",
+					        type_val_to_name(i + 1), type_val_to_name(j + 1));
+					yyerror(errormsg);
+					return -1;
+				}
+			}
+
+			rt = malloc(sizeof(range_trans_t));
+			if (!rt) {
+				yyerror("out of memory");
+				return -1;
+			}
+			memset(rt, 0, sizeof(range_trans_t));
+			rt->dom = i + 1;
+			rt->type = j + 1;
+			rt->range.level[0].sens = range.level[0].sens;
+			if (ebitmap_cpy(&rt->range.level[0].cat,
+			               &range.level[0].cat)) {
+				yyerror("out of memory");
+				free(rt);
+				return -1;
+			}
+			rt->range.level[1].sens = range.level[1].sens;
+			if (ebitmap_cpy(&rt->range.level[1].cat,
+			               &range.level[1].cat)) {
+				yyerror("out of memory");
+				free(rt);
+				return -1;
+			}
+			rt->next = policydbp->range_tr;
+			policydbp->range_tr = rt;
+		}
+	}
+
+	ebitmap_destroy(&doms);
+	ebitmap_destroy(&types);
+	ebitmap_destroy(&range.level[0].cat);
+	ebitmap_destroy(&range.level[1].cat);
+	return 0;
+}
 
 /* FLASK */
 
diff -ruNp selinux-usr-nsa-20050215/checkpolicy/policy_scan.l selinux-usr-20050216/checkpolicy/policy_scan.l
--- selinux-usr-nsa-20050215/checkpolicy/policy_scan.l	2005-01-27 17:12:51.000000000 -0600
+++ selinux-usr-20050216/checkpolicy/policy_scan.l	2005-02-16 09:40:59.000000000 -0600
@@ -88,6 +88,8 @@ TYPE_CHANGE |
 type_change			{ return(TYPE_CHANGE); }
 ROLE_TRANSITION |
 role_transition			{ return(ROLE_TRANSITION); }
+RANGE_TRANSITION |
+range_transition		{ return(RANGE_TRANSITION); }
 SENSITIVITY |
 sensitivity			{ return(SENSITIVITY); }
 DOMINANCE |
diff -ruNp selinux-usr-nsa-20050215/libsepol/include/sepol/mls.h selinux-usr-20050216/libsepol/include/sepol/mls.h
--- selinux-usr-nsa-20050215/libsepol/include/sepol/mls.h	2005-01-27 17:12:52.000000000 -0600
+++ selinux-usr-20050216/libsepol/include/sepol/mls.h	2005-02-11 10:09:46.000000000 -0600
@@ -48,8 +48,5 @@ int mls_compute_sid(policydb_t *policydb
 int mls_setup_user_range(context_struct_t *fromcon, user_datum_t *user,
                          context_struct_t *usercon);
 
-int mls_level_cpy_and_set(policydb_t *policydb, context_struct_t *scontext,
-                          mls_level_t *nlevel, context_struct_t *ncontext);
-
 #endif	/* _MLS_H_ */
 
diff -ruNp selinux-usr-nsa-20050215/libsepol/include/sepol/policydb.h selinux-usr-20050216/libsepol/include/sepol/policydb.h
--- selinux-usr-nsa-20050215/libsepol/include/sepol/policydb.h	2005-01-27 17:12:52.000000000 -0600
+++ selinux-usr-20050216/libsepol/include/sepol/policydb.h	2005-02-16 09:51:16.000000000 -0600
@@ -116,6 +116,13 @@ typedef struct cat_datum {
 	unsigned char isalias;  /* is this category an alias for another? */
 } cat_datum_t;
 
+typedef struct range_trans {
+	uint32_t dom;			/* current process domain */
+	uint32_t type;			/* program executable type */
+	mls_range_t range;		/* new range */
+	struct range_trans *next;
+} range_trans_t;
+
 /* Boolean data type */
 typedef struct cond_bool_datum {
 	uint32_t value;		/* internal type value */
@@ -240,6 +247,9 @@ typedef struct policydb {
 	   fixed labeling behavior. */
   	genfs_t *genfs;
 
+	/* range transitions */
+	range_trans_t *range_tr;
+
 	unsigned policyvers;
 } policydb_t;
 
diff -ruNp selinux-usr-nsa-20050215/libsepol/src/mls.c selinux-usr-20050216/libsepol/src/mls.c
--- selinux-usr-nsa-20050215/libsepol/src/mls.c	2005-01-27 17:12:52.000000000 -0600
+++ selinux-usr-20050216/libsepol/src/mls.c	2005-02-14 09:50:53.000000000 -0600
@@ -382,35 +382,24 @@ static inline int mls_scopy_context(cont
 }
 
 /*
- * Copy the MLS level into the context.
+ * Copies the MLS range `range' into `context'.
  */
-int mls_level_cpy_and_set(policydb_t *policydb, context_struct_t *scontext,
-                          mls_level_t *nlevel, context_struct_t *ncontext)
+static inline int mls_range_set(context_struct_t *context, mls_range_t *range)
 {
-	int rc;
+	int l, rc = 0;
 
-	/* copy in the current clearance */
-	ncontext->range.level[1].sens = scontext->range.level[1].sens;
-	rc = ebitmap_cpy(&ncontext->range.level[1].cat,
-	                 &scontext->range.level[1].cat);
-	if (rc)
-		return rc;
-
-	/* copy in the new level */
-	ncontext->range.level[0].sens = nlevel->sens;
-	rc = ebitmap_cpy(&ncontext->range.level[0].cat, &nlevel->cat);
-	if (rc)
-		return rc;
-
-	/* check validity of new context */
-	rc = mls_context_isvalid(policydb, ncontext);
-	if (!rc)
-		return -EINVAL;
+	/* Copy the MLS range into the  context */
+	for (l = 0; l < 2; l++) {
+		context->range.level[l].sens = range->level[l].sens;
+		rc = ebitmap_cpy(&context->range.level[l].cat,
+				 &range->level[l].cat);
+		if (rc)
+			break;
+	}
 
-	return 0;
+	return rc;
 }
 
-
 int mls_setup_user_range(context_struct_t *fromcon, user_datum_t *user,
                          context_struct_t *usercon)
 {
@@ -508,6 +497,21 @@ int mls_compute_sid(policydb_t *policydb
 
 	switch (specified) {
 	case AVTAB_TRANSITION:
+		if (tclass == SECCLASS_PROCESS) {
+			range_trans_t *rangetr;
+
+			/* Look for a range transition rule. */
+			for (rangetr = policydb->range_tr; rangetr;
+			     rangetr = rangetr->next) {
+				if (rangetr->dom == scontext->type &&
+				    rangetr->type == tcontext->type) {
+					/* Set the range from the rule */
+					return mls_range_set(newcontext,
+					                     &rangetr->range);
+				}
+			}
+		}
+		/* Fallthrough */
 	case AVTAB_CHANGE:
 		if (tclass == SECCLASS_PROCESS)
 			/* Use the process MLS attributes. */
diff -ruNp selinux-usr-nsa-20050215/libsepol/src/policydb.c selinux-usr-20050216/libsepol/src/policydb.c
--- selinux-usr-nsa-20050215/libsepol/src/policydb.c	2005-02-15 10:28:57.000000000 -0600
+++ selinux-usr-20050216/libsepol/src/policydb.c	2005-02-16 09:46:43.000000000 -0600
@@ -1355,6 +1355,7 @@ int policydb_read(policydb_t * p, struct
 {
 	role_allow_t *ra, *lra;
 	role_trans_t *tr, *ltr;
+	range_trans_t *rt, *lrt;
 
 	ocontext_t *l, *c, *newc;
 	genfs_t *genfs_p, *genfs, *newgenfs;
@@ -1700,6 +1701,32 @@ int policydb_read(policydb_t * p, struct
 		}
 	}
 
+	if (r_policyvers >= POLICYDB_VERSION_MLS) {
+		buf = next_entry(fp, sizeof(uint32_t));
+		if (!buf)
+			goto bad;
+		nel = le32_to_cpu(buf[0]);
+		lrt = NULL;
+		for (i = 0; i < nel; i++) {
+			rt = malloc(sizeof(range_trans_t));
+			if (!rt)
+				goto bad;
+			memset(rt, 0, sizeof(range_trans_t));
+			if (lrt)
+				lrt->next = rt;
+			else
+				p->range_tr = rt;
+			buf = next_entry(fp, (sizeof(uint32_t) * 2));
+			if (!buf)
+				goto bad;
+			rt->dom = le32_to_cpu(buf[0]);
+			rt->type = le32_to_cpu(buf[1]);
+			if (mls_read_range_helper(&rt->range, fp))
+				goto bad;
+			lrt = rt;
+		}
+	}
+
 	return 0;
 bad:
 	policydb_destroy(p);
diff -ruNp selinux-usr-nsa-20050215/libsepol/src/services.c selinux-usr-20050216/libsepol/src/services.c
--- selinux-usr-nsa-20050215/libsepol/src/services.c	2005-02-15 10:28:57.000000000 -0600
+++ selinux-usr-20050216/libsepol/src/services.c	2005-02-11 11:04:56.000000000 -0600
@@ -752,13 +752,6 @@ static int sepol_compute_sid(security_id
 				}
 			}
 		}
-
-		if (!type_change && !roletr) {
-			/* No change in process role or type. */
-			*out_sid = ssid;
-			goto out;
-
-		}
 		break;
 	default:
 		break;
diff -ruNp selinux-usr-nsa-20050215/libsepol/src/write.c selinux-usr-20050216/libsepol/src/write.c
--- selinux-usr-nsa-20050215/libsepol/src/write.c	2005-01-27 17:12:52.000000000 -0600
+++ selinux-usr-20050216/libsepol/src/write.c	2005-02-16 09:51:32.000000000 -0600
@@ -695,6 +695,7 @@ int policydb_write(policydb_t * p, struc
 {
 	struct role_allow *ra;
 	struct role_trans *tr;
+	struct range_trans *rt;
 	ocontext_t *c;
 	genfs_t *genfs;
 	int i, j, num_syms;
@@ -914,6 +915,25 @@ int policydb_write(policydb_t * p, struc
 		}
 	}
 
+	if (policyvers >= POLICYDB_VERSION_MLS) {
+		nel = 0;
+		for (rt = p->range_tr; rt; rt = rt->next)
+			nel++;
+		buf[0] = cpu_to_le32(nel);
+		items = put_entry(buf, sizeof(uint32_t), 1, fp);
+		if (items != 1)
+			return -1;
+		for (rt = p->range_tr; rt; rt = rt->next) {
+			buf[0] = cpu_to_le32(rt->dom);
+			buf[1] = cpu_to_le32(rt->type);
+			items = put_entry(buf, sizeof(uint32_t), 2, fp);
+			if (items != 2)
+				return -1;
+			if (mls_write_range_helper(&rt->range, fp))
+				return -1;
+		}
+	}
+
 	return 0;
 }
 
diff -ruNp selinux-usr-nsa-20050215/policy/attrib.te selinux-usr-20050216/policy/attrib.te
--- selinux-usr-nsa-20050215/policy/attrib.te	2005-01-27 17:12:52.000000000 -0600
+++ selinux-usr-20050216/policy/attrib.te	2005-02-16 14:41:48.482570436 -0600
@@ -52,6 +52,8 @@ attribute mlsxwindowngrade;
 
 attribute mlstrustedobject;
 
+attribute privrangetrans;
+attribute mlsrangetrans;
 
 #########################
 # Attributes for domains:
diff -ruNp selinux-usr-nsa-20050215/policy/mls selinux-usr-20050216/policy/mls
--- selinux-usr-nsa-20050215/policy/mls	2005-02-15 10:28:57.000000000 -0600
+++ selinux-usr-20050216/policy/mls	2005-02-16 14:41:31.826917936 -0600
@@ -434,9 +434,13 @@ mlsconstrain msg send
 # MLS policy for the process class
 #
 
-# new process labels must be dominated by the relabling subject's clearance and
-# sensitivity level changes require privilege
-mlsconstrain process { transition dyntransition }
+# new process labels must be dominated by the relabeling subject's clearance
+# and sensitivity level changes require privilege
+mlsconstrain process transition
+	(( h1 dom h2 ) and
+	 (( l1 eq l2 ) or ( t1 == mlsprocsetsl ) or
+	  (( t1 == privrangetrans ) and ( t2 == mlsrangetrans ))));
+mlsconstrain process dyntransition
 	(( h1 dom h2 ) and
 	 (( l1 eq l2 ) or ( t1 == mlsprocsetsl )));
 

--------------010803020902030900010808--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
