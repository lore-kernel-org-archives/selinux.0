Message-ID: <44F760E1.7060602@trustedcs.com>
Date: Thu, 31 Aug 2006 17:21:21 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
CC: "'SELinux List'" <SELinux@tycho.nsa.gov>,
        Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Christopher PeBenito <cpebenito@tresys.com>
Subject: [PATCH 3/3 v2] semantic MLS representation for users
References: <44F31951.1070706@trustedcs.com>
In-Reply-To: <44F31951.1070706@trustedcs.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here is a second take on the previous patch.  The changes are:
- no longer create semantic representation of user MLS fields when
  reading in a kernel format policy
- no longer copy the semantic representation of user MLS fields
  when expanding users
- no longer deal attempt to expand the semantic MLS components when
  caching user information if the policy is already in kernel format
  (the semantic info is no longer there)

---

Use the semantic representation for user_datums in modular policy formats.

All user_datums in a modular format use the semantic representation of the MLS
range and dfltlevel.  There is also the possibility of having an expanded
version of that data also present in the user_datum.  This is used much like
the role cache in the user_datum.  When the user are indexed, the MLS info is
expanded.  This info may be used to check the validity of context.  This
expansion is not used when writing out a kernel format policy - the expansion
is performed again to ensure that the data it is present and in sync with the
rest of the policy.

Like the range_trans structs, user_datums from older modular formats will have
their MLS data converted to the new semantic structs.


Signed-off-by:  Darrel Goeddel <dgoeddel@trustedcs.com>


 checkpolicy/policy_parse.y                 |   37 +++--------------
 libsepol/include/sepol/policydb/policydb.h |    9 ++--
 libsepol/src/expand.c                      |   63 +++++++++++++++++++++++------
 libsepol/src/mls.c                         |    8 +--
 libsepol/src/policydb.c                    |   62 +++++++++++++++++++++++-----
 libsepol/src/users.c                       |   13 ++---
 libsepol/src/write.c                       |   17 +++++--
 7 files changed, 137 insertions(+), 72 deletions(-)


diff --exclude=.svn -ruNp selinux-rangetrans-2/checkpolicy/policy_parse.y selinux-mls-users-2/checkpolicy/policy_parse.y
--- selinux-rangetrans-2/checkpolicy/policy_parse.y	2006-08-30 06:23:54.000000000 -0500
+++ selinux-mls-users-2/checkpolicy/policy_parse.y	2006-08-30 11:03:28.000000000 -0500
@@ -3737,11 +3737,10 @@ static int define_user(void)
 		free(id);
 
 		usrdatum->dfltlevel.sens = levdatum->level->sens;
-		ebitmap_init(&usrdatum->dfltlevel.cat);
 
 		while ((id = queue_remove(id_queue))) {
-			if (parse_categories(id, levdatum,
-					     &usrdatum->dfltlevel.cat)) {
+			if (parse_semantic_categories(id, levdatum,
+			                            &usrdatum->dfltlevel.cat)) {
 				free(id);
 				return -1;
 			}
@@ -3763,13 +3762,12 @@ static int define_user(void)
 				return -1;
 			}
 			free(id);
+
 			usrdatum->range.level[l].sens = levdatum->level->sens;
-			ebitmap_init(&usrdatum->range.level[l].cat);
 
 			while ((id = queue_remove(id_queue))) {
-				if (parse_categories(id, levdatum,
-						     &usrdatum->range.level[l].
-						     cat)) {
+				if (parse_semantic_categories(id, levdatum,
+				               &usrdatum->range.level[l].cat)) {
 					free(id);
 					return -1;
 				}
@@ -3782,33 +3780,14 @@ static int define_user(void)
 		}
 
 		if (l == 0) {
-			usrdatum->range.level[1].sens =
-			    usrdatum->range.level[0].sens;
-			if (ebitmap_cpy(&usrdatum->range.level[1].cat,
-					&usrdatum->range.level[0].cat)) {
+			if (mls_semantic_level_cpy(&usrdatum->range.level[1],
+			                           &usrdatum->range.level[0])) {
 				yyerror("out of memory");
-				goto out;
+				return -1;
 			}
 		}
-		if (!mls_level_dom(&usrdatum->range.level[1],
-				   &usrdatum->range.level[0])) {
-			yyerror("high level does not dominate low level");
-			goto out;
-		}
-		if (!mls_level_between(&usrdatum->dfltlevel,
-				       &usrdatum->range.level[0],
-				       &usrdatum->range.level[1])) {
-			yyerror("default level not within user range");
-			goto out;
-		}
 	}
 	return 0;
-
-      out:
-	ebitmap_destroy(&usrdatum->dfltlevel.cat);
-	ebitmap_destroy(&usrdatum->range.level[0].cat);
-	ebitmap_destroy(&usrdatum->range.level[1].cat);
-	return -1;
 }
 
 static int parse_security_context(context_struct_t * c)
diff --exclude=.svn -ruNp selinux-rangetrans-2/libsepol/include/sepol/policydb/policydb.h selinux-mls-users-2/libsepol/include/sepol/policydb/policydb.h
--- selinux-rangetrans-2/libsepol/include/sepol/policydb/policydb.h	2006-08-30 04:38:11.000000000 -0500
+++ selinux-mls-users-2/libsepol/include/sepol/policydb/policydb.h	2006-08-30 11:03:28.000000000 -0500
@@ -149,9 +149,11 @@ typedef struct type_datum {
 typedef struct user_datum {
 	symtab_datum_t s;
 	role_set_t roles;	/* set of authorized roles for user */
-	mls_range_t range;	/* MLS range (min. - max.) for user */
-	mls_level_t dfltlevel;	/* default login MLS level for user */
+	mls_semantic_range_t range;	/* MLS range (min. - max.) for user */
+	mls_semantic_level_t dfltlevel;	/* default login MLS level for user */
 	ebitmap_t cache;	/* This is an expanded set used for context validation during parsing */
+	mls_range_t exp_range;     /* expanded range used for validation */
+	mls_level_t exp_dfltlevel; /* expanded range used for validation */
 } user_datum_t;
 
 /* Sensitivity attributes */
@@ -586,9 +588,10 @@ extern int policydb_write(struct policyd
 #define MOD_POLICYDB_VERSION_VALIDATETRANS 5
 #define MOD_POLICYDB_VERSION_MLS	   5
 #define MOD_POLICYDB_VERSION_RANGETRANS	   6
+#define MOD_POLICYDB_VERSION_MLS_USERS	   6
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_RANGETRANS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_MLS_USERS
 
 #define POLICYDB_CONFIG_MLS    1
 
diff --exclude=.svn -ruNp selinux-rangetrans-2/libsepol/src/expand.c selinux-mls-users-2/libsepol/src/expand.c
--- selinux-rangetrans-2/libsepol/src/expand.c	2006-08-30 14:03:38.000000000 -0500
+++ selinux-mls-users-2/libsepol/src/expand.c	2006-08-31 11:35:14.000000000 -0500
@@ -692,13 +692,46 @@ static int user_copy_callback(hashtab_ke
 			return -1;
 		}
 
-		/* clone MLS stuff */
-		if (mls_range_cpy(&new_user->range, &user->range) == -1
-		    || mls_level_cpy(&new_user->dfltlevel,
-				     &user->dfltlevel) == -1) {
-			ERR(state->handle, "Out of memory!");
+		/* expand the semantic MLS info */
+		if (mls_semantic_range_expand(&user->range,
+					      &new_user->exp_range,
+					      state->out, state->handle)) {
+			return -1;
+		}
+		if (mls_semantic_level_expand(&user->dfltlevel,
+					      &new_user->exp_dfltlevel,
+					      state->out, state->handle)) {
+			return -1;
+		}
+		if (!mls_level_between(&new_user->exp_dfltlevel,
+				       &new_user->exp_range.level[0],
+				       &new_user->exp_range.level[1])) {
+			ERR(state->handle, "default level not within user "
+			    "range");
+			return -1;
+		}
+	} else {
+		/* require that the MLS info match */
+		mls_range_t tmp_range;
+		mls_level_t tmp_level;
+
+		if (mls_semantic_range_expand(&user->range, &tmp_range,
+					      state->out, state->handle)) {
 			return -1;
 		}
+		if (mls_semantic_level_expand(&user->dfltlevel, &tmp_level,
+					      state->out, state->handle)) {
+			mls_range_destroy(&tmp_range);
+			return -1;
+		}
+		if (!mls_range_eq(&new_user->exp_range, &tmp_range) ||
+		    !mls_level_eq(&new_user->exp_dfltlevel, &tmp_level)) {
+			mls_range_destroy(&tmp_range);
+			mls_level_destroy(&tmp_level);
+			return -1;
+		}
+		mls_range_destroy(&tmp_range);
+		mls_level_destroy(&tmp_level);
 	}
 
 	ebitmap_init(&tmp_union);
@@ -788,7 +821,7 @@ static int sens_copy_callback(hashtab_ke
 	}
 
 	if (state->verbose)
-		INFO(state->handle, "copying senitivity level %s", id);
+		INFO(state->handle, "copying sensitivity level %s", id);
 
 	if ((new_level =
 	     (level_datum_t *) calloc(1, sizeof(*new_level))) == NULL
@@ -2207,6 +2240,17 @@ int expand_module(sepol_handle_t * handl
 	if (hashtab_map(state.base->p_roles.table, role_copy_callback, &state))
 		goto cleanup;
 
+	/* copy MLS's sensitivity level and categories - this needs to be done
+	 * before expanding users (they need to be indexed too) */
+	if (hashtab_map(state.base->p_levels.table, sens_copy_callback, &state))
+		goto cleanup;
+	if (hashtab_map(state.base->p_cats.table, cats_copy_callback, &state))
+		goto cleanup;
+	if (policydb_index_others(handle, out, verbose)) {
+		ERR(handle, "Error while indexing out symbols");
+		goto cleanup;
+	}
+
 	/* copy users */
 	if (hashtab_map(state.base->p_users.table, user_copy_callback, &state))
 		goto cleanup;
@@ -2215,13 +2259,6 @@ int expand_module(sepol_handle_t * handl
 	if (hashtab_map(state.base->p_bools.table, bool_copy_callback, &state))
 		goto cleanup;
 
-	/* now copy MLS's sensitivity level and categories */
-	if (hashtab_map(state.base->p_levels.table, sens_copy_callback, &state)
-	    || hashtab_map(state.base->p_cats.table, cats_copy_callback,
-			   &state)) {
-		goto cleanup;
-	}
-
 	if (policydb_index_classes(out)) {
 		ERR(handle, "Error while indexing out classes");
 		goto cleanup;
diff --exclude=.svn -ruNp selinux-rangetrans-2/libsepol/src/mls.c selinux-mls-users-2/libsepol/src/mls.c
--- selinux-rangetrans-2/libsepol/src/mls.c	2006-08-30 11:11:18.000000000 -0500
+++ selinux-mls-users-2/libsepol/src/mls.c	2006-08-31 11:35:14.000000000 -0500
@@ -310,7 +310,7 @@ int mls_context_isvalid(const policydb_t
 	if (!c->user || c->user > p->p_users.nprim)
 		return 0;
 	usrdatum = p->user_val_to_struct[c->user - 1];
-	if (!mls_range_contains(usrdatum->range, c->range))
+	if (!mls_range_contains(usrdatum->exp_range, c->range))
 		return 0;	/* user may not be associated with range */
 
 	return 1;
@@ -512,9 +512,9 @@ int mls_setup_user_range(context_struct_
 	if (mls) {
 		mls_level_t *fromcon_sen = &(fromcon->range.level[0]);
 		mls_level_t *fromcon_clr = &(fromcon->range.level[1]);
-		mls_level_t *user_low = &(user->range.level[0]);
-		mls_level_t *user_clr = &(user->range.level[1]);
-		mls_level_t *user_def = &(user->dfltlevel);
+		mls_level_t *user_low = &(user->exp_range.level[0]);
+		mls_level_t *user_clr = &(user->exp_range.level[1]);
+		mls_level_t *user_def = &(user->exp_dfltlevel);
 		mls_level_t *usercon_sen = &(usercon->range.level[0]);
 		mls_level_t *usercon_clr = &(usercon->range.level[1]);
 
diff --exclude=.svn -ruNp selinux-rangetrans-2/libsepol/src/policydb.c selinux-mls-users-2/libsepol/src/policydb.c
--- selinux-rangetrans-2/libsepol/src/policydb.c	2006-08-30 11:11:18.000000000 -0500
+++ selinux-mls-users-2/libsepol/src/policydb.c	2006-08-31 11:35:14.000000000 -0500
@@ -112,7 +112,7 @@ static struct policydb_compat_info polic
 	 },
 	{
 	 .type = POLICY_BASE,
-	 .version = MOD_POLICYDB_VERSION_RANGETRANS,
+	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
@@ -130,7 +130,7 @@ static struct policydb_compat_info polic
 	 },
 	{
 	 .type = POLICY_MOD,
-	 .version = MOD_POLICYDB_VERSION_RANGETRANS,
+	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
 	 .sym_num = SYM_NUM,
 	 .ocon_num = 0},
 };
@@ -233,18 +233,22 @@ void user_datum_init(user_datum_t * x)
 {
 	memset(x, 0, sizeof(user_datum_t));
 	role_set_init(&x->roles);
-	mls_range_init(&x->range);
-	mls_level_init(&x->dfltlevel);
+	mls_semantic_range_init(&x->range);
+	mls_semantic_level_init(&x->dfltlevel);
 	ebitmap_init(&x->cache);
+	mls_range_init(&x->exp_range);
+	mls_level_init(&x->exp_dfltlevel);
 }
 
 void user_datum_destroy(user_datum_t * x)
 {
 	if (x != NULL) {
 		role_set_destroy(&x->roles);
-		mls_range_destroy(&x->range);
-		mls_level_destroy(&x->dfltlevel);
+		mls_semantic_range_destroy(&x->range);
+		mls_semantic_level_destroy(&x->dfltlevel);
 		ebitmap_destroy(&x->cache);
+		mls_range_destroy(&x->exp_range);
+		mls_level_destroy(&x->exp_dfltlevel);
 	}
 }
 
@@ -498,6 +502,20 @@ int policydb_user_cache(hashtab_key_t ke
 		return -1;
 	}
 
+	if (p->policy_type != POLICY_KERN) {
+		mls_range_destroy(&user->exp_range);
+		if (mls_semantic_range_expand(&user->range,
+					      &user->exp_range, p, NULL)) {
+			return -1;
+		}
+
+		mls_level_destroy(&user->exp_dfltlevel);
+		if (mls_semantic_level_expand(&user->dfltlevel,
+					      &user->exp_dfltlevel, p, NULL)) {
+			return -1;
+		}
+	}
+
 	return 0;
 }
 
@@ -2235,17 +2253,37 @@ static int user_read(policydb_t * p, has
 			goto bad;
 	}
 
-	/* users aren't allowed in mls modules but they can be required, the mls fields will be empty,
-	 * user declarations in non-mls modules will also have empty mls fields */
+	/* users were not allowed in mls modules before version
+	 * MOD_POLICYDB_VERSION_MLS_USERS, but they could have been
+	 * required - the mls fields will be empty.  user declarations in
+	 * non-mls modules will also have empty mls fields */
 	if ((p->policy_type == POLICY_KERN
 	     && p->policyvers >= POLICYDB_VERSION_MLS)
 	    || (p->policy_type == POLICY_MOD
-		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS)
+		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS
+		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS)
 	    || (p->policy_type == POLICY_BASE
-		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS)) {
-		if (mls_read_range_helper(&usrdatum->range, fp))
+		&& p->policyvers >= MOD_POLICYDB_VERSION_MLS
+		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS)) {
+		if (mls_read_range_helper(&usrdatum->exp_range, fp))
+			goto bad;
+		if (mls_read_level(&usrdatum->exp_dfltlevel, fp))
+			goto bad;
+		if (p->policy_type != POLICY_KERN) {
+			if (mls_range_to_semantic(&usrdatum->exp_range,
+						  &usrdatum->range))
+				goto bad;
+			if (mls_level_to_semantic(&usrdatum->exp_dfltlevel,
+						  &usrdatum->dfltlevel))
+				goto bad;
+		}
+	} else if ((p->policy_type == POLICY_MOD
+		    && p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS)
+		   || (p->policy_type == POLICY_BASE
+		       && p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS)) {
+		if (mls_read_semantic_range_helper(&usrdatum->range, fp))
 			goto bad;
-		if (mls_read_level(&usrdatum->dfltlevel, fp))
+		if (mls_read_semantic_level_helper(&usrdatum->dfltlevel, fp))
 			goto bad;
 	}
 
diff --exclude=.svn -ruNp selinux-rangetrans-2/libsepol/src/users.c selinux-mls-users-2/libsepol/src/users.c
--- selinux-rangetrans-2/libsepol/src/users.c	2006-08-30 11:11:18.000000000 -0500
+++ selinux-mls-users-2/libsepol/src/users.c	2006-08-31 11:35:14.000000000 -0500
@@ -47,13 +47,13 @@ static int user_to_record(sepol_handle_t
 
 		context_init(&context);
 		if (mls_level_cpy(&context.range.level[0],
-				  &usrdatum->dfltlevel) < 0) {
+				  &usrdatum->exp_dfltlevel) < 0) {
 			ERR(handle, "could not copy MLS level");
 			context_destroy(&context);
 			goto err;
 		}
 		if (mls_level_cpy(&context.range.level[1],
-				  &usrdatum->dfltlevel) < 0) {
+				  &usrdatum->exp_dfltlevel) < 0) {
 			ERR(handle, "could not copy MLS level");
 			context_destroy(&context);
 			goto err;
@@ -71,7 +71,7 @@ static int user_to_record(sepol_handle_t
 		free(str);
 
 		context_init(&context);
-		if (mls_range_cpy(&context.range, &usrdatum->range) < 0) {
+		if (mls_range_cpy(&context.range, &usrdatum->exp_range) < 0) {
 			ERR(handle, "could not copy MLS range");
 			context_destroy(&context);
 			goto err;
@@ -191,8 +191,8 @@ int sepol_user_modify(sepol_handle_t * h
 			context_destroy(&context);
 			goto err;
 		}
-		if (mls_level_cpy(&usrdatum->dfltlevel, &context.range.level[0])
-		    < 0) {
+		if (mls_level_cpy(&usrdatum->exp_dfltlevel,
+				  &context.range.level[0]) < 0) {
 			ERR(handle, "could not copy MLS level %s", cmls_level);
 			context_destroy(&context);
 			goto err;
@@ -211,13 +211,12 @@ int sepol_user_modify(sepol_handle_t * h
 			context_destroy(&context);
 			goto err;
 		}
-		if (mls_range_cpy(&usrdatum->range, &context.range) < 0) {
+		if (mls_range_cpy(&usrdatum->exp_range, &context.range) < 0) {
 			ERR(handle, "could not copy MLS range %s", cmls_range);
 			context_destroy(&context);
 			goto err;
 		}
 		context_destroy(&context);
-
 	} else if (cmls_level != NULL || cmls_range != NULL) {
 		ERR(handle, "MLS is disabled, but MLS level/range "
 		    "was found for user %s", cname);
diff --exclude=.svn -ruNp selinux-rangetrans-2/libsepol/src/write.c selinux-mls-users-2/libsepol/src/write.c
--- selinux-rangetrans-2/libsepol/src/write.c	2006-08-30 11:11:18.000000000 -0500
+++ selinux-mls-users-2/libsepol/src/write.c	2006-08-31 11:35:14.000000000 -0500
@@ -1005,18 +1005,27 @@ static int user_write(hashtab_key_t key,
 		if (role_set_write(&usrdatum->roles, fp))
 			return POLICYDB_ERROR;
 	}
-	/* Users are allowed in non-mls modules, so the empty field will be present
-	   in modules with users >= MOD_POLICYDB_VERSION_MLS */
+
 	if ((p->policyvers >= POLICYDB_VERSION_MLS
 	     && p->policy_type == POLICY_KERN)
 	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
+		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS
 		&& p->policy_type == POLICY_MOD)
 	    || (p->policyvers >= MOD_POLICYDB_VERSION_MLS
+		&& p->policyvers < MOD_POLICYDB_VERSION_MLS_USERS
 		&& p->policy_type == POLICY_BASE)) {
-		if (mls_write_range_helper(&usrdatum->range, fp))
+		if (mls_write_range_helper(&usrdatum->exp_range, fp))
 			return POLICYDB_ERROR;
-		if (mls_write_level(&usrdatum->dfltlevel, fp))
+		if (mls_write_level(&usrdatum->exp_dfltlevel, fp))
 			return POLICYDB_ERROR;
+	} else if ((p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS
+		    && p->policy_type == POLICY_MOD)
+		   || (p->policyvers >= MOD_POLICYDB_VERSION_MLS_USERS
+		       && p->policy_type == POLICY_BASE)) {
+		if (mls_write_semantic_range_helper(&usrdatum->range, fp))
+			return -1;
+		if (mls_write_semantic_level_helper(&usrdatum->dfltlevel, fp))
+			return -1;
 	}
 
 	return POLICYDB_SUCCESS;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
