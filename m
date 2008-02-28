Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1SLmARk000744
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 16:48:10 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1SLm6B0018615
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 21:48:07 GMT
Received: from g1t0029.austin.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id 21C83380CC
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 21:42:04 +0000 (UTC)
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
	by g1t0029.austin.hp.com (Postfix) with ESMTP id 0A75B380C2
	for <selinux@tycho.nsa.gov>; Thu, 28 Feb 2008 21:42:03 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH] SELinux: Cleanup the secid/secctx conversion functions
To: selinux@tycho.nsa.gov
Date: Thu, 28 Feb 2008 16:41:52 -0500
Message-ID: <20080228214152.32557.76137.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

While looking at the SELinux secid/secctx conversion functions I realized they
could probably do with a little cleanup to reduce the amount of code and make
better use of existing string processing functions in the kernel.  Making use
of the kernel's existing string processing functions is a good idea as many
architectures have specialized/optimized routines which should be an
improvement over the generic code in the SELinux security server.
---

 security/selinux/ss/mls.c      |   61 +++++--------
 security/selinux/ss/mls.h      |    3 -
 security/selinux/ss/services.c |  194 ++++++++++++++++------------------------
 3 files changed, 103 insertions(+), 155 deletions(-)

diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index feaf0a5..ba211b4 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -239,8 +239,7 @@ int mls_context_isvalid(struct policydb *p, struct context *c)
  * Policy read-lock must be held for sidtab lookup.
  *
  */
-int mls_context_to_sid(char oldc,
-		       char **scontext,
+int mls_context_to_sid(char **scontext,
 		       struct context *context,
 		       struct sidtab *s,
 		       u32 def_sid)
@@ -250,10 +249,10 @@ int mls_context_to_sid(char oldc,
 	char *scontextp, *p, *rngptr;
 	struct level_datum *levdatum;
 	struct cat_datum *catdatum, *rngdatum;
-	int l, rc = -EINVAL;
+	int l, rc;
 
 	if (!selinux_mls_enabled) {
-		if (def_sid != SECSID_NULL && oldc)
+		if (def_sid != SECSID_NULL && *scontext && **scontext)
 			*scontext += strlen(*scontext)+1;
 		return 0;
 	}
@@ -262,18 +261,17 @@ int mls_context_to_sid(char oldc,
 	 * No MLS component to the security context, try and map to
 	 * default if provided.
 	 */
-	if (!oldc) {
+	if (!(*scontext) || !(**scontext)) {
 		struct context *defcon;
 
 		if (def_sid == SECSID_NULL)
-			goto out;
+			return -EINVAL;
 
 		defcon = sidtab_search(s, def_sid);
 		if (!defcon)
-			goto out;
+			return -EINVAL;
 
-		rc = mls_context_cpy(context, defcon);
-		goto out;
+		return mls_context_cpy(context, defcon);
 	}
 
 	/* Extract low sensitivity. */
@@ -287,10 +285,8 @@ int mls_context_to_sid(char oldc,
 
 	for (l = 0; l < 2; l++) {
 		levdatum = hashtab_search(policydb.p_levels.table, scontextp);
-		if (!levdatum) {
-			rc = -EINVAL;
-			goto out;
-		}
+		if (!levdatum)
+			return -EINVAL;
 
 		context->range.level[l].sens = levdatum->level->sens;
 
@@ -312,35 +308,29 @@ int mls_context_to_sid(char oldc,
 
 				catdatum = hashtab_search(policydb.p_cats.table,
 				                          scontextp);
-				if (!catdatum) {
-					rc = -EINVAL;
-					goto out;
-				}
+				if (!catdatum)
+					return -EINVAL;
 
 				rc = ebitmap_set_bit(&context->range.level[l].cat,
 				                     catdatum->value - 1, 1);
 				if (rc)
-					goto out;
+					return rc;
 
 				/* If range, set all categories in range */
 				if (rngptr) {
 					int i;
 
 					rngdatum = hashtab_search(policydb.p_cats.table, rngptr);
-					if (!rngdatum) {
-						rc = -EINVAL;
-						goto out;
-					}
+					if (!rngdatum)
+						return -EINVAL;
 
-					if (catdatum->value >= rngdatum->value) {
-						rc = -EINVAL;
-						goto out;
-					}
+					if (catdatum->value >= rngdatum->value)
+						return -EINVAL;
 
 					for (i = catdatum->value; i < rngdatum->value; i++) {
 						rc = ebitmap_set_bit(&context->range.level[l].cat, i, 1);
 						if (rc)
-							goto out;
+							return rc;
 					}
 				}
 
@@ -366,12 +356,10 @@ int mls_context_to_sid(char oldc,
 		rc = ebitmap_cpy(&context->range.level[1].cat,
 				 &context->range.level[0].cat);
 		if (rc)
-			goto out;
+			return rc;
 	}
 	*scontext = ++p;
-	rc = 0;
-out:
-	return rc;
+	return 0;
 }
 
 /*
@@ -391,13 +379,10 @@ int mls_from_string(char *str, struct context *context, gfp_t gfp_mask)
 	/* we need freestr because mls_context_to_sid will change
 	   the value of tmpstr */
 	tmpstr = freestr = kstrdup(str, gfp_mask);
-	if (!tmpstr) {
-		rc = -ENOMEM;
-	} else {
-		rc = mls_context_to_sid(':', &tmpstr, context,
-		                        NULL, SECSID_NULL);
-		kfree(freestr);
-	}
+	if (!tmpstr)
+		return -ENOMEM;
+	rc = mls_context_to_sid(&tmpstr, context, NULL, SECSID_NULL);
+	kfree(freestr);
 
 	return rc;
 }
diff --git a/security/selinux/ss/mls.h b/security/selinux/ss/mls.h
index ab53663..b364f61 100644
--- a/security/selinux/ss/mls.h
+++ b/security/selinux/ss/mls.h
@@ -30,8 +30,7 @@ int mls_context_isvalid(struct policydb *p, struct context *c);
 int mls_range_isvalid(struct policydb *p, struct mls_range *r);
 int mls_level_isvalid(struct policydb *p, struct mls_level *l);
 
-int mls_context_to_sid(char oldc,
-	               char **scontext,
+int mls_context_to_sid(char **scontext,
 		       struct context *context,
 		       struct sidtab *s,
 		       u32 def_sid);
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index f374186..4aab8a5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -573,47 +573,43 @@ out:
 	return rc;
 }
 
-/*
- * Write the security context string representation of
- * the context structure `context' into a dynamically
- * allocated string of the correct size.  Set `*scontext'
- * to point to this string and set `*scontext_len' to
- * the length of the string.
+/**
+ * context_struct_to_string - Generate a string representation of a context
+ * @context: native security context
+ * @scontext: security context string
+ * @scontext_len: length of security context string
+ *
+ * Description:
+ * Write the security context string representation of @context into
+ * @scontext.  The caller must free @scontext when finished.  Returns zero on
+ * success, negative values on failure.
+ *
  */
-static int context_struct_to_string(struct context *context, char **scontext, u32 *scontext_len)
+static int context_struct_to_string(struct context *context,
+				    char **scontext, u32 *scontext_len)
 {
-	char *scontextp;
+	char *ctx;
 
-	*scontext = NULL;
-	*scontext_len = 0;
-
-	/* Compute the size of the context. */
-	*scontext_len += strlen(policydb.p_user_val_to_name[context->user - 1]) + 1;
-	*scontext_len += strlen(policydb.p_role_val_to_name[context->role - 1]) + 1;
-	*scontext_len += strlen(policydb.p_type_val_to_name[context->type - 1]) + 1;
-	*scontext_len += mls_compute_context_len(context);
+	*scontext_len = strlen(policydb.p_user_val_to_name[context->user - 1]) +
+		strlen(policydb.p_role_val_to_name[context->role - 1]) +
+		strlen(policydb.p_type_val_to_name[context->type - 1]) +
+		mls_compute_context_len(context) + 3;
 
 	/* Allocate space for the context; caller must free this space. */
-	scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
-	if (!scontextp) {
+	*scontext = kmalloc(*scontext_len, GFP_ATOMIC);
+	if (!*scontext) {
+		*scontext_len = 0;
 		return -ENOMEM;
 	}
-	*scontext = scontextp;
 
-	/*
-	 * Copy the user name, role name and type name into the context.
-	 */
-	sprintf(scontextp, "%s:%s:%s",
-		policydb.p_user_val_to_name[context->user - 1],
-		policydb.p_role_val_to_name[context->role - 1],
-		policydb.p_type_val_to_name[context->type - 1]);
-	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
-	             1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
-	             1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
-
-	mls_sid_to_context(context, &scontextp);
-
-	*scontextp = 0;
+	ctx = *scontext;
+	strcpy(ctx, policydb.p_user_val_to_name[context->user - 1]);
+	strcat(ctx, ":");
+	strcat(ctx, policydb.p_role_val_to_name[context->role - 1]);
+	strcat(ctx, ":");
+	strcat(ctx, policydb.p_type_val_to_name[context->type - 1]);
+	ctx += strlen(ctx);
+	mls_sid_to_context(context, &ctx);
 
 	return 0;
 }
@@ -640,68 +636,62 @@ const char *security_get_initial_sid_context(u32 sid)
 int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 {
 	struct context *context;
-	int rc = 0;
-
-	*scontext = NULL;
-	*scontext_len  = 0;
+	int rc;
 
 	if (!ss_initialized) {
-		if (sid <= SECINITSID_NUM) {
-			char *scontextp;
-
-			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
-			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
-			if (!scontextp) {
-				rc = -ENOMEM;
-				goto out;
-			}
-			strcpy(scontextp, initial_sid_to_string[sid]);
-			*scontext = scontextp;
-			goto out;
+		if (sid > SECINITSID_NUM) {
+			printk(KERN_ERR
+			       "security_sid_to_context:  called before "
+			       "initial load_policy on unknown SID %d\n", sid);
+			goto err;
 		}
-		printk(KERN_ERR "security_sid_to_context:  called before initial "
-		       "load_policy on unknown SID %d\n", sid);
-		rc = -EINVAL;
-		goto out;
+		*scontext = kstrdup(initial_sid_to_string[sid], GFP_ATOMIC);
+		if (*scontext == NULL)
+			return -ENOMEM;
+		*scontext_len = strlen(*scontext) + 1;
+		return 0;
 	}
+
 	POLICY_RDLOCK;
 	context = sidtab_search(&sidtab, sid);
 	if (!context) {
-		printk(KERN_ERR "security_sid_to_context:  unrecognized SID "
-		       "%d\n", sid);
-		rc = -EINVAL;
-		goto out_unlock;
+		POLICY_RDUNLOCK;
+		printk(KERN_ERR
+		       "security_sid_to_context:  unrecognized SID %d\n", sid);
+		goto err;
 	}
 	rc = context_struct_to_string(context, scontext, scontext_len);
-out_unlock:
 	POLICY_RDUNLOCK;
-out:
 	return rc;
 
+err:
+	*scontext = NULL;
+	*scontext_len = 0;
+	return -EINVAL;
 }
 
-static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
+static int security_context_to_sid_core(char *scontext, u32 scontext_len,
+					u32 *sid, u32 def_sid)
 {
-	char *scontext2;
+	char *scontext_dup, *scontext_iter, *scontext_next;
 	struct context context;
-	struct role_datum *role;
+	struct role_datum *roledatum;
 	struct type_datum *typdatum;
 	struct user_datum *usrdatum;
-	char *scontextp, *p, oldc;
-	int rc = 0;
+	int rc = -EINVAL;
 
 	if (!ss_initialized) {
 		int i;
 
-		for (i = 1; i < SECINITSID_NUM; i++) {
+		for (i = 1; i < SECINITSID_NUM; i++)
 			if (!strcmp(initial_sid_to_string[i], scontext)) {
 				*sid = i;
-				goto out;
+				return 0;
 			}
-		}
 		*sid = SECINITSID_KERNEL;
-		goto out;
+		return 0;
 	}
+
 	*sid = SECSID_NULL;
 
 	/* Copy the string so that we can modify the copy as we parse it.
@@ -709,73 +699,46 @@ static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *s
 	   null suffix to the copy to avoid problems with the existing
 	   attr package, which doesn't view the null terminator as part
 	   of the attribute value. */
-	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
-	if (!scontext2) {
-		rc = -ENOMEM;
-		goto out;
-	}
-	memcpy(scontext2, scontext, scontext_len);
-	scontext2[scontext_len] = 0;
+	scontext_dup = kmemdup(scontext, scontext_len + 1, GFP_KERNEL);
+	if (!scontext_dup)
+		return -ENOMEM;
+	scontext_dup[scontext_len] = 0;
 
 	context_init(&context);
-	*sid = SECSID_NULL;
+	scontext_next = scontext_dup;
 
 	POLICY_RDLOCK;
 
-	/* Parse the security context. */
-
-	rc = -EINVAL;
-	scontextp = (char *) scontext2;
-
 	/* Extract the user. */
-	p = scontextp;
-	while (*p && *p != ':')
-		p++;
-
-	if (*p == 0)
+	scontext_iter = strsep(&scontext_next, ":");
+	if (!scontext_next)
 		goto out_unlock;
-
-	*p++ = 0;
-
-	usrdatum = hashtab_search(policydb.p_users.table, scontextp);
+	usrdatum = hashtab_search(policydb.p_users.table, scontext_iter);
 	if (!usrdatum)
 		goto out_unlock;
-
 	context.user = usrdatum->value;
 
 	/* Extract role. */
-	scontextp = p;
-	while (*p && *p != ':')
-		p++;
-
-	if (*p == 0)
+	scontext_iter = strsep(&scontext_next, ":");
+	if (!scontext_next)
 		goto out_unlock;
-
-	*p++ = 0;
-
-	role = hashtab_search(policydb.p_roles.table, scontextp);
-	if (!role)
+	roledatum = hashtab_search(policydb.p_roles.table, scontext_iter);
+	if (!roledatum)
 		goto out_unlock;
-	context.role = role->value;
+	context.role = roledatum->value;
 
 	/* Extract type. */
-	scontextp = p;
-	while (*p && *p != ':')
-		p++;
-	oldc = *p;
-	*p++ = 0;
-
-	typdatum = hashtab_search(policydb.p_types.table, scontextp);
+	scontext_iter = strsep(&scontext_next, ":");
+	typdatum = hashtab_search(policydb.p_types.table, scontext_iter);
 	if (!typdatum)
 		goto out_unlock;
-
 	context.type = typdatum->value;
 
-	rc = mls_context_to_sid(oldc, &p, &context, &sidtab, def_sid);
+	/* Extract MLS range. */
+	rc = mls_context_to_sid(&scontext_next, &context, &sidtab, def_sid);
 	if (rc)
 		goto out_unlock;
-
-	if ((p - scontext2) < scontext_len) {
+	if (scontext_next - scontext_dup < scontext_len) {
 		rc = -EINVAL;
 		goto out_unlock;
 	}
@@ -785,13 +748,14 @@ static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *s
 		rc = -EINVAL;
 		goto out_unlock;
 	}
+
 	/* Obtain the new sid. */
 	rc = sidtab_context_to_sid(&sidtab, &context, sid);
+
 out_unlock:
 	POLICY_RDUNLOCK;
 	context_destroy(&context);
-	kfree(scontext2);
-out:
+	kfree(scontext_dup);
 	return rc;
 }
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
