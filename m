From: Eric Paris <eparis@redhat.com>
Subject: [PATCH 3/4] SELinux: standardize return code handling in selinuxfs.c
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org
Date: Wed, 27 Oct 2010 13:31:59 -0400
Message-ID: <20101027173159.22048.91668.stgit@paris.rdu.redhat.com>
In-Reply-To: <20101027173146.22048.82500.stgit@paris.rdu.redhat.com>
References: <20101027173146.22048.82500.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

selinuxfs.c has lots of different standards on how to handle return paths on
error.  For the most part transition to

	rc=errno
	if (failure)
		goto out;
[...]
out:
	cleanup()
	return rc;

Instead of doing cleanup mid function, or having multiple returns or other
options.  This doesn't do that for every function, but most of the complex
functions which have cleanup routines on error.

Signed-off-by: Eric Paris <eparis@redhat.com>
---

 security/selinux/ss/services.c |  328 +++++++++++++++++++---------------------
 1 files changed, 157 insertions(+), 171 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 223c1ff..84e2a98 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -701,11 +701,11 @@ static int security_validtrans_handle_fail(struct context *ocontext,
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
 
-	if (context_struct_to_string(ocontext, &o, &olen) < 0)
+	if (context_struct_to_string(ocontext, &o, &olen))
 		goto out;
-	if (context_struct_to_string(ncontext, &n, &nlen) < 0)
+	if (context_struct_to_string(ncontext, &n, &nlen))
 		goto out;
-	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
+	if (context_struct_to_string(tcontext, &t, &tlen))
 		goto out;
 	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
 		  "security_validate_transition:  denied for"
@@ -801,10 +801,11 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 	struct context *old_context, *new_context;
 	struct type_datum *type;
 	int index;
-	int rc = -EINVAL;
+	int rc;
 
 	read_lock(&policy_rwlock);
 
+	rc = -EINVAL;
 	old_context = sidtab_search(&sidtab, old_sid);
 	if (!old_context) {
 		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
@@ -812,6 +813,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 		goto out;
 	}
 
+	rc = -EINVAL;
 	new_context = sidtab_search(&sidtab, new_sid);
 	if (!new_context) {
 		printk(KERN_ERR "SELinux: %s: unrecognized SID %u\n",
@@ -819,11 +821,10 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 		goto out;
 	}
 
+	rc = 0;
 	/* type/domain unchanged */
-	if (old_context->type == new_context->type) {
-		rc = 0;
+	if (old_context->type == new_context->type)
 		goto out;
-	}
 
 	index = new_context->type;
 	while (true) {
@@ -831,16 +832,15 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 		BUG_ON(!type);
 
 		/* not bounded anymore */
-		if (!type->bounds) {
-			rc = -EPERM;
+		rc = -EPERM;
+		if (!type->bounds)
 			break;
-		}
 
 		/* @newsid is bounded by @oldsid */
-		if (type->bounds == old_context->type) {
-			rc = 0;
+		rc = 0;
+		if (type->bounds == old_context->type)
 			break;
-		}
+
 		index = type->bounds;
 	}
 
@@ -1187,16 +1187,13 @@ static int string_to_context_struct(struct policydb *pol,
 	if (rc)
 		goto out;
 
-	if ((p - scontext) < scontext_len) {
-		rc = -EINVAL;
+	rc = -EINVAL;
+	if ((p - scontext) < scontext_len)
 		goto out;
-	}
 
 	/* Check the validity of the new context. */
-	if (!policydb_context_isvalid(pol, ctx)) {
-		rc = -EINVAL;
+	if (!policydb_context_isvalid(pol, ctx))
 		goto out;
-	}
 	rc = 0;
 out:
 	if (rc)
@@ -1235,27 +1232,26 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 
 	if (force) {
 		/* Save another copy for storing in uninterpreted form */
+		rc = -ENOMEM;
 		str = kstrdup(scontext2, gfp_flags);
-		if (!str) {
-			kfree(scontext2);
-			return -ENOMEM;
-		}
+		if (!str)
+			goto out;
 	}
 
 	read_lock(&policy_rwlock);
-	rc = string_to_context_struct(&policydb, &sidtab,
-				      scontext2, scontext_len,
-				      &context, def_sid);
+	rc = string_to_context_struct(&policydb, &sidtab, scontext2,
+				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
 		context.len = scontext_len;
 		str = NULL;
 	} else if (rc)
-		goto out;
+		goto out_unlock;
 	rc = sidtab_context_to_sid(&sidtab, &context, sid);
 	context_destroy(&context);
-out:
+out_unlock:
 	read_unlock(&policy_rwlock);
+out:
 	kfree(scontext2);
 	kfree(str);
 	return rc;
@@ -1319,11 +1315,11 @@ static int compute_sid_handle_invalid_context(
 	char *s = NULL, *t = NULL, *n = NULL;
 	u32 slen, tlen, nlen;
 
-	if (context_struct_to_string(scontext, &s, &slen) < 0)
+	if (context_struct_to_string(scontext, &s, &slen))
 		goto out;
-	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
+	if (context_struct_to_string(tcontext, &t, &tlen))
 		goto out;
-	if (context_struct_to_string(newcontext, &n, &nlen) < 0)
+	if (context_struct_to_string(newcontext, &n, &nlen))
 		goto out;
 	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
 		  "security_compute_sid:  invalid context %s"
@@ -1569,22 +1565,17 @@ static int clone_sid(u32 sid,
 
 static inline int convert_context_handle_invalid_context(struct context *context)
 {
-	int rc = 0;
+	char *s;
+	u32 len;
 
-	if (selinux_enforcing) {
-		rc = -EINVAL;
-	} else {
-		char *s;
-		u32 len;
-
-		if (!context_struct_to_string(context, &s, &len)) {
-			printk(KERN_WARNING
-		       "SELinux:  Context %s would be invalid if enforcing\n",
-			       s);
-			kfree(s);
-		}
+	if (selinux_enforcing)
+		return -EINVAL;
+
+	if (!context_struct_to_string(context, &s, &len)) {
+		printk(KERN_WARNING "SELinux:  Context %s would be invalid if enforcing\n", s);
+		kfree(s);
 	}
-	return rc;
+	return 0;
 }
 
 struct convert_context_args {
@@ -1621,17 +1612,17 @@ static int convert_context(u32 key,
 
 	if (c->str) {
 		struct context ctx;
+
+		rc = -ENOMEM;
 		s = kstrdup(c->str, GFP_KERNEL);
-		if (!s) {
-			rc = -ENOMEM;
+		if (!s)
 			goto out;
-		}
+
 		rc = string_to_context_struct(args->newp, NULL, s,
 					      c->len, &ctx, SECSID_NULL);
 		kfree(s);
 		if (!rc) {
-			printk(KERN_INFO
-		       "SELinux:  Context %s became valid (mapped).\n",
+			printk(KERN_INFO "SELinux:  Context %s became valid (mapped).\n",
 			       c->str);
 			/* Replace string with mapped representation. */
 			kfree(c->str);
@@ -1643,8 +1634,7 @@ static int convert_context(u32 key,
 			goto out;
 		} else {
 			/* Other error condition, e.g. ENOMEM. */
-			printk(KERN_ERR
-		       "SELinux:   Unable to map context %s, rc = %d.\n",
+			printk(KERN_ERR "SELinux:   Unable to map context %s, rc = %d.\n",
 			       c->str, -rc);
 			goto out;
 		}
@@ -1654,9 +1644,8 @@ static int convert_context(u32 key,
 	if (rc)
 		goto out;
 
-	rc = -EINVAL;
-
 	/* Convert the user. */
+	rc = -EINVAL;
 	usrdatum = hashtab_search(args->newp->p_users.table,
 				  args->oldp->p_user_val_to_name[c->user - 1]);
 	if (!usrdatum)
@@ -1664,6 +1653,7 @@ static int convert_context(u32 key,
 	c->user = usrdatum->value;
 
 	/* Convert the role. */
+	rc = -EINVAL;
 	role = hashtab_search(args->newp->p_roles.table,
 			      args->oldp->p_role_val_to_name[c->role - 1]);
 	if (!role)
@@ -1671,6 +1661,7 @@ static int convert_context(u32 key,
 	c->role = role->value;
 
 	/* Convert the type. */
+	rc = -EINVAL;
 	typdatum = hashtab_search(args->newp->p_types.table,
 				  args->oldp->p_type_val_to_name[c->type - 1]);
 	if (!typdatum)
@@ -1700,6 +1691,7 @@ static int convert_context(u32 key,
 		oc = args->newp->ocontexts[OCON_ISID];
 		while (oc && oc->sid[0] != SECINITSID_UNLABELED)
 			oc = oc->next;
+		rc = -EINVAL;
 		if (!oc) {
 			printk(KERN_ERR "SELinux:  unable to look up"
 				" the initial SIDs list\n");
@@ -1719,19 +1711,20 @@ static int convert_context(u32 key,
 	}
 
 	context_destroy(&oldc);
+
 	rc = 0;
 out:
 	return rc;
 bad:
 	/* Map old representation to string and save it. */
-	if (context_struct_to_string(&oldc, &s, &len))
-		return -ENOMEM;
+	rc = context_struct_to_string(&oldc, &s, &len);
+	if (rc)
+		return rc;
 	context_destroy(&oldc);
 	context_destroy(c);
 	c->str = s;
 	c->len = len;
-	printk(KERN_INFO
-	       "SELinux:  Context %s became invalid (unmapped).\n",
+	printk(KERN_INFO "SELinux:  Context %s became invalid (unmapped).\n",
 	       c->str);
 	rc = 0;
 	goto out;
@@ -2012,7 +2005,7 @@ int security_node_sid(u16 domain,
 		      u32 addrlen,
 		      u32 *out_sid)
 {
-	int rc = 0;
+	int rc;
 	struct ocontext *c;
 
 	read_lock(&policy_rwlock);
@@ -2021,10 +2014,9 @@ int security_node_sid(u16 domain,
 	case AF_INET: {
 		u32 addr;
 
-		if (addrlen != sizeof(u32)) {
-			rc = -EINVAL;
+		rc = -EINVAL;
+		if (addrlen != sizeof(u32))
 			goto out;
-		}
 
 		addr = *((u32 *)addrp);
 
@@ -2038,10 +2030,9 @@ int security_node_sid(u16 domain,
 	}
 
 	case AF_INET6:
-		if (addrlen != sizeof(u64) * 2) {
-			rc = -EINVAL;
+		rc = -EINVAL;
+		if (addrlen != sizeof(u64) * 2)
 			goto out;
-		}
 		c = policydb.ocontexts[OCON_NODE6];
 		while (c) {
 			if (match_ipv6_addrmask(addrp, c->u.node6.addr,
@@ -2052,6 +2043,7 @@ int security_node_sid(u16 domain,
 		break;
 
 	default:
+		rc = 0;
 		*out_sid = SECINITSID_NODE;
 		goto out;
 	}
@@ -2069,6 +2061,7 @@ int security_node_sid(u16 domain,
 		*out_sid = SECINITSID_NODE;
 	}
 
+	rc = 0;
 out:
 	read_unlock(&policy_rwlock);
 	return rc;
@@ -2113,24 +2106,22 @@ int security_get_user_sids(u32 fromsid,
 
 	context_init(&usercon);
 
+	rc = -EINVAL;
 	fromcon = sidtab_search(&sidtab, fromsid);
-	if (!fromcon) {
-		rc = -EINVAL;
+	if (!fromcon)
 		goto out_unlock;
-	}
 
+	rc = -EINVAL;
 	user = hashtab_search(policydb.p_users.table, username);
-	if (!user) {
-		rc = -EINVAL;
+	if (!user)
 		goto out_unlock;
-	}
+
 	usercon.user = user->value;
 
+	rc = -ENOMEM;
 	mysids = kcalloc(maxnel, sizeof(*mysids), GFP_ATOMIC);
-	if (!mysids) {
-		rc = -ENOMEM;
+	if (!mysids)
 		goto out_unlock;
-	}
 
 	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
 		role = policydb.role_val_to_struct[i];
@@ -2147,12 +2138,11 @@ int security_get_user_sids(u32 fromsid,
 			if (mynel < maxnel) {
 				mysids[mynel++] = sid;
 			} else {
+				rc = -ENOMEM;
 				maxnel += SIDS_NEL;
 				mysids2 = kcalloc(maxnel, sizeof(*mysids2), GFP_ATOMIC);
-				if (!mysids2) {
-					rc = -ENOMEM;
+				if (!mysids2)
 					goto out_unlock;
-				}
 				memcpy(mysids2, mysids, mynel * sizeof(*mysids2));
 				kfree(mysids);
 				mysids = mysids2;
@@ -2160,7 +2150,7 @@ int security_get_user_sids(u32 fromsid,
 			}
 		}
 	}
-
+	rc = 0;
 out_unlock:
 	read_unlock(&policy_rwlock);
 	if (rc || !mynel) {
@@ -2168,9 +2158,9 @@ out_unlock:
 		goto out;
 	}
 
+	rc = -ENOMEM;
 	mysids2 = kcalloc(mynel, sizeof(*mysids2), GFP_KERNEL);
 	if (!mysids2) {
-		rc = -ENOMEM;
 		kfree(mysids);
 		goto out;
 	}
@@ -2211,7 +2201,7 @@ int security_genfs_sid(const char *fstype,
 	u16 sclass;
 	struct genfs *genfs;
 	struct ocontext *c;
-	int rc = 0, cmp = 0;
+	int rc, cmp = 0;
 
 	while (path[0] == '/' && path[1] == '/')
 		path++;
@@ -2219,6 +2209,7 @@ int security_genfs_sid(const char *fstype,
 	read_lock(&policy_rwlock);
 
 	sclass = unmap_class(orig_sclass);
+	*sid = SECINITSID_UNLABELED;
 
 	for (genfs = policydb.genfs; genfs; genfs = genfs->next) {
 		cmp = strcmp(fstype, genfs->fstype);
@@ -2226,11 +2217,9 @@ int security_genfs_sid(const char *fstype,
 			break;
 	}
 
-	if (!genfs || cmp) {
-		*sid = SECINITSID_UNLABELED;
-		rc = -ENOENT;
+	rc = -ENOENT;
+	if (!genfs || cmp)
 		goto out;
-	}
 
 	for (c = genfs->head; c; c = c->next) {
 		len = strlen(c->u.name);
@@ -2239,21 +2228,18 @@ int security_genfs_sid(const char *fstype,
 			break;
 	}
 
-	if (!c) {
-		*sid = SECINITSID_UNLABELED;
-		rc = -ENOENT;
+	rc = -ENOENT;
+	if (!c)
 		goto out;
-	}
 
 	if (!c->sid[0]) {
-		rc = sidtab_context_to_sid(&sidtab,
-					   &c->context[0],
-					   &c->sid[0]);
+		rc = sidtab_context_to_sid(&sidtab, &c->context[0], &c->sid[0]);
 		if (rc)
 			goto out;
 	}
 
 	*sid = c->sid[0];
+	rc = 0;
 out:
 	read_unlock(&policy_rwlock);
 	return rc;
@@ -2285,8 +2271,7 @@ int security_fs_use(
 	if (c) {
 		*behavior = c->v.behavior;
 		if (!c->sid[0]) {
-			rc = sidtab_context_to_sid(&sidtab,
-						   &c->context[0],
+			rc = sidtab_context_to_sid(&sidtab, &c->context[0],
 						   &c->sid[0]);
 			if (rc)
 				goto out;
@@ -2309,33 +2294,38 @@ out:
 
 int security_get_bools(int *len, char ***names, int **values)
 {
-	int i, rc = -ENOMEM;
+	int i, rc;
 
 	read_lock(&policy_rwlock);
 	*names = NULL;
 	*values = NULL;
 
+	rc = 0;
 	*len = policydb.p_bools.nprim;
-	if (!*len) {
-		rc = 0;
+	if (!*len)
 		goto out;
-	}
 
-       *names = kcalloc(*len, sizeof(char *), GFP_ATOMIC);
+	rc = -ENOMEM;
+	*names = kcalloc(*len, sizeof(char *), GFP_ATOMIC);
 	if (!*names)
 		goto err;
 
-       *values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
+	rc = -ENOMEM;
+	*values = kcalloc(*len, sizeof(int), GFP_ATOMIC);
 	if (!*values)
 		goto err;
 
 	for (i = 0; i < *len; i++) {
 		size_t name_len;
+
 		(*values)[i] = policydb.bool_val_to_struct[i]->state;
 		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
-	       (*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
+
+		rc = -ENOMEM;
+		(*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
 		if (!(*names)[i])
 			goto err;
+
 		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
 		(*names)[i][name_len - 1] = 0;
 	}
@@ -2355,17 +2345,16 @@ err:
 
 int security_set_bools(int len, int *values)
 {
-	int i, rc = 0;
+	int i, rc;
 	int lenp, seqno = 0;
 	struct cond_node *cur;
 
 	write_lock_irq(&policy_rwlock);
 
+	rc = -EFAULT;
 	lenp = policydb.p_bools.nprim;
-	if (len != lenp) {
-		rc = -EFAULT;
+	if (len != lenp)
 		goto out;
-	}
 
 	for (i = 0; i < len; i++) {
 		if (!!values[i] != policydb.bool_val_to_struct[i]->state) {
@@ -2391,7 +2380,7 @@ int security_set_bools(int len, int *values)
 	}
 
 	seqno = ++latest_granting;
-
+	rc = 0;
 out:
 	write_unlock_irq(&policy_rwlock);
 	if (!rc) {
@@ -2405,16 +2394,15 @@ out:
 
 int security_get_bool_value(int bool)
 {
-	int rc = 0;
+	int rc;
 	int len;
 
 	read_lock(&policy_rwlock);
 
+	rc = -EFAULT;
 	len = policydb.p_bools.nprim;
-	if (bool >= len) {
-		rc = -EFAULT;
+	if (bool >= len)
 		goto out;
-	}
 
 	rc = policydb.bool_val_to_struct[bool]->state;
 out:
@@ -2464,8 +2452,9 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	struct context newcon;
 	char *s;
 	u32 len;
-	int rc = 0;
+	int rc;
 
+	rc = 0;
 	if (!ss_initialized || !policydb.mls_enabled) {
 		*new_sid = sid;
 		goto out;
@@ -2474,19 +2463,20 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	context_init(&newcon);
 
 	read_lock(&policy_rwlock);
+
+	rc = -EINVAL;
 	context1 = sidtab_search(&sidtab, sid);
 	if (!context1) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, sid);
-		rc = -EINVAL;
 		goto out_unlock;
 	}
 
+	rc = -EINVAL;
 	context2 = sidtab_search(&sidtab, mls_sid);
 	if (!context2) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 			__func__, mls_sid);
-		rc = -EINVAL;
 		goto out_unlock;
 	}
 
@@ -2500,20 +2490,17 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	/* Check the validity of the new context. */
 	if (!policydb_context_isvalid(&policydb, &newcon)) {
 		rc = convert_context_handle_invalid_context(&newcon);
-		if (rc)
-			goto bad;
+		if (rc) {
+			if (!context_struct_to_string(&newcon, &s, &len)) {
+				audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
+					  "security_sid_mls_copy: invalid context %s", s);
+				kfree(s);
+			}
+			goto out_unlock;
+		}
 	}
 
 	rc = sidtab_context_to_sid(&sidtab, &newcon, new_sid);
-	goto out_unlock;
-
-bad:
-	if (!context_struct_to_string(&newcon, &s, &len)) {
-		audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
-			  "security_sid_mls_copy: invalid context %s", s);
-		kfree(s);
-	}
-
 out_unlock:
 	read_unlock(&policy_rwlock);
 	context_destroy(&newcon);
@@ -2549,6 +2536,8 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 	struct context *nlbl_ctx;
 	struct context *xfrm_ctx;
 
+	*peer_sid = SECSID_NULL;
+
 	/* handle the common (which also happens to be the set of easy) cases
 	 * right away, these two if statements catch everything involving a
 	 * single or absent peer SID/label */
@@ -2567,40 +2556,37 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 	/* we don't need to check ss_initialized here since the only way both
 	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
 	 * security server was initialized and ss_initialized was true */
-	if (!policydb.mls_enabled) {
-		*peer_sid = SECSID_NULL;
+	if (!policydb.mls_enabled)
 		return 0;
-	}
 
 	read_lock(&policy_rwlock);
 
+	rc = -EINVAL;
 	nlbl_ctx = sidtab_search(&sidtab, nlbl_sid);
 	if (!nlbl_ctx) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, nlbl_sid);
-		rc = -EINVAL;
-		goto out_slowpath;
+		goto out;
 	}
+	rc = -EINVAL;
 	xfrm_ctx = sidtab_search(&sidtab, xfrm_sid);
 	if (!xfrm_ctx) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized SID %d\n",
 		       __func__, xfrm_sid);
-		rc = -EINVAL;
-		goto out_slowpath;
+		goto out;
 	}
 	rc = (mls_context_cmp(nlbl_ctx, xfrm_ctx) ? 0 : -EACCES);
+	if (rc)
+		goto out;
 
-out_slowpath:
+	/* at present NetLabel SIDs/labels really only carry MLS
+	 * information so if the MLS portion of the NetLabel SID
+	 * matches the MLS portion of the labeled XFRM SID/label
+	 * then pass along the XFRM SID as it is the most
+	 * expressive */
+	*peer_sid = xfrm_sid;
+out:
 	read_unlock(&policy_rwlock);
-	if (rc == 0)
-		/* at present NetLabel SIDs/labels really only carry MLS
-		 * information so if the MLS portion of the NetLabel SID
-		 * matches the MLS portion of the labeled XFRM SID/label
-		 * then pass along the XFRM SID as it is the most
-		 * expressive */
-		*peer_sid = xfrm_sid;
-	else
-		*peer_sid = SECSID_NULL;
 	return rc;
 }
 
@@ -2619,10 +2605,11 @@ static int get_classes_callback(void *k, void *d, void *args)
 
 int security_get_classes(char ***classes, int *nclasses)
 {
-	int rc = -ENOMEM;
+	int rc;
 
 	read_lock(&policy_rwlock);
 
+	rc = -ENOMEM;
 	*nclasses = policydb.p_classes.nprim;
 	*classes = kcalloc(*nclasses, sizeof(**classes), GFP_ATOMIC);
 	if (!*classes)
@@ -2630,7 +2617,7 @@ int security_get_classes(char ***classes, int *nclasses)
 
 	rc = hashtab_map(policydb.p_classes.table, get_classes_callback,
 			*classes);
-	if (rc < 0) {
+	if (rc) {
 		int i;
 		for (i = 0; i < *nclasses; i++)
 			kfree((*classes)[i]);
@@ -2657,19 +2644,20 @@ static int get_permissions_callback(void *k, void *d, void *args)
 
 int security_get_permissions(char *class, char ***perms, int *nperms)
 {
-	int rc = -ENOMEM, i;
+	int rc, i;
 	struct class_datum *match;
 
 	read_lock(&policy_rwlock);
 
+	rc = -EINVAL;
 	match = hashtab_search(policydb.p_classes.table, class);
 	if (!match) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
-		rc = -EINVAL;
 		goto out;
 	}
 
+	rc = -ENOMEM;
 	*nperms = match->permissions.nprim;
 	*perms = kcalloc(*nperms, sizeof(**perms), GFP_ATOMIC);
 	if (!*perms)
@@ -2678,13 +2666,13 @@ int security_get_permissions(char *class, char ***perms, int *nperms)
 	if (match->comdatum) {
 		rc = hashtab_map(match->comdatum->permissions.table,
 				get_permissions_callback, *perms);
-		if (rc < 0)
+		if (rc)
 			goto err;
 	}
 
 	rc = hashtab_map(match->permissions.table, get_permissions_callback,
 			*perms);
-	if (rc < 0)
+	if (rc)
 		goto err;
 
 out:
@@ -2796,36 +2784,39 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	switch (field) {
 	case AUDIT_SUBJ_USER:
 	case AUDIT_OBJ_USER:
+		rc = -EINVAL;
 		userdatum = hashtab_search(policydb.p_users.table, rulestr);
 		if (!userdatum)
-			rc = -EINVAL;
-		else
-			tmprule->au_ctxt.user = userdatum->value;
+			goto out;
+		tmprule->au_ctxt.user = userdatum->value;
 		break;
 	case AUDIT_SUBJ_ROLE:
 	case AUDIT_OBJ_ROLE:
+		rc = -EINVAL;
 		roledatum = hashtab_search(policydb.p_roles.table, rulestr);
 		if (!roledatum)
-			rc = -EINVAL;
-		else
-			tmprule->au_ctxt.role = roledatum->value;
+			goto out;
+		tmprule->au_ctxt.role = roledatum->value;
 		break;
 	case AUDIT_SUBJ_TYPE:
 	case AUDIT_OBJ_TYPE:
+		rc = -EINVAL;
 		typedatum = hashtab_search(policydb.p_types.table, rulestr);
 		if (!typedatum)
-			rc = -EINVAL;
-		else
-			tmprule->au_ctxt.type = typedatum->value;
+			goto out;
+		tmprule->au_ctxt.type = typedatum->value;
 		break;
 	case AUDIT_SUBJ_SEN:
 	case AUDIT_SUBJ_CLR:
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
 		rc = mls_from_string(rulestr, &tmprule->au_ctxt, GFP_ATOMIC);
+		if (rc)
+			goto out;
 		break;
 	}
-
+	rc = 0;
+out:
 	read_unlock(&policy_rwlock);
 
 	if (rc) {
@@ -3127,28 +3118,23 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 		return 0;
 
 	read_lock(&policy_rwlock);
+
+	rc = -ENOENT;
 	ctx = sidtab_search(&sidtab, sid);
-	if (ctx == NULL) {
-		rc = -ENOENT;
-		goto netlbl_sid_to_secattr_failure;
-	}
+	if (ctx == NULL)
+		goto out;
+
+	rc = -ENOMEM;
 	secattr->domain = kstrdup(policydb.p_type_val_to_name[ctx->type - 1],
 				  GFP_ATOMIC);
-	if (secattr->domain == NULL) {
-		rc = -ENOMEM;
-		goto netlbl_sid_to_secattr_failure;
-	}
+	if (secattr->domain == NULL)
+		goto out;
+
 	secattr->attr.secid = sid;
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
 	mls_export_netlbl_lvl(ctx, secattr);
 	rc = mls_export_netlbl_cat(ctx, secattr);
-	if (rc != 0)
-		goto netlbl_sid_to_secattr_failure;
-	read_unlock(&policy_rwlock);
-
-	return 0;
-
-netlbl_sid_to_secattr_failure:
+out:
 	read_unlock(&policy_rwlock);
 	return rc;
 }


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
