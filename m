Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5S8IxOp022480
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 04:19:05 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5S8J4po010569
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2011 08:19:04 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>, <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v3 PATCH 5/6] Add role attribute support when expanding role_set_t.
Date: Tue, 28 Jun 2011 16:18:45 +0800
Message-ID: <1309249126-5224-6-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
References: <1309249126-5224-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When the rolemap and pointer to the base module are available, if
a non-zero bit in role_set_t.roles is a role attribute, expand it
before remap.

Note, during module compile the rolemap may not be available, the
potential duplicates of a regular role and the role attribute that
the regular role belongs to could be properly handled by
copy_role_allow() and copy_role_trans() during module expansion.

Take advantage of the role_val_to_struct[] of the base module, since
when role_set_expand() is invoked, the role_val_to_struct[] of the
out module may have not been established yet.

Also cleanup the error handling of role_set_expand().

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 checkpolicy/policy_define.c              |    2 +-
 libsepol/include/sepol/policydb/expand.h |    2 +-
 libsepol/src/expand.c                    |   57 ++++++++++++++++++++++++------
 libsepol/src/policydb.c                  |    2 +-
 libsepol/src/users.c                     |    4 +-
 5 files changed, 51 insertions(+), 16 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 92646a0..6faaf94 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -2289,7 +2289,7 @@ int define_role_trans(int class_specified)
 	}
 
 	/* This ebitmap business is just to ensure that there are not conflicting role_trans rules */
-	if (role_set_expand(&roles, &e_roles, policydbp, NULL))
+	if (role_set_expand(&roles, &e_roles, policydbp, NULL, NULL))
 		goto bad;
 
 	if (type_set_expand(&types, &e_types, policydbp, 1))
diff --git a/libsepol/include/sepol/policydb/expand.h b/libsepol/include/sepol/policydb/expand.h
index 059b065..31e25ec 100644
--- a/libsepol/include/sepol/policydb/expand.h
+++ b/libsepol/include/sepol/policydb/expand.h
@@ -60,7 +60,7 @@ extern int expand_convert_type_set(policydb_t * p, uint32_t * typemap,
 				   unsigned char alwaysexpand);
 extern int type_set_expand(type_set_t * set, ebitmap_t * t, policydb_t * p,
 			   unsigned char alwaysexpand);
-extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * rolemap);
+extern int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t * base, uint32_t * rolemap);
 extern int mls_semantic_level_expand(mls_semantic_level_t *sl, mls_level_t *l,
                                      policydb_t *p, sepol_handle_t *h);
 extern int mls_semantic_range_expand(mls_semantic_range_t *sr, mls_range_t *r,
diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 2dbbd27..b42acbe 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -981,7 +981,7 @@ static int user_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 	ebitmap_init(&tmp_union);
 
 	/* get global roles for this user */
-	if (role_set_expand(&user->roles, &tmp_union, state->base, state->rolemap)) {
+	if (role_set_expand(&user->roles, &tmp_union, state->out, state->base, state->rolemap)) {
 		ERR(state->handle, "Out of memory!");
 		ebitmap_destroy(&tmp_union);
 		return -1;
@@ -1159,12 +1159,12 @@ static int copy_role_allows(expand_state_t * state, role_allow_rule_t * rules)
 		ebitmap_init(&roles);
 		ebitmap_init(&new_roles);
 
-		if (role_set_expand(&cur->roles, &roles, state->out, state->rolemap)) {
+		if (role_set_expand(&cur->roles, &roles, state->out, state->base, state->rolemap)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
 
-		if (role_set_expand(&cur->new_roles, &new_roles, state->out, state->rolemap)) {
+		if (role_set_expand(&cur->new_roles, &new_roles, state->out, state->base, state->rolemap)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
@@ -1228,7 +1228,7 @@ static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 		ebitmap_init(&roles);
 		ebitmap_init(&types);
 
-		if (role_set_expand(&cur->roles, &roles, state->out, state->rolemap)) {
+		if (role_set_expand(&cur->roles, &roles, state->out, state->base, state->rolemap)) {
 			ERR(state->handle, "Out of memory!");
 			return -1;
 		}
@@ -2267,14 +2267,23 @@ int expand_rule(sepol_handle_t * handle,
 	return retval;
 }
 
-int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * rolemap)
+/* Expand a role set into an ebitmap containing the roles.
+ * This handles the attribute and flags.
+ * Attribute expansion depends on if the rolemap is available.
+ * During module compile the rolemap is not available, the
+ * possible duplicates of a regular role and the role attribute
+ * the regular role belongs to could be properly handled by
+ * copy_role_trans and copy_role_allow.
+ */
+int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * out, policydb_t * base, uint32_t * rolemap)
 {
 	unsigned int i;
 	ebitmap_node_t *rnode;
-	ebitmap_t mapped_roles;
+	ebitmap_t mapped_roles, roles;
+	policydb_t *p = out;
+	role_datum_t *role;
 
 	ebitmap_init(r);
-	ebitmap_init(&mapped_roles);
 
 	if (x->flags & ROLE_STAR) {
 		for (i = 0; i < p->p_roles.nprim++; i++)
@@ -2283,22 +2292,43 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * ro
 		return 0;
 	}
 
+	ebitmap_init(&mapped_roles);
+	ebitmap_init(&roles);
+	
 	if (rolemap) {
-		if (map_ebitmap(&x->roles, &mapped_roles, rolemap))
-			return -1;
+		assert(base != NULL);
+		ebitmap_for_each_bit(&x->roles, rnode, i) {
+			if (ebitmap_node_get_bit(rnode, i)) {
+				/* take advantage of p_role_val_to_struct[]
+				 * of the base module */
+				role = base->role_val_to_struct[i];
+				assert(role != NULL);
+				if (role->flavor == ROLE_ATTRIB) {
+					if (ebitmap_union(&roles,
+							  &role->roles))
+						goto bad;
+				} else {
+					if (ebitmap_set_bit(&roles, i, 1))
+						goto bad;
+				}
+			}
+		}
+		if (map_ebitmap(&roles, &mapped_roles, rolemap))
+			goto bad;
 	} else {
 		if (ebitmap_cpy(&mapped_roles, &x->roles))
-			return -1;
+			goto bad;
 	}
 
 	ebitmap_for_each_bit(&mapped_roles, rnode, i) {
 		if (ebitmap_node_get_bit(rnode, i)) {
 			if (ebitmap_set_bit(r, i, 1))
-				return -1;
+				goto bad;
 		}
 	}
 
 	ebitmap_destroy(&mapped_roles);
+	ebitmap_destroy(&roles);
 
 	/* if role is to be complimented, invert the entire bitmap here */
 	if (x->flags & ROLE_COMP) {
@@ -2313,6 +2343,11 @@ int role_set_expand(role_set_t * x, ebitmap_t * r, policydb_t * p, uint32_t * ro
 		}
 	}
 	return 0;
+
+bad:
+	ebitmap_destroy(&mapped_roles);
+	ebitmap_destroy(&roles);
+	return -1;
 }
 
 /* Expand a type set into an ebitmap containing the types. This
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index c872498..4a3761a 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -698,7 +698,7 @@ int policydb_user_cache(hashtab_key_t key
 	p = (policydb_t *) arg;
 
 	ebitmap_destroy(&user->cache);
-	if (role_set_expand(&user->roles, &user->cache, p, NULL)) {
+	if (role_set_expand(&user->roles, &user->cache, p, NULL, NULL)) {
 		return -1;
 	}
 
diff --git a/libsepol/src/users.c b/libsepol/src/users.c
index 17e1426..693210d 100644
--- a/libsepol/src/users.c
+++ b/libsepol/src/users.c
@@ -259,8 +259,8 @@ int sepol_user_modify(sepol_handle_t * handle,
 		name = NULL;
 
 		/* Expand roles */
-		if (role_set_expand
-		    (&usrdatum->roles, &usrdatum->cache, policydb, NULL)) {
+		if (role_set_expand(&usrdatum->roles, &usrdatum->cache,
+				    policydb, NULL, NULL)) {
 			ERR(handle, "unable to expand role set");
 			goto err;
 		}
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
