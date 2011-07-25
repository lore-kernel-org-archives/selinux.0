Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6P1OMiE025319
	for <selinux@tycho.nsa.gov>; Sun, 24 Jul 2011 21:24:33 -0400
Received: from mail.windriver.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6P1OLfI009099
	for <selinux@tycho.nsa.gov>; Mon, 25 Jul 2011 01:24:22 GMT
From: Harry Ciao <qingtao.cao@windriver.com>
To: <cpebenito@tresys.com>, <slawrence@tresys.com>, <method@manicmethod.com>
CC: <selinux@tycho.nsa.gov>
Subject: [v4 PATCH 6/6] Support adding one role attribute into another.
Date: Mon, 25 Jul 2011 09:23:59 +0800
Message-ID: <1311557039-2977-7-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
References: <1311557039-2977-1-git-send-email-qingtao.cao@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When the link process is completed, the types type_set_t and roles
ebitmap in a role attribute are settled, then we could go on to scan
all role attributes in the base->p_roles.table checking if any non-zero
bit in its roles ebitmap is indeed another role attribute.

If this is the case, then we need to escalate the roles ebitmap of
the sub role attribute into that of the parent, and remove the sub role
attribute from parent's roles ebitmap.

Since sub-attribute's roles ebitmap may further contain other role
attributes, we need to re-scan the updated parent's roles ebitmap.

Also if a loop dependency is detected, no escalation of sub-attribute's
roles ebitmap is needed.

Note, although in the link stage all role identifiers defined in any
block/decl of any module would be copied into the base->p_roles.table,
the role-attribute relationships could still be recorded in the decl's
local symtab[SYM_ROLES] table(see get_local_role()), so before all above
escalation of sub role attribute's roles ebitmap into that of parent ever
happens, all decl in the base->global list except the global block would
have to be traversed so as to populate potential role-attribute
relationships from decl up to the base module.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 checkpolicy/policy_define.c |    5 +-
 libsepol/src/link.c         |  132 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
index 6faaf94..ded27f7 100644
--- a/checkpolicy/policy_define.c
+++ b/checkpolicy/policy_define.c
@@ -1902,8 +1902,9 @@ int define_roleattribute(void)
 		return -1;
 	}
 	r = hashtab_search(policydbp->p_roles.table, id);
-	if (!r || r->flavor != ROLE_ROLE) {
-		yyerror2("unknown role %s, or not a regular role", id);
+	/* We support adding one role attribute into another */
+	if (!r) {
+		yyerror2("unknown role %s", id);
 		free(id);
 		return -1;
 	}
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 53fcff9..421c47b 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -2335,6 +2335,122 @@ static int prepare_base(link_state_t * state, uint32_t num_mod_decls)
 	return 0;
 }
 
+static int expand_role_attributes(hashtab_key_t key, hashtab_datum_t datum,
+				  void * data)
+{
+	char *id;
+	role_datum_t *role, *sub_attr;
+	link_state_t *state;
+	unsigned int i;
+	ebitmap_node_t *rnode;
+
+	id = key;
+	role = (role_datum_t *)datum;
+	state = (link_state_t *)data;
+
+	if (strcmp(id, OBJECT_R) == 0){
+		/* object_r is never a role attribute by far */
+		return 0;
+	}
+
+	if (role->flavor != ROLE_ATTRIB)
+		return 0;
+
+	if (state->verbose)
+		INFO(state->handle, "expanding role attribute %s", id);
+
+restart:
+	ebitmap_for_each_bit(&role->roles, rnode, i) {
+		if (ebitmap_node_get_bit(rnode, i)) {
+			sub_attr = state->base->role_val_to_struct[i];
+			if (sub_attr->flavor != ROLE_ATTRIB)
+				continue;
+			
+			/* remove the sub role attribute from the parent
+			 * role attribute's roles ebitmap */
+			if (ebitmap_set_bit(&role->roles, i, 0))
+				return -1;
+
+			/* loop dependency of role attributes */
+			if (sub_attr->s.value == role->s.value)
+				continue;
+
+			/* now go on to expand a sub role attribute
+			 * by escalating its roles ebitmap */
+			if (ebitmap_union(&role->roles, &sub_attr->roles)) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
+			
+			/* sub_attr->roles may contain other role attributes,
+			 * re-scan the parent role attribute's roles ebitmap */
+			goto restart;
+		}
+	}
+
+	return 0;
+}
+
+/* For any role attribute in a declaration's local symtab[SYM_ROLES] table,
+ * copy its roles ebitmap into its duplicate's in the base->p_roles.table.
+ */
+static int populate_decl_roleattributes(hashtab_key_t key, 
+					hashtab_datum_t datum,
+					void *data)
+{
+	char *id = key;
+	role_datum_t *decl_role, *base_role;
+	link_state_t *state = (link_state_t *)data;
+
+	decl_role = (role_datum_t *)datum;
+
+	if (strcmp(id, OBJECT_R) == 0) {
+		/* object_r is never a role attribute by far */
+		return 0;
+	}
+
+	if (decl_role->flavor != ROLE_ATTRIB)
+		return 0;
+
+	base_role = (role_datum_t *)hashtab_search(state->base->p_roles.table,
+						   id);
+	assert(base_role != NULL && base_role->flavor == ROLE_ATTRIB);
+
+	if (ebitmap_union(&base_role->roles, &decl_role->roles)) {
+		ERR(state->handle, "Out of memory!");
+		return -1;
+	}
+
+	return 0;
+}
+
+static int populate_roleattributes(link_state_t *state, policydb_t *pol)
+{
+	avrule_block_t *block;
+	avrule_decl_t *decl;
+
+	if (state->verbose)
+		INFO(state->handle, "Populating role-attribute relationship "
+			    "from enabled declarations' local symtab.");
+
+	/* Iterate through all of the blocks skipping the first(which is the
+	 * global block, is required to be present and can't have an else).
+	 * If the block is disabled or not having an enabled decl, skip it.
+	 */
+	for (block = pol->global->next; block != NULL; block = block->next)
+	{
+		decl = block->enabled;
+		if (decl == NULL || decl->enabled == 0)
+			continue;
+
+		if (hashtab_map(decl->symtab[SYM_ROLES].table, 
+				populate_decl_roleattributes, state))
+			return -1;
+	}
+
+	return 0;
+}
+
 /* Link a set of modules into a base module. This process is somewhat
  * similar to an actual compiler: it requires a set of order dependent
  * steps.  The base and every module must have been indexed prior to
@@ -2455,6 +2571,22 @@ int link_modules(sepol_handle_t * handle,
 		goto cleanup;
 	}
 
+	/* Now that all role attribute's roles ebitmap have been settled,
+	 * escalate sub role attribute's roles ebitmap into that of parent.
+	 *
+	 * First, since some role-attribute relationships could be recorded
+	 * in some decl's local symtab(see get_local_role()), we need to
+	 * populate them up to the base.p_roles table. */
+	if (populate_roleattributes(&state, state.base)) {
+		retval = SEPOL_EREQ;
+		goto cleanup;
+	}
+	
+	/* Now do the escalation. */
+	if (hashtab_map(state.base->p_roles.table, expand_role_attributes,
+			&state))
+		goto cleanup;
+
 	retval = 0;
       cleanup:
 	for (i = 0; modules != NULL && i < len; i++) {
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
