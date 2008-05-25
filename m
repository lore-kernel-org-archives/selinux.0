Message-ID: <4838CDDB.5000409@manicmethod.com>
Date: Sat, 24 May 2008 22:24:27 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Martin Orr <martin@martinorr.name>, SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Karl MacMillan <kmacmillan@tresys.com>, setools@tresys.com
Subject: [PATCH Take 3] user and role remapping in expander (was Re: roles
 in base module)
References: <4820D9FB.8010802@martinorr.name>	 <1210248530.6434.145.camel@moss-spartans.epoch.ncsc.mil>	 <482E1DCD.1000505@manicmethod.com>	 <1211199052.7486.30.camel@moss-spartans.epoch.ncsc.mil>	 <4831F82F.3090702@manicmethod.com> <1211306138.7486.189.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1211306138.7486.189.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Mon, 2008-05-19 at 17:59 -0400, Joshua Brindle wrote:
>> Stephen Smalley wrote:
>>> On Fri, 2008-05-16 at 19:50 -0400, Joshua Brindle wrote:
>>>> Stephen Smalley wrote:
>>>>> On Tue, 2008-05-06 at 23:21 +0100, Martin Orr wrote:
>>>>>> Should I be able to build trunk refpolicy with the user roles included in
>>>>>> the base module?  I can build it with the roles as modules, but if I try
>>>>>> building them into base I get
>>>>>> /usr/bin/checkmodule -M base.conf -o tmp/base.mod
>>>>>> /usr/bin/checkmodule:  loading policy configuration from base.conf
>>>>>> libsepol.expand_module: Error while indexing out symbols
>>>>>> /usr/bin/checkmodule:  expand module failed
>>>>>>
>>>>>> I have refpolicy revision 2669, libsepol 2.0.25, checkpolicy 2.0.12.  I have
>>>>>> attached the modules.conf I am using, which seems to be the minimum number
>>>>>> of things I need to build in to be able to build in roles.
>>>>> Reproduced here as well, and naturally one should be able to build roles
>>>>> into base.
>>>>>
>>>>> We've seen this error condition in the past - it indicates that there is
>>>>> a hole in the symbol table, and requires mapping support in the expand
>>>>> code for roles to correctly handle it.  So that represents a
>>>>> bug/limitation of the current policy compiler.
>>>>>
>>>>> Walking through it I see that it is omitting the auditadm_r and secadm_r
>>>>> roles during the expand, and this is leaving the holes in the symbol
>>>>> table.
>>>>>
>>>>> Fixing the compiler requires adding mapping support for the roles
>>>>> similar to what Karl did for booleans in r2308.
>>>>>
>>>>> Hopefully though Chris can work around it in the policy in the interim.
>>>>>
>>>> Patch below should fix both user and role mapping issues.
>>> Why is it that we don't need a usermap too?
>>>
>> Updated patch includes usermap and mapping in constraint_node_clone, completely untested.
> 
> Still fails in the same way as reported by Martin upon semodule -b of the base module.
> libsepol.context_read_and_validate: invalid security context
> libsepol.sepol_set_policydb_from_file: can't read binary policy: Success
> Error reading policy /etc/selinux/test/policy/policy.23: Success
> libsemanage.semanage_install_active: setfiles returned error code 1.
> 
> Also fails upon just trying to semodule -B an existing valid policy
> store using the patched libsepol.
> 

Ok, the following patch should address everything, it was more intrusive than I originally thought. 

role->dominates will be incorrect when roles are copied and mapped from base into out policy, this is fixed after they've all been copied. 

There is a tiny hack concerning object_r, at some point I'd like to address all the object_r hardcoding (both in the kernel and toolchain) but that is pretty low on the list.

expand_module_avrules() which is used by external apps (eg., setools) has changed so those users will need to be fixed.

valgrind and sediff are clean

------

diff -pruN -x .svn trunk.old/checkpolicy/policy_define.c trunk/checkpolicy/policy_define.c
--- trunk.old/checkpolicy/policy_define.c	2008-05-14 06:03:32.588668393 -0400
+++ trunk/checkpolicy/policy_define.c	2008-05-20 04:26:11.820507770 -0400
@@ -2006,7 +2006,7 @@ int define_role_trans(void)
 	}
 
 	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */
-	if (role_set_expand(&roles, &e_roles, policydbp))
+	if (role_set_expand(&roles, &e_roles, policydbp, NULL))
 		goto bad;
 
 	if (type_set_expand(&types, &e_types, policydbp, 1))
diff -pruN -x .svn trunk.old/libsepol/include/sepol/policydb/expand.h trunk/libsepol/include/sepol/policydb/expand.h
--- trunk.old/libsepol/include/sepol/policydb/expand.h	2008-05-14 06:03:34.088691020 -0400
+++ trunk/libsepol/include/sepol/policydb/expand.h	2008-05-20 04:26:11.820507770 -0400
@@ -43,6 +43,7 @@
  */
 extern int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
 				 policydb_t * out, uint32_t * typemap, uint32_t * boolmap,
+				 uint32_t * rolemap, uint32_t * usermap,
 				 int verbose, int expand_neverallow);
 /*
  * Expand all parts of a module. Neverallow rules are not expanded (only
@@ -59,7 +60,7 @@ extern int expand_convert_type_set(polic
 				   unsigned char alwaysexpand);
 extern int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 			   unsigned char alwaysexpand);
-extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p);
+extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * rolemap);
 extern int mls_semantic_level_expand(mls_semantic_level_t *sl, mls_level_t *l,
                                      policydb_t *p, sepol_handle_t *h);
 extern int mls_semantic_range_expand(mls_semantic_range_t *sr, mls_range_t *r,
diff -pruN -x .svn trunk.old/libsepol/src/expand.c trunk/libsepol/src/expand.c
--- trunk.old/libsepol/src/expand.c	2008-05-14 06:03:34.088691020 -0400
+++ trunk/libsepol/src/expand.c	2008-05-20 04:37:12.830478955 -0400
@@ -41,6 +41,8 @@ typedef struct expand_state {
 	int verbose;
 	uint32_t *typemap;
 	uint32_t *boolmap;
+	uint32_t *rolemap;
+	uint32_t *usermap;
 	policydb_t *base;
 	policydb_t *out;
 	sepol_handle_t *handle;
@@ -52,6 +54,23 @@ static void expand_state_init(expand_sta
 	memset(state, 0, sizeof(expand_state_t));
 }
 
+static int map_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * map)
+{
+	unsigned int i;
+	ebitmap_node_t *tnode;
+	ebitmap_init(dst);
+
+	ebitmap_for_each_bit(src, tnode, i) {
+		if (!ebitmap_node_get_bit(tnode, i))
+			continue;
+		if (!map[i])
+			continue;
+		if (ebitmap_set_bit(dst, map[i] - 1, 1))
+			return -1;
+	}
+	return 0;
+}
+
 static int type_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -150,7 +169,7 @@ static int attr_convert_callback(hashtab
 		ERR(state->handle, "attribute %s vanished!", id);
 		return -1;
 	}
-	if (convert_type_ebitmap(&type->types, &tmp_union, state->typemap)) {
+	if (map_ebitmap(&type->types, &tmp_union, state->typemap)) {
 		ERR(state->handle, "out of memory");
 		return -1;
 	}
@@ -297,6 +316,14 @@ static int constraint_node_clone(constra
 								    names, 1)) {
 						goto out_of_mem;
 					}
+				} else if (new_expr->attr & CEXPR_ROLE) {
+					if (map_ebitmap(&expr->names, &new_expr->names, state->rolemap)) {
+						goto out_of_mem;
+					}
+				} else if (new_expr->attr & CEXPR_USER) {
+					if (map_ebitmap(&expr->names, &new_expr->names, state->usermap)) {
+						goto out_of_mem;
+					}
 				} else {
 					/* Other kinds of sets do not. */
 					if (ebitmap_cpy(&new_expr->names,
@@ -511,6 +538,28 @@ static int alias_copy_callback(hashtab_k
 	return 0;
 }
 
+static int role_remap_dominates(hashtab_key_t key __attribute__ ((unused)), hashtab_datum_t datum, void *data)
+{
+	ebitmap_t mapped_roles;
+	role_datum_t *role = (role_datum_t *) datum;
+	expand_state_t *state = (expand_state_t *) data;
+
+	if (!(&role->dominates.node)) 
+		return 0;
+
+	if (map_ebitmap(&role->dominates, &mapped_roles, state->rolemap))
+		return -1;
+
+	ebitmap_destroy(&role->dominates);	
+	
+	if (ebitmap_cpy(&role->dominates, &mapped_roles))
+		return -1;
+
+	ebitmap_destroy(&mapped_roles);
+
+	return 0;
+}
+
 static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -525,8 +574,11 @@ static int role_copy_callback(hashtab_ke
 	role = (role_datum_t *) datum;
 	state = (expand_state_t *) data;
 
-	if (strcmp(id, OBJECT_R) == 0)
+	if (strcmp(id, OBJECT_R) == 0) {
+		/* object_r is always value 1 */
+		state->rolemap[role->s.value - 1] = 1;
 		return 0;
+	}
 
 	if (!is_id_enabled(id, state->base, SYM_ROLES)) {
 		/* identifier's scope is not enabled */
@@ -552,8 +604,9 @@ static int role_copy_callback(hashtab_ke
 			return -1;
 		}
 
-		new_role->s.value = role->s.value;
 		state->out->p_roles.nprim++;
+		new_role->s.value = state->out->p_roles.nprim;
+		state->rolemap[role->s.value - 1] = new_role->s.value;
 		ret = hashtab_insert(state->out->p_roles.table,
 				     (hashtab_key_t) new_id,
 				     (hashtab_datum_t) new_role);
@@ -570,6 +623,10 @@ static int role_copy_callback(hashtab_ke
 		ebitmap_init(&new_role->dominates);
 	}
 
+
+	/* The dominates bitmap is going to be wrong for the moment, 
+ 	 * we'll come back later and remap them, after we are sure all 
+ 	 * the roles have been added */
 	if (ebitmap_union(&new_role->dominates, &role->dominates)) {
 		ERR(state->handle, "Out of memory!");
 		return -1;
@@ -692,8 +749,9 @@ static int user_copy_callback(hashtab_ke
 		}
 		memset(new_user, 0, sizeof(user_datum_t));
 
-		new_user->s.value = user->s.value;
 		state->out->p_users.nprim++;
+		new_user->s.value = state->out->p_users.nprim;
+		state->usermap[user->s.value - 1] = new_user->s.value;
 
 		new_id = strdup(id);
 		if (!new_id) {
@@ -756,7 +814,7 @@ static int user_copy_callback(hashtab_ke
 	ebitmap_init(&tmp_union);
 
 	/* get global roles for this user */
-	if (role_set_expand(&user->roles, &tmp_union, state->base)) {
+	if (role_set_expand(&user->roles, &tmp_union, state->base, state->rolemap)) {
 		ERR(state->handle, "Out of memory!");
 		ebitmap_destroy(&tmp_union);
 		return -1;
@@ -938,14 +996,16 @@ static int copy_role_allows(expand_state
 		ebitmap_init(&roles);
 		ebitmap_init(&new_roles);
 
-		if (role_set_expand(&cur->roles, &roles, state->out)) {
+		if (role_set_expand(&cur->roles, &roles, state->out, state->rolemap)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
-		if (role_set_expand(&cur->new_roles, &new_roles, state->out)) {
+
+		if (role_set_expand(&cur->new_roles, &new_roles, state->out, state->rolemap)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
+
 		ebitmap_for_each_bit(&roles, snode, i) {
 			if (!ebitmap_node_get_bit(snode, i))
 				continue;
@@ -1005,7 +1065,7 @@ static int copy_role_trans(expand_state_
 		ebitmap_init(&roles);
 		ebitmap_init(&types);
 
-		if (role_set_expand(&cur->roles, &roles, state->out)) {
+		if (role_set_expand(&cur->roles, &roles, state->out, state->rolemap)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
@@ -1058,7 +1118,7 @@ static int copy_role_trans(expand_state_
 				memset(n, 0, sizeof(role_trans_t));
 				n->role = i + 1;
 				n->type = j + 1;
-				n->new_role = cur->new_role;
+				n->new_role = state->rolemap[cur->new_role - 1];
 				if (l) {
 					l->next = n;
 				} else {
@@ -1658,8 +1718,8 @@ static int cond_node_copy(expand_state_t
 static int context_copy(context_struct_t * dst, context_struct_t * src,
 			expand_state_t * state)
 {
-	dst->user = src->user;
-	dst->role = src->role;
+	dst->user = state->usermap[src->user - 1];
+	dst->role = state->rolemap[src->role - 1];
 	dst->type = state->typemap[src->type - 1];
 	return mls_context_cpy(dst, src);
 }
@@ -1842,23 +1902,6 @@ static int type_attr_remove(hashtab_key_
 	return 0;
 }
 
-int convert_type_ebitmap(ebitmap_t * src, ebitmap_t * dst, uint32_t * typemap)
-{
-	unsigned int i;
-	ebitmap_node_t *tnode;
-	ebitmap_init(dst);
-
-	ebitmap_for_each_bit(src, tnode, i) {
-		if (!ebitmap_node_get_bit(tnode, i))
-			continue;
-		if (!typemap[i])
-			continue;
-		if (ebitmap_set_bit(dst, typemap[i] - 1, 1))
-			return -1;
-	}
-	return 0;
-}
-
 /* converts typeset using typemap and expands into ebitmap_t types using the attributes in the passed in policy.
  * this should not be called until after all the blocks have been processed and the attributes in target policy
  * are complete. */
@@ -1870,10 +1913,10 @@ int expand_convert_type_set(policydb_t *
 
 	type_set_init(&tmpset);
 
-	if (convert_type_ebitmap(&set->types, &tmpset.types, typemap))
+	if (map_ebitmap(&set->types, &tmpset.types, typemap))
 		return -1;
 
-	if (convert_type_ebitmap(&set->negset, &tmpset.negset, typemap))
+	if (map_ebitmap(&set->negset, &tmpset.negset, typemap))
 		return -1;
 
 	tmpset.flags = set->flags;
@@ -1915,12 +1958,14 @@ int expand_rule(sepol_handle_t * handle,
 	return retval;
 }
 
-int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p)
+int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * rolemap)
 {
 	unsigned int i;
 	ebitmap_node_t *rnode;
+	ebitmap_t mapped_roles;
 
 	ebitmap_init(r);
+	ebitmap_init(&mapped_roles);
 
 	if (x->flags & ROLE_STAR) {
 		for (i = 0; i < p->p_roles.nprim++; i++)
@@ -1929,13 +1974,23 @@ int role_set_expand(role_set_t * x, ebit
 		return 0;
 	}
 
-	ebitmap_for_each_bit(&x->roles, rnode, i) {
+	if (rolemap) {
+		if (map_ebitmap(&x->roles, &mapped_roles, rolemap))
+			return -1;
+	} else {
+		if (ebitmap_cpy(&mapped_roles, &x->roles))
+			return -1;
+	}
+
+	ebitmap_for_each_bit(&mapped_roles, rnode, i) {
 		if (ebitmap_node_get_bit(rnode, i)) {
 			if (ebitmap_set_bit(r, i, 1))
 				return -1;
 		}
 	}
 
+	ebitmap_destroy(&mapped_roles);
+
 	/* if role is to be complimented, invert the entire bitmap here */
 	if (x->flags & ROLE_COMP) {
 		for (i = 0; i < ebitmap_length(r); i++) {
@@ -2239,7 +2294,8 @@ static int copy_and_expand_avrule_block(
  */
 int expand_module_avrules(sepol_handle_t * handle, policydb_t * base,
 			  policydb_t * out, uint32_t * typemap,
-			  uint32_t * boolmap, int verbose,
+			  uint32_t * boolmap, uint32_t * rolemap,
+			  uint32_t * usermap, int verbose,
 			  int expand_neverallow)
 {
 	expand_state_t state;
@@ -2250,6 +2306,8 @@ int expand_module_avrules(sepol_handle_t
 	state.out = out;
 	state.typemap = typemap;
 	state.boolmap = boolmap;
+	state.rolemap = rolemap;
+	state.usermap = usermap;
 	state.handle = handle;
 	state.verbose = verbose;
 	state.expand_neverallow = expand_neverallow;
@@ -2309,6 +2367,18 @@ int expand_module(sepol_handle_t * handl
 		goto cleanup;
 	}
 
+	state.rolemap = (uint32_t *)calloc(state.base->p_roles.nprim, sizeof(uint32_t));
+	if (!state.rolemap) {
+		ERR(handle, "Out of memory!");
+		goto cleanup;
+	}
+
+	state.usermap = (uint32_t *)calloc(state.base->p_users.nprim, sizeof(uint32_t));
+	if (!state.usermap) {
+		ERR(handle, "Out of memory!");
+		goto cleanup;
+	}
+
 	/* order is important - types must be first */
 
 	/* copy types */
@@ -2405,6 +2475,11 @@ int expand_module(sepol_handle_t * handl
 
 	}
 
+	/* remap role dominates bitmaps */
+	 if (hashtab_map(state.out->p_roles.table, role_remap_dominates, &state)) {
+		goto cleanup;
+	}
+
 	if (copy_and_expand_avrule_block(&state) < 0) {
 		ERR(handle, "Error during expand");
 		goto cleanup;
@@ -2464,6 +2539,8 @@ int expand_module(sepol_handle_t * handl
       cleanup:
 	free(state.typemap);
 	free(state.boolmap);
+	free(state.rolemap);
+	free(state.usermap);
 	return retval;
 }
 
diff -pruN -x .svn trunk.old/libsepol/src/policydb.c trunk/libsepol/src/policydb.c
--- trunk.old/libsepol/src/policydb.c	2008-05-14 06:03:34.088691020 -0400
+++ trunk/libsepol/src/policydb.c	2008-05-20 04:26:11.820507770 -0400
@@ -559,7 +559,7 @@ int policydb_user_cache(hashtab_key_t ke
 	p = (policydb_t *) arg;
 
 	ebitmap_destroy(&user->cache);
-	if (role_set_expand(&user->roles, &user->cache, p)) {
+	if (role_set_expand(&user->roles, &user->cache, p, NULL)) {
 		return -1;
 	}
 
diff -pruN -x .svn trunk.old/libsepol/src/users.c trunk/libsepol/src/users.c
--- trunk.old/libsepol/src/users.c	2008-05-14 06:03:34.088691020 -0400
+++ trunk/libsepol/src/users.c	2008-05-20 04:26:11.820507770 -0400
@@ -260,7 +260,7 @@ int sepol_user_modify(sepol_handle_t * h
 
 		/* Expand roles */
 		if (role_set_expand
-		    (&usrdatum->roles, &usrdatum->cache, policydb)) {
+		    (&usrdatum->roles, &usrdatum->cache, policydb, NULL)) {
 			ERR(handle, "unable to expand role set");
 			goto err;
 		}




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
