From: Harry Ciao <qingtao.cao@windriver.com>
To: <sds@tycho.nsa.gov>, <method@manicmethod.com>, <jmorris@namei.org>,
        <eparis@parisplace.org>
CC: <selinux@tycho.nsa.gov>
Subject: [v0 PATCH 4/5] Add role attribute support when expanding role_datum_t.
Date: Fri, 27 May 2011 09:24:23 +0800
Message-ID: <1306459464-2497-5-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1306459464-2497-1-git-send-email-qingtao.cao@windriver.com>
References: <1306459464-2497-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

1. Copy the flavor flag into its counterpart in the out module;

2. Fix all role attributes in the base module:
2.1 remap the roles ebitmap and merge into its counterpart in the
out module;
2.2 escalate the types.types ebitmap of its counterpart in the out
module, to the counterparts for all the regular roles that belongs
to the current role attribute.

The role_fix_callback() must be called after role_copy_callback()
so that state->rolemap[] is available.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index b1af365..1a94cb4 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -664,6 +664,74 @@ static int role_remap_dominates(hashtab_key_t key __attribute__ ((unused)), hash
 	return 0;
 }
 
+/* For the role attribute in the base module, escalate its counterpart's
+ * types.types ebitmap in the out module to the counterparts of all the
+ * regular role that belongs to the current role attribute. Note, must be
+ * invoked after role_copy_callback so that state->rolemap is available.
+ */
+static int role_fix_callback(hashtab_key_t key, hashtab_datum_t datum,
+			     void *data)
+{
+	char *id, *base_reg_role_id;
+	role_datum_t *role, *new_role, *regular_role;
+	expand_state_t *state;
+	ebitmap_node_t *rnode;
+	unsigned int i;
+	ebitmap_t mapped_roles;
+
+	id = key;
+	role = (role_datum_t *)datum;
+	state = (expand_state_t *)data;
+
+	if (strcmp(id, OBJECT_R) == 0) {
+		/* object_r is never a role attribute by far */
+		return 0;
+	}
+
+	if (role->flavor != ROLE_ATTRIB)
+		return 0;
+
+	if (state->verbose)
+		INFO(state->handle, "fixing role attribute %s", id);
+
+	new_role =
+		(role_datum_t *)hashtab_search(state->out->p_roles.table, id);
+
+	assert(new_role != NULL);
+	assert(new_role->flavor == ROLE_ATTRIB);
+
+	ebitmap_init(&mapped_roles);
+	if (map_ebitmap(&role->roles, &mapped_roles, state->rolemap))
+		return -1;
+	if (ebitmap_union(&new_role->roles, &mapped_roles)) {
+		ERR(state->handle, "Out of memory!");
+		ebitmap_destroy(&mapped_roles);
+		return -1;
+	}
+	ebitmap_destroy(&mapped_roles);
+
+	ebitmap_for_each_bit(&role->roles, rnode, i) {
+		if (ebitmap_node_get_bit(rnode, i)) {
+			/* take advantage of sym_val_to_name[]
+			 * of the base module */
+			base_reg_role_id = state->base->p_role_val_to_name[i];
+			regular_role = (role_datum_t *)hashtab_search(
+						state->out->p_roles.table,
+						base_reg_role_id);
+			assert(regular_role != NULL);
+			assert(regular_role->flavor == ROLE_ROLE);
+
+			if (ebitmap_union(&regular_role->types.types, 
+					  &new_role->types.types)) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
+		}
+	}
+	
+	return 0;
+}
+
 static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 			      void *data)
 {
@@ -709,6 +777,7 @@ static int role_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
 		}
 
 		state->out->p_roles.nprim++;
+		new_role->flavor = role->flavor;
 		new_role->s.value = state->out->p_roles.nprim;
 		state->rolemap[role->s.value - 1] = new_role->s.value;
 		ret = hashtab_insert(state->out->p_roles.table,
@@ -2673,6 +2742,10 @@ int expand_module(sepol_handle_t * handle,
 	if (hashtab_map(state.base->p_roles.table,
 			role_bounds_copy_callback, &state))
 		goto cleanup;
+	/* escalate the type_set_t in a role attribute to all regular roles
+	 * that belongs to it. */
+	if (hashtab_map(state.base->p_roles.table, role_fix_callback, &state))
+		goto cleanup;
 
 	/* copy MLS's sensitivity level and categories - this needs to be done
 	 * before expanding users (they need to be indexed too) */
@@ -2725,6 +2798,9 @@ int expand_module(sepol_handle_t * handle,
 		if (hashtab_map
 		    (decl->p_roles.table, role_copy_callback, &state))
 			goto cleanup;
+		if (hashtab_map
+		    (decl->p_roles.table, role_fix_callback, &state))
+			goto cleanup;
 
 		/* copy users */
 		if (hashtab_map
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
