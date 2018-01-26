From: <peter.enderborg@sony.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 Daniel Jurgens <danielj@mellanox.com>,
 Doug Ledford <dledford@redhat.com>, <selinux@tycho.nsa.gov>,
 <linux-security-module@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 <alsa-devel@alsa-project.org>, "Serge E . Hallyn" <serge@hallyn.com>
CC: Peter Enderborg <peter.enderborg@sony.com>
Date: Fri, 26 Jan 2018 15:32:38 +0100
Message-ID: <20180126143241.23108-3-peter.enderborg@sony.com>
In-Reply-To: <20180126143241.23108-1-peter.enderborg@sony.com>
References: <20180126143241.23108-1-peter.enderborg@sony.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH v2 2/5] selinux: Move policydb to pointer structure
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Peter Enderborg <peter.enderborg@sony.com>

To be able to use rcu locks we seed to address the policydb
though a pointer. This patch adds a pointer structure to
repleace the static policydb.

Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
---
 security/selinux/ss/services.c | 274 ++++++++++++++++++++++-------------------
 1 file changed, 149 insertions(+), 125 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 47d8030..21400bd 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -90,7 +90,6 @@ int selinux_policycap_nnp_nosuid_transition;
 static DEFINE_RWLOCK(policy_rwlock);
 
 static struct sidtab sidtab;
-static struct policydb policydb;
 int ss_initialized;
 
 /*
@@ -120,6 +119,7 @@ struct selinux_mapping {
 struct shared_current_mapping {
 	struct selinux_mapping *current_mapping;
 	u16 current_mapping_size;
+	struct policydb policydb;
 };
 
 static struct shared_current_mapping *crm;
@@ -277,7 +277,7 @@ static void map_decision(u16 tclass, struct av_decision *avd,
 
 int security_mls_enabled(void)
 {
-	return policydb.mls_enabled;
+	return crm->policydb.mls_enabled;
 }
 
 /*
@@ -335,8 +335,8 @@ static int constraint_expr_eval(struct context *scontext,
 			case CEXPR_ROLE:
 				val1 = scontext->role;
 				val2 = tcontext->role;
-				r1 = policydb.role_val_to_struct[val1 - 1];
-				r2 = policydb.role_val_to_struct[val2 - 1];
+				r1 = crm->policydb.role_val_to_struct[val1 - 1];
+				r2 = crm->policydb.role_val_to_struct[val2 - 1];
 				switch (e->op) {
 				case CEXPR_DOM:
 					s[++sp] = ebitmap_get_bit(&r1->dominates,
@@ -501,8 +501,8 @@ static void security_dump_masked_av(struct context *scontext,
 	if (!permissions)
 		return;
 
-	tclass_name = sym_name(&policydb, SYM_CLASSES, tclass - 1);
-	tclass_dat = policydb.class_val_to_struct[tclass - 1];
+	tclass_name = sym_name(&crm->policydb, SYM_CLASSES, tclass - 1);
+	tclass_dat = crm->policydb.class_val_to_struct[tclass - 1];
 	common_dat = tclass_dat->comdatum;
 
 	/* init permission_names */
@@ -571,14 +571,14 @@ static void type_attribute_bounds_av(struct context *scontext,
 	struct type_datum *target;
 	u32 masked = 0;
 
-	source = flex_array_get_ptr(policydb.type_val_to_struct_array,
+	source = flex_array_get_ptr(crm->policydb.type_val_to_struct_array,
 				    scontext->type - 1);
 	BUG_ON(!source);
 
 	if (!source->bounds)
 		return;
 
-	target = flex_array_get_ptr(policydb.type_val_to_struct_array,
+	target = flex_array_get_ptr(crm->policydb.type_val_to_struct_array,
 				    tcontext->type - 1);
 	BUG_ON(!target);
 
@@ -664,13 +664,13 @@ static void context_struct_compute_av(struct context *scontext,
 		xperms->len = 0;
 	}
 
-	if (unlikely(!tclass || tclass > policydb.p_classes.nprim)) {
+	if (unlikely(!tclass || tclass > crm->policydb.p_classes.nprim)) {
 		if (printk_ratelimit())
 			printk(KERN_WARNING "SELinux:  Invalid class %hu\n", tclass);
 		return;
 	}
 
-	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+	tclass_datum = crm->policydb.class_val_to_struct[tclass - 1];
 
 	/*
 	 * If a specific type enforcement rule was defined for
@@ -678,15 +678,18 @@ static void context_struct_compute_av(struct context *scontext,
 	 */
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_AV | AVTAB_XPERMS;
-	sattr = flex_array_get(policydb.type_attr_map_array, scontext->type - 1);
+	sattr = flex_array_get(crm->policydb.type_attr_map_array,
+			       scontext->type - 1);
 	BUG_ON(!sattr);
-	tattr = flex_array_get(policydb.type_attr_map_array, tcontext->type - 1);
+	tattr = flex_array_get(crm->policydb.type_attr_map_array,
+			       tcontext->type - 1);
 	BUG_ON(!tattr);
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
-			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
+			for (node = avtab_search_node(&crm->policydb.te_avtab,
+						      &avkey);
 			     node;
 			     node = avtab_search_node_next(node, avkey.specified)) {
 				if (node->key.specified == AVTAB_ALLOWED)
@@ -700,7 +703,7 @@ static void context_struct_compute_av(struct context *scontext,
 			}
 
 			/* Check conditional av table for additional permissions */
-			cond_compute_av(&policydb.te_cond_avtab, &avkey,
+			cond_compute_av(&crm->policydb.te_cond_avtab, &avkey,
 					avd, xperms);
 
 		}
@@ -725,16 +728,16 @@ static void context_struct_compute_av(struct context *scontext,
 	 * role is changing, then check the (current_role, new_role)
 	 * pair.
 	 */
-	if (tclass == policydb.process_class &&
-	    (avd->allowed & policydb.process_trans_perms) &&
+	if (tclass == crm->policydb.process_class &&
+	    (avd->allowed & crm->policydb.process_trans_perms) &&
 	    scontext->role != tcontext->role) {
-		for (ra = policydb.role_allow; ra; ra = ra->next) {
+		for (ra = crm->policydb.role_allow; ra; ra = ra->next) {
 			if (scontext->role == ra->role &&
 			    tcontext->role == ra->new_role)
 				break;
 		}
 		if (!ra)
-			avd->allowed &= ~policydb.process_trans_perms;
+			avd->allowed &= ~crm->policydb.process_trans_perms;
 	}
 
 	/*
@@ -763,7 +766,7 @@ static int security_validtrans_handle_fail(struct context *ocontext,
 	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
 		  "op=security_validate_transition seresult=denied"
 		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
-		  o, n, t, sym_name(&policydb, SYM_CLASSES, tclass-1));
+		  o, n, t, sym_name(&crm->policydb, SYM_CLASSES, tclass-1));
 out:
 	kfree(o);
 	kfree(n);
@@ -795,11 +798,11 @@ static int security_compute_validatetrans(u32 oldsid, u32 newsid, u32 tasksid,
 	else
 		tclass = orig_tclass;
 
-	if (!tclass || tclass > policydb.p_classes.nprim) {
+	if (!tclass || tclass > crm->policydb.p_classes.nprim) {
 		rc = -EINVAL;
 		goto out;
 	}
-	tclass_datum = policydb.class_val_to_struct[tclass - 1];
+	tclass_datum = crm->policydb.class_val_to_struct[tclass - 1];
 
 	ocontext = sidtab_search(&sidtab, oldsid);
 	if (!ocontext) {
@@ -901,7 +904,7 @@ int security_bounded_transition(u32 old_sid, u32 new_sid)
 
 	index = new_context->type;
 	while (true) {
-		type = flex_array_get_ptr(policydb.type_val_to_struct_array,
+		type = flex_array_get_ptr(crm->policydb.type_val_to_struct_array,
 					  index - 1);
 		BUG_ON(!type);
 
@@ -1046,35 +1049,36 @@ void security_compute_xperms_decision(u32 ssid,
 
 	tclass = unmap_class(orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
-		if (policydb.allow_unknown)
+		if (crm->policydb.allow_unknown)
 			goto allow;
 		goto out;
 	}
 
 
-	if (unlikely(!tclass || tclass > policydb.p_classes.nprim)) {
+	if (unlikely(!tclass || tclass > crm->policydb.p_classes.nprim)) {
 		pr_warn_ratelimited("SELinux:  Invalid class %hu\n", tclass);
 		goto out;
 	}
 
 	avkey.target_class = tclass;
 	avkey.specified = AVTAB_XPERMS;
-	sattr = flex_array_get(policydb.type_attr_map_array,
+	sattr = flex_array_get(crm->policydb.type_attr_map_array,
 				scontext->type - 1);
 	BUG_ON(!sattr);
-	tattr = flex_array_get(policydb.type_attr_map_array,
+	tattr = flex_array_get(crm->policydb.type_attr_map_array,
 				tcontext->type - 1);
 	BUG_ON(!tattr);
 	ebitmap_for_each_positive_bit(sattr, snode, i) {
 		ebitmap_for_each_positive_bit(tattr, tnode, j) {
 			avkey.source_type = i + 1;
 			avkey.target_type = j + 1;
-			for (node = avtab_search_node(&policydb.te_avtab, &avkey);
+			for (node = avtab_search_node(&crm->policydb.te_avtab,
+						      &avkey);
 			     node;
 			     node = avtab_search_node_next(node, avkey.specified))
 				services_compute_xperms_decision(xpermd, node);
 
-			cond_compute_xperms(&policydb.te_cond_avtab,
+			cond_compute_xperms(&crm->policydb.te_cond_avtab,
 						&avkey, xpermd);
 		}
 	}
@@ -1120,7 +1124,7 @@ void security_compute_av(u32 ssid,
 	}
 
 	/* permissive domain? */
-	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
+	if (ebitmap_get_bit(&crm->policydb.permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
 	tcontext = sidtab_search(&sidtab, tsid);
@@ -1132,12 +1136,12 @@ void security_compute_av(u32 ssid,
 
 	tclass = unmap_class(orig_tclass);
 	if (unlikely(orig_tclass && !tclass)) {
-		if (policydb.allow_unknown)
+		if (crm->policydb.allow_unknown)
 			goto allow;
 		goto out;
 	}
 	context_struct_compute_av(scontext, tcontext, tclass, avd, xperms);
-	map_decision(orig_tclass, avd, policydb.allow_unknown);
+	map_decision(orig_tclass, avd, crm->policydb.allow_unknown);
 out:
 	read_unlock(&policy_rwlock);
 	return;
@@ -1166,7 +1170,7 @@ void security_compute_av_user(u32 ssid,
 	}
 
 	/* permissive domain? */
-	if (ebitmap_get_bit(&policydb.permissive_map, scontext->type))
+	if (ebitmap_get_bit(&crm->policydb.permissive_map, scontext->type))
 		avd->flags |= AVD_FLAGS_PERMISSIVE;
 
 	tcontext = sidtab_search(&sidtab, tsid);
@@ -1177,7 +1181,7 @@ void security_compute_av_user(u32 ssid,
 	}
 
 	if (unlikely(!tclass)) {
-		if (policydb.allow_unknown)
+		if (crm->policydb.allow_unknown)
 			goto allow;
 		goto out;
 	}
@@ -1217,10 +1221,13 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 	}
 
 	/* Compute the size of the context. */
-	*scontext_len += strlen(sym_name(&policydb, SYM_USERS, context->user - 1)) + 1;
-	*scontext_len += strlen(sym_name(&policydb, SYM_ROLES, context->role - 1)) + 1;
-	*scontext_len += strlen(sym_name(&policydb, SYM_TYPES, context->type - 1)) + 1;
-	*scontext_len += mls_compute_context_len(&policydb, context);
+	*scontext_len += strlen(sym_name(&crm->policydb, SYM_USERS,
+					 context->user - 1)) + 1;
+	*scontext_len += strlen(sym_name(&crm->policydb, SYM_ROLES,
+					 context->role - 1)) + 1;
+	*scontext_len += strlen(sym_name(&crm->policydb, SYM_TYPES,
+					 context->type - 1)) + 1;
+	*scontext_len += mls_compute_context_len(&crm->policydb, context);
 
 	if (!scontext)
 		return 0;
@@ -1235,11 +1242,11 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 	 * Copy the user name, role name and type name into the context.
 	 */
 	scontextp += sprintf(scontextp, "%s:%s:%s",
-		sym_name(&policydb, SYM_USERS, context->user - 1),
-		sym_name(&policydb, SYM_ROLES, context->role - 1),
-		sym_name(&policydb, SYM_TYPES, context->type - 1));
+		sym_name(&crm->policydb, SYM_USERS, context->user - 1),
+		sym_name(&crm->policydb, SYM_ROLES, context->role - 1),
+		sym_name(&crm->policydb, SYM_TYPES, context->type - 1));
 
-	mls_sid_to_context(&policydb, context, &scontextp);
+	mls_sid_to_context(&crm->policydb, context, &scontextp);
 
 	*scontextp = 0;
 
@@ -1452,7 +1459,7 @@ static int security_context_to_sid_core(const char *scontext, u32 scontext_len,
 	}
 
 	read_lock(&policy_rwlock);
-	rc = string_to_context_struct(&policydb, &sidtab, scontext2,
+	rc = string_to_context_struct(&crm->policydb, &sidtab, scontext2,
 				      scontext_len, &context, def_sid);
 	if (rc == -EINVAL && force) {
 		context.str = str;
@@ -1546,7 +1553,7 @@ static int compute_sid_handle_invalid_context(
 		  " scontext=%s"
 		  " tcontext=%s"
 		  " tclass=%s",
-		  n, s, t, sym_name(&policydb, SYM_CLASSES, tclass-1));
+		  n, s, t, sym_name(&crm->policydb, SYM_CLASSES, tclass-1));
 out:
 	kfree(s);
 	kfree(t);
@@ -1638,8 +1645,8 @@ static int security_compute_sid(u32 ssid,
 		goto out_unlock;
 	}
 
-	if (tclass && tclass <= policydb.p_classes.nprim)
-		cladatum = policydb.class_val_to_struct[tclass - 1];
+	if (tclass && tclass <= crm->policydb.p_classes.nprim)
+		cladatum = crm->policydb.class_val_to_struct[tclass - 1];
 
 	/* Set the user identity. */
 	switch (specified) {
@@ -1665,7 +1672,7 @@ static int security_compute_sid(u32 ssid,
 	} else if (cladatum && cladatum->default_role == DEFAULT_TARGET) {
 		newcontext.role = tcontext->role;
 	} else {
-		if ((tclass == policydb.process_class) || (sock == true))
+		if ((tclass == crm->policydb.process_class) || (sock == true))
 			newcontext.role = scontext->role;
 		else
 			newcontext.role = OBJECT_R_VAL;
@@ -1677,7 +1684,8 @@ static int security_compute_sid(u32 ssid,
 	} else if (cladatum && cladatum->default_type == DEFAULT_TARGET) {
 		newcontext.type = tcontext->type;
 	} else {
-		if ((tclass == policydb.process_class) || (sock == true)) {
+		if ((tclass == crm->policydb.process_class) ||
+		    (sock == true)) {
 			/* Use the type of process. */
 			newcontext.type = scontext->type;
 		} else {
@@ -1691,11 +1699,12 @@ static int security_compute_sid(u32 ssid,
 	avkey.target_type = tcontext->type;
 	avkey.target_class = tclass;
 	avkey.specified = specified;
-	avdatum = avtab_search(&policydb.te_avtab, &avkey);
+	avdatum = avtab_search(&crm->policydb.te_avtab, &avkey);
 
 	/* If no permanent rule, also check for enabled conditional rules */
 	if (!avdatum) {
-		node = avtab_search_node(&policydb.te_cond_avtab, &avkey);
+		node = avtab_search_node(&crm->policydb.te_cond_avtab,
+					 &avkey);
 		for (; node; node = avtab_search_node_next(node, specified)) {
 			if (node->key.specified & AVTAB_ENABLED) {
 				avdatum = &node->datum;
@@ -1711,13 +1720,16 @@ static int security_compute_sid(u32 ssid,
 
 	/* if we have a objname this is a file trans check so check those rules */
 	if (objname)
-		filename_compute_type(&policydb, &newcontext, scontext->type,
-				      tcontext->type, tclass, objname);
+		filename_compute_type(&crm->policydb, &newcontext,
+				      scontext->type, tcontext->type,
+				      tclass, objname);
 
 	/* Check for class-specific changes. */
 	if (specified & AVTAB_TRANSITION) {
 		/* Look for a role transition rule. */
-		for (roletr = policydb.role_tr; roletr; roletr = roletr->next) {
+		for (roletr = crm->policydb.role_tr;
+		     roletr;
+		     roletr = roletr->next) {
 			if ((roletr->role == scontext->role) &&
 			    (roletr->type == tcontext->type) &&
 			    (roletr->tclass == tclass)) {
@@ -1730,13 +1742,13 @@ static int security_compute_sid(u32 ssid,
 
 	/* Set the MLS attributes.
 	   This is done last because it may allocate memory. */
-	rc = mls_compute_sid(&policydb, scontext, tcontext, tclass, specified,
-			     &newcontext, sock);
+	rc = mls_compute_sid(&crm->policydb, scontext, tcontext, tclass,
+			     specified, &newcontext, sock);
 	if (rc)
 		goto out_unlock;
 
 	/* Check the validity of the context. */
-	if (!policydb_context_isvalid(&policydb, &newcontext)) {
+	if (!policydb_context_isvalid(&crm->policydb, &newcontext)) {
 		rc = compute_sid_handle_invalid_context(scontext,
 							tcontext,
 							tclass,
@@ -1944,7 +1956,8 @@ static int convert_context(u32 key,
 
 	/* Convert the MLS fields if dealing with MLS policies */
 	if (args->oldp->mls_enabled && args->newp->mls_enabled) {
-		rc = mls_convert_context(&policydb, args->oldp, args->newp, c);
+		rc = mls_convert_context(&crm->policydb, args->oldp,
+					 args->newp, c);
 		if (rc)
 			goto bad;
 	} else if (args->oldp->mls_enabled && !args->newp->mls_enabled) {
@@ -2009,27 +2022,31 @@ static void security_load_policycaps(void)
 	unsigned int i;
 	struct ebitmap_node *node;
 
-	selinux_policycap_netpeer = ebitmap_get_bit(&policydb.policycaps,
-						  POLICYDB_CAPABILITY_NETPEER);
-	selinux_policycap_openperm = ebitmap_get_bit(&policydb.policycaps,
-						  POLICYDB_CAPABILITY_OPENPERM);
-	selinux_policycap_extsockclass = ebitmap_get_bit(&policydb.policycaps,
-					  POLICYDB_CAPABILITY_EXTSOCKCLASS);
-	selinux_policycap_alwaysnetwork = ebitmap_get_bit(&policydb.policycaps,
-						  POLICYDB_CAPABILITY_ALWAYSNETWORK);
+	selinux_policycap_netpeer =
+		ebitmap_get_bit(&crm->policydb.policycaps,
+			  POLICYDB_CAPABILITY_NETPEER);
+	selinux_policycap_openperm =
+		ebitmap_get_bit(&crm->policydb.policycaps,
+				POLICYDB_CAPABILITY_OPENPERM);
+	selinux_policycap_extsockclass =
+		ebitmap_get_bit(&crm->policydb.policycaps,
+				POLICYDB_CAPABILITY_EXTSOCKCLASS);
+	selinux_policycap_alwaysnetwork =
+		ebitmap_get_bit(&crm->policydb.policycaps,
+				POLICYDB_CAPABILITY_ALWAYSNETWORK);
 	selinux_policycap_cgroupseclabel =
-		ebitmap_get_bit(&policydb.policycaps,
+		ebitmap_get_bit(&crm->policydb.policycaps,
 				POLICYDB_CAPABILITY_CGROUPSECLABEL);
 	selinux_policycap_nnp_nosuid_transition =
-		ebitmap_get_bit(&policydb.policycaps,
+		ebitmap_get_bit(&crm->policydb.policycaps,
 				POLICYDB_CAPABILITY_NNP_NOSUID_TRANSITION);
 
 	for (i = 0; i < ARRAY_SIZE(selinux_policycap_names); i++)
 		pr_info("SELinux:  policy capability %s=%d\n",
 			selinux_policycap_names[i],
-			ebitmap_get_bit(&policydb.policycaps, i));
+			ebitmap_get_bit(&crm->policydb.policycaps, i));
 
-	ebitmap_for_each_positive_bit(&policydb.policycaps, node, i) {
+	ebitmap_for_each_positive_bit(&crm->policydb.policycaps, node, i) {
 		if (i >= ARRAY_SIZE(selinux_policycap_names))
 			pr_info("SELinux:  unknown policy capability %u\n",
 				i);
@@ -2084,7 +2101,7 @@ int security_load_policy(void *data, size_t len)
 		avtab_cache_init();
 		ebitmap_cache_init();
 		hashtab_cache_init();
-		rc = policydb_read(&policydb, fp);
+		rc = policydb_read(&crm->policydb, fp);
 		if (rc) {
 			avtab_cache_destroy();
 			ebitmap_cache_destroy();
@@ -2092,21 +2109,21 @@ int security_load_policy(void *data, size_t len)
 			goto out;
 		}
 
-		policydb.len = len;
-		rc = selinux_set_mapping(&policydb, secclass_map,
+		crm->policydb.len = len;
+		rc = selinux_set_mapping(&crm->policydb, secclass_map,
 					 &crm->current_mapping,
 					 &crm->current_mapping_size);
 		if (rc) {
-			policydb_destroy(&policydb);
+			policydb_destroy(&crm->policydb);
 			avtab_cache_destroy();
 			ebitmap_cache_destroy();
 			hashtab_cache_destroy();
 			goto out;
 		}
 
-		rc = policydb_load_isids(&policydb, &sidtab);
+		rc = policydb_load_isids(&crm->policydb, &sidtab);
 		if (rc) {
-			policydb_destroy(&policydb);
+			policydb_destroy(&crm->policydb);
 			avtab_cache_destroy();
 			ebitmap_cache_destroy();
 			hashtab_cache_destroy();
@@ -2135,9 +2152,9 @@ int security_load_policy(void *data, size_t len)
 
 	newpolicydb->len = len;
 	/* If switching between different policy types, log MLS status */
-	if (policydb.mls_enabled && !newpolicydb->mls_enabled)
+	if (crm->policydb.mls_enabled && !newpolicydb->mls_enabled)
 		printk(KERN_INFO "SELinux: Disabling MLS support...\n");
-	else if (!policydb.mls_enabled && newpolicydb->mls_enabled)
+	else if (!crm->policydb.mls_enabled && newpolicydb->mls_enabled)
 		printk(KERN_INFO "SELinux: Enabling MLS support...\n");
 
 	rc = policydb_load_isids(newpolicydb, &newsidtab);
@@ -2168,7 +2185,7 @@ int security_load_policy(void *data, size_t len)
 	 * Convert the internal representations of contexts
 	 * in the new SID table.
 	 */
-	args.oldp = &policydb;
+	args.oldp = &crm->policydb;
 	args.newp = newpolicydb;
 	rc = sidtab_map(&newsidtab, convert_context, &args);
 	if (rc) {
@@ -2179,12 +2196,13 @@ int security_load_policy(void *data, size_t len)
 	}
 
 	/* Save the old policydb and SID table to free later. */
-	memcpy(oldpolicydb, &policydb, sizeof(policydb));
+	memcpy(oldpolicydb, &crm->policydb, sizeof(struct policydb));
 	sidtab_set(&oldsidtab, &sidtab);
 
 	/* Install the new policydb and SID table. */
 	write_lock_irq(&policy_rwlock);
-	memcpy(&policydb, newpolicydb, sizeof(policydb));
+	memcpy(&crm->policydb, newpolicydb, sizeof(struct policydb));
+
 	sidtab_set(&sidtab, &newsidtab);
 	security_load_policycaps();
 	oldmap = crm->current_mapping;
@@ -2222,7 +2240,7 @@ size_t security_policydb_len(void)
 	size_t len;
 
 	read_lock(&policy_rwlock);
-	len = policydb.len;
+	len = crm->policydb.len;
 	read_unlock(&policy_rwlock);
 
 	return len;
@@ -2241,7 +2259,7 @@ int security_port_sid(u8 protocol, u16 port, u32 *out_sid)
 
 	read_lock(&policy_rwlock);
 
-	c = policydb.ocontexts[OCON_PORT];
+	c = crm->policydb.ocontexts[OCON_PORT];
 	while (c) {
 		if (c->u.port.protocol == protocol &&
 		    c->u.port.low_port <= port &&
@@ -2281,7 +2299,7 @@ int security_ib_pkey_sid(u64 subnet_prefix, u16 pkey_num, u32 *out_sid)
 
 	read_lock(&policy_rwlock);
 
-	c = policydb.ocontexts[OCON_IBPKEY];
+	c = crm->policydb.ocontexts[OCON_IBPKEY];
 	while (c) {
 		if (c->u.ibpkey.low_pkey <= pkey_num &&
 		    c->u.ibpkey.high_pkey >= pkey_num &&
@@ -2321,7 +2339,7 @@ int security_ib_endport_sid(const char *dev_name, u8 port_num, u32 *out_sid)
 
 	read_lock(&policy_rwlock);
 
-	c = policydb.ocontexts[OCON_IBENDPORT];
+	c = crm->policydb.ocontexts[OCON_IBENDPORT];
 	while (c) {
 		if (c->u.ibendport.port == port_num &&
 		    !strncmp(c->u.ibendport.dev_name,
@@ -2361,7 +2379,7 @@ int security_netif_sid(char *name, u32 *if_sid)
 
 	read_lock(&policy_rwlock);
 
-	c = policydb.ocontexts[OCON_NETIF];
+	c = crm->policydb.ocontexts[OCON_NETIF];
 	while (c) {
 		if (strcmp(name, c->u.name) == 0)
 			break;
@@ -2430,7 +2448,7 @@ int security_node_sid(u16 domain,
 
 		addr = *((u32 *)addrp);
 
-		c = policydb.ocontexts[OCON_NODE];
+		c = crm->policydb.ocontexts[OCON_NODE];
 		while (c) {
 			if (c->u.node.addr == (addr & c->u.node.mask))
 				break;
@@ -2443,7 +2461,7 @@ int security_node_sid(u16 domain,
 		rc = -EINVAL;
 		if (addrlen != sizeof(u64) * 2)
 			goto out;
-		c = policydb.ocontexts[OCON_NODE6];
+		c = crm->policydb.ocontexts[OCON_NODE6];
 		while (c) {
 			if (match_ipv6_addrmask(addrp, c->u.node6.addr,
 						c->u.node6.mask))
@@ -2522,7 +2540,7 @@ int security_get_user_sids(u32 fromsid,
 		goto out_unlock;
 
 	rc = -EINVAL;
-	user = hashtab_search(policydb.p_users.table, username);
+	user = hashtab_search(crm->policydb.p_users.table, username);
 	if (!user)
 		goto out_unlock;
 
@@ -2534,12 +2552,12 @@ int security_get_user_sids(u32 fromsid,
 		goto out_unlock;
 
 	ebitmap_for_each_positive_bit(&user->roles, rnode, i) {
-		role = policydb.role_val_to_struct[i];
+		role = crm->policydb.role_val_to_struct[i];
 		usercon.role = i + 1;
 		ebitmap_for_each_positive_bit(&role->types, tnode, j) {
 			usercon.type = j + 1;
 
-			if (mls_setup_user_range(&policydb, fromcon,
+			if (mls_setup_user_range(&crm->policydb, fromcon,
 						 user, &usercon))
 				continue;
 
@@ -2623,7 +2641,7 @@ static inline int __security_genfs_sid(const char *fstype,
 	sclass = unmap_class(orig_sclass);
 	*sid = SECINITSID_UNLABELED;
 
-	for (genfs = policydb.genfs; genfs; genfs = genfs->next) {
+	for (genfs = crm->policydb.genfs; genfs; genfs = genfs->next) {
 		cmp = strcmp(fstype, genfs->fstype);
 		if (cmp <= 0)
 			break;
@@ -2692,7 +2710,7 @@ int security_fs_use(struct super_block *sb)
 
 	read_lock(&policy_rwlock);
 
-	c = policydb.ocontexts[OCON_FSUSE];
+	c = crm->policydb.ocontexts[OCON_FSUSE];
 	while (c) {
 		if (strcmp(fstype, c->u.name) == 0)
 			break;
@@ -2733,7 +2751,7 @@ int security_get_bools(int *len, char ***names, int **values)
 	*values = NULL;
 
 	rc = 0;
-	*len = policydb.p_bools.nprim;
+	*len = crm->policydb.p_bools.nprim;
 	if (!*len)
 		goto out;
 
@@ -2748,10 +2766,11 @@ int security_get_bools(int *len, char ***names, int **values)
 		goto err;
 
 	for (i = 0; i < *len; i++) {
-		(*values)[i] = policydb.bool_val_to_struct[i]->state;
+		(*values)[i] = crm->policydb.bool_val_to_struct[i]->state;
 
 		rc = -ENOMEM;
-		(*names)[i] = kstrdup(sym_name(&policydb, SYM_BOOLS, i), GFP_ATOMIC);
+		(*names)[i] = kstrdup(sym_name(&crm->policydb, SYM_BOOLS, i),
+				      GFP_ATOMIC);
 		if (!(*names)[i])
 			goto err;
 	}
@@ -2778,29 +2797,30 @@ int security_set_bools(int len, int *values)
 	write_lock_irq(&policy_rwlock);
 
 	rc = -EFAULT;
-	lenp = policydb.p_bools.nprim;
+	lenp = crm->policydb.p_bools.nprim;
 	if (len != lenp)
 		goto out;
 
 	for (i = 0; i < len; i++) {
-		if (!!values[i] != policydb.bool_val_to_struct[i]->state) {
+		if (!!values[i] !=
+		    crm->policydb.bool_val_to_struct[i]->state) {
 			audit_log(current->audit_context, GFP_ATOMIC,
 				AUDIT_MAC_CONFIG_CHANGE,
 				"bool=%s val=%d old_val=%d auid=%u ses=%u",
-				sym_name(&policydb, SYM_BOOLS, i),
+				sym_name(&crm->policydb, SYM_BOOLS, i),
 				!!values[i],
-				policydb.bool_val_to_struct[i]->state,
+				crm->policydb.bool_val_to_struct[i]->state,
 				from_kuid(&init_user_ns, audit_get_loginuid(current)),
 				audit_get_sessionid(current));
 		}
 		if (values[i])
-			policydb.bool_val_to_struct[i]->state = 1;
+			crm->policydb.bool_val_to_struct[i]->state = 1;
 		else
-			policydb.bool_val_to_struct[i]->state = 0;
+			crm->policydb.bool_val_to_struct[i]->state = 0;
 	}
 
-	for (cur = policydb.cond_list; cur; cur = cur->next) {
-		rc = evaluate_cond_node(&policydb, cur);
+	for (cur = crm->policydb.cond_list; cur; cur = cur->next) {
+		rc = evaluate_cond_node(&crm->policydb, cur);
 		if (rc)
 			goto out;
 	}
@@ -2826,11 +2846,11 @@ int security_get_bool_value(int index)
 	read_lock(&policy_rwlock);
 
 	rc = -EFAULT;
-	len = policydb.p_bools.nprim;
+	len = crm->policydb.p_bools.nprim;
 	if (index >= len)
 		goto out;
 
-	rc = policydb.bool_val_to_struct[index]->state;
+	rc = crm->policydb.bool_val_to_struct[index]->state;
 out:
 	read_unlock(&policy_rwlock);
 	return rc;
@@ -2881,7 +2901,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 	int rc;
 
 	rc = 0;
-	if (!ss_initialized || !policydb.mls_enabled) {
+	if (!ss_initialized || !crm->policydb.mls_enabled) {
 		*new_sid = sid;
 		goto out;
 	}
@@ -2914,7 +2934,7 @@ int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid)
 		goto out_unlock;
 
 	/* Check the validity of the new context. */
-	if (!policydb_context_isvalid(&policydb, &newcon)) {
+	if (!policydb_context_isvalid(&crm->policydb, &newcon)) {
 		rc = convert_context_handle_invalid_context(&newcon);
 		if (rc) {
 			if (!context_struct_to_string(&newcon, &s, &len)) {
@@ -2984,7 +3004,7 @@ int security_net_peersid_resolve(u32 nlbl_sid, u32 nlbl_type,
 	/* we don't need to check ss_initialized here since the only way both
 	 * nlbl_sid and xfrm_sid are not equal to SECSID_NULL would be if the
 	 * security server was initialized and ss_initialized was true */
-	if (!policydb.mls_enabled)
+	if (!crm->policydb.mls_enabled)
 		return 0;
 
 	read_lock(&policy_rwlock);
@@ -3038,12 +3058,12 @@ int security_get_classes(char ***classes, int *nclasses)
 	read_lock(&policy_rwlock);
 
 	rc = -ENOMEM;
-	*nclasses = policydb.p_classes.nprim;
+	*nclasses = crm->policydb.p_classes.nprim;
 	*classes = kcalloc(*nclasses, sizeof(**classes), GFP_ATOMIC);
 	if (!*classes)
 		goto out;
 
-	rc = hashtab_map(policydb.p_classes.table, get_classes_callback,
+	rc = hashtab_map(crm->policydb.p_classes.table, get_classes_callback,
 			*classes);
 	if (rc) {
 		int i;
@@ -3078,7 +3098,7 @@ int security_get_permissions(char *class, char ***perms, int *nperms)
 	read_lock(&policy_rwlock);
 
 	rc = -EINVAL;
-	match = hashtab_search(policydb.p_classes.table, class);
+	match = hashtab_search(crm->policydb.p_classes.table, class);
 	if (!match) {
 		printk(KERN_ERR "SELinux: %s:  unrecognized class %s\n",
 			__func__, class);
@@ -3117,12 +3137,12 @@ int security_get_permissions(char *class, char ***perms, int *nperms)
 
 int security_get_reject_unknown(void)
 {
-	return policydb.reject_unknown;
+	return crm->policydb.reject_unknown;
 }
 
 int security_get_allow_unknown(void)
 {
-	return policydb.allow_unknown;
+	return crm->policydb.allow_unknown;
 }
 
 /**
@@ -3140,7 +3160,7 @@ int security_policycap_supported(unsigned int req_cap)
 	int rc;
 
 	read_lock(&policy_rwlock);
-	rc = ebitmap_get_bit(&policydb.policycaps, req_cap);
+	rc = ebitmap_get_bit(&crm->policydb.policycaps, req_cap);
 	read_unlock(&policy_rwlock);
 
 	return rc;
@@ -3213,7 +3233,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_USER:
 	case AUDIT_OBJ_USER:
 		rc = -EINVAL;
-		userdatum = hashtab_search(policydb.p_users.table, rulestr);
+		userdatum = hashtab_search(crm->policydb.p_users.table,
+					   rulestr);
 		if (!userdatum)
 			goto out;
 		tmprule->au_ctxt.user = userdatum->value;
@@ -3221,7 +3242,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_ROLE:
 	case AUDIT_OBJ_ROLE:
 		rc = -EINVAL;
-		roledatum = hashtab_search(policydb.p_roles.table, rulestr);
+		roledatum = hashtab_search(crm->policydb.p_roles.table,
+					   rulestr);
 		if (!roledatum)
 			goto out;
 		tmprule->au_ctxt.role = roledatum->value;
@@ -3229,7 +3251,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_TYPE:
 	case AUDIT_OBJ_TYPE:
 		rc = -EINVAL;
-		typedatum = hashtab_search(policydb.p_types.table, rulestr);
+		typedatum = hashtab_search(crm->policydb.p_types.table,
+					   rulestr);
 		if (!typedatum)
 			goto out;
 		tmprule->au_ctxt.type = typedatum->value;
@@ -3238,8 +3261,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr, void **vrule)
 	case AUDIT_SUBJ_CLR:
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
-		rc = mls_from_string(&policydb, rulestr, &tmprule->au_ctxt,
-				     GFP_ATOMIC);
+		rc = mls_from_string(&crm->policydb, rulestr,
+				     &tmprule->au_ctxt, GFP_ATOMIC);
 		if (rc)
 			goto out;
 		break;
@@ -3489,15 +3512,15 @@ int security_netlbl_secattr_to_sid(struct netlbl_lsm_secattr *secattr,
 		ctx_new.user = ctx->user;
 		ctx_new.role = ctx->role;
 		ctx_new.type = ctx->type;
-		mls_import_netlbl_lvl(&policydb, &ctx_new, secattr);
+		mls_import_netlbl_lvl(&crm->policydb, &ctx_new, secattr);
 		if (secattr->flags & NETLBL_SECATTR_MLS_CAT) {
-			rc = mls_import_netlbl_cat(&policydb, &ctx_new,
+			rc = mls_import_netlbl_cat(&crm->policydb, &ctx_new,
 						   secattr);
 			if (rc)
 				goto out;
 		}
 		rc = -EIDRM;
-		if (!mls_context_isvalid(&policydb, &ctx_new))
+		if (!mls_context_isvalid(&crm->policydb, &ctx_new))
 			goto out_free;
 
 		rc = sidtab_context_to_sid(&sidtab, &ctx_new, sid);
@@ -3545,15 +3568,16 @@ int security_netlbl_sid_to_secattr(u32 sid, struct netlbl_lsm_secattr *secattr)
 		goto out;
 
 	rc = -ENOMEM;
-	secattr->domain = kstrdup(sym_name(&policydb, SYM_TYPES, ctx->type - 1),
+	secattr->domain = kstrdup(sym_name(&crm->policydb,
+					   SYM_TYPES, ctx->type - 1),
 				  GFP_ATOMIC);
 	if (secattr->domain == NULL)
 		goto out;
 
 	secattr->attr.secid = sid;
 	secattr->flags |= NETLBL_SECATTR_DOMAIN_CPY | NETLBL_SECATTR_SECID;
-	mls_export_netlbl_lvl(&policydb, ctx, secattr);
-	rc = mls_export_netlbl_cat(&policydb, ctx, secattr);
+	mls_export_netlbl_lvl(&crm->policydb, ctx, secattr);
+	rc = mls_export_netlbl_cat(&crm->policydb, ctx, secattr);
 out:
 	read_unlock(&policy_rwlock);
 	return rc;
@@ -3584,7 +3608,7 @@ int security_read_policy(void **data, size_t *len)
 	fp.len = *len;
 
 	read_lock(&policy_rwlock);
-	rc = policydb_write(&policydb, &fp);
+	rc = policydb_write(&crm->policydb, &fp);
 	read_unlock(&policy_rwlock);
 
 	if (rc)
-- 
2.7.4
