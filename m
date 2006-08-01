Subject: [RFC 2/3] hook enforcement
From: Josh Brindle <jbrindle@tresys.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, kmacmillan@mentalrootkit.com
Content-Type: text/plain
Date: Tue, 01 Aug 2006 07:51:54 -0400
Message-Id: <1154433114.23513.9.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is hooks.c, the file that gets called in to to see if decisions
need to be made.

diff -pruN trunk-old/libsepol/src/hooks.c trunk/libsepol/src/hooks.c
--- trunk-old/libsepol/src/hooks.c	1969-12-31 19:00:00.000000000 -0500
+++ trunk/libsepol/src/hooks.c	2006-07-31 13:03:26.000000000 -0400
@@ -0,0 +1,356 @@
+/* Authors: Joshua Brindle <jbrindle@tresys.com>
+ *
+ * Copyright (C) 2005 Tresys Technology, LLC
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "handle.h"
+#include "debug.h"
+
+#include <sepol/policydb/policydb.h>
+#include <sepol/policydb/expand.h>
+#include <sepol/policydb/sym_val.h>
+#include <sepol/policydb/util.h>
+
+#include <stdlib.h>
+#include <assert.h>
+
+struct sepol_security_internal {
+	policydb_t *other_linked;
+	policydb_t *other_expanded;
+	uint32_t **maps;		/* this is a map between the policy
+					 * currently being expanded and 
+					 * other_expanded for looking up 
+					 * rules and such */
+};
+
+void sepol_init_security_ops(sepol_security_ops_t *sec)
+{
+	sec->symbol_add      = NULL;
+	sec->symbol_remove   = NULL;
+
+	sec->type_add_attrib = NULL;
+
+	sec->role_add_type   = NULL;
+	sec->role_allow_add  = NULL;
+	sec->role_trans_add  = NULL;
+
+	sec->user_add_role   = NULL;
+
+	sec->pvt	     = NULL;
+	
+}
+
+/* src must be indexed before this can be called.
+ * resulting map is map[symbol_type][src_val - 1] = dst_val. If the 
+ * symbol does not exist in the destination the dst_val will be 0 */
+int sepol_security_create_maps(const policydb_t *src, sepol_security_ops_t *sec)
+{
+	uint32_t val, i, j;
+
+	if (!sec || !sec->pvt)
+		return -1;
+
+	if (!sec->pvt->other_expanded)
+		return 0;
+	
+	free(sec->pvt->maps);
+
+	sec->pvt->maps = calloc(SYM_NUM, sizeof(uint32_t*));
+	if (!sec->pvt->maps)
+		return -1;
+
+
+	for (i = 0; i < SYM_NUM; i++) {
+		sec->pvt->maps[i] = calloc(src->symtab[i].nprim, sizeof(uint32_t));
+		if (!sec->pvt->maps[i]) {
+			free(sec->pvt->maps);
+			return -1;
+		}
+		for (j = 0; j < src->symtab[i].nprim; j++) {
+			val = get_sym_val(hashtab_search(sec->pvt->other_expanded->symtab[i].table, 
+				src->sym_val_to_name[i][j]), i);
+			sec->pvt->maps[i][j] = val;
+		}
+	}
+	return 0;
+}
+
+/* you must pass in a linked policydb, this will expand it into a 
+ * policy suitable for using for access control. You cannot free other_pol until
+ * after expand_module has been run and the handle_destroy will not free it for you */
+int sepol_set_security_policy(sepol_handle_t *sh, sepol_policydb_t *other_pol)
+{
+	policydb_t *other_expanded;
+
+	if (!sh->sec)
+		return -1;
+
+	if (other_pol->p.policy_type != POLICY_BASE) {
+		ERR(sh, "other policy is not a linked policy");
+		return -1;
+	}
+
+	sh->sec->pvt->other_linked = &other_pol->p;
+
+	/* now expand it. The expansion is special because every rule 
+	 * and symbol is copied whether they are disabled or not.
+	 * This is necessary to compare against the new policy so that both
+	 * enabled and disabled rules will have access control applied to them.
+	 * We also don't do assertion or hierarchy checking, we trust the 
+	 * incoming policy has already been checked and it's a waste of time.
+	 */
+
+	other_expanded = malloc(sizeof(*other_expanded));
+	if (!other_expanded) {
+		ERR(sh, "out of memory");
+		return -1;
+	}
+
+	if (policydb_init(other_expanded)) {
+		ERR(sh, "out of memory");
+		return -1;
+	}
+	
+	if (expand_module(sh, &other_pol->p, other_expanded, 0, 0, EXPAND_ALL)) {
+		ERR(sh, "could not expand previous policy");
+		return -1;
+	} 
+
+	sh->sec->pvt->other_expanded = other_expanded;
+
+	return 0;
+
+}
+
+
+int sepol_set_security_ops(sepol_handle_t *sh, sepol_security_ops_t *sec)
+{
+	if (!sec) 
+		return -1;
+
+	sec->pvt = malloc(sizeof(*sec->pvt));
+	if (!sec->pvt) {
+		return -1;
+	}
+	sec->pvt->other_linked = NULL;
+	sec->pvt->other_expanded = NULL;
+	sec->pvt->maps = NULL;
+
+	sh->sec = sec;
+	
+	return 0;
+}
+
+/* The symbol add/remove logic works like this:
+ * new_policy	old_policy		access check done
+
+ * decl foo	---			symbol_add
+ * decl foo	require foo		symbol_add
+ * decl foo	decl foo		none
+ * ---		---			none
+ * ---		require foo		none
+ * ---		decl foo		symbol_remove
+ * require foo	---			none
+ * require foo	require foo		none
+ * require foo	decl foo		symbol_remove
+ */
+int sepol_symbol_add(sepol_handle_t *sh, int sym_type, char *id)
+{
+	int symbol;
+	void *new_sym;
+	scope_datum_t *scope;
+
+	if (!(sh->sec->symbol_add))
+		return 0;
+
+	/* attributes are seperate from types for this hook */
+	symbol = ((sym_type == SEPOL_SEC_ATTRIBS) ? SYM_TYPES : sym_type);
+	if (sh->sec->pvt->other_linked) {
+		/* search for symbol in other policy */
+		new_sym =
+			hashtab_search(sh->sec->pvt->other_linked->symtab[symbol].table, id);
+		if (new_sym) { 
+			scope = hashtab_search(sh->sec->pvt->other_linked->scope[symbol].table, id);
+			assert(scope);
+			if (scope->scope == SCOPE_DECL)
+				return 0;
+		}
+	}
+
+	/* if we get here it is either a new symbol or there is no old policy */
+	INFO(sh, "calling symbol_add access control for %d: %s ", sym_type, id);
+
+	if (sh->sec->symbol_add(sym_type, id)) {
+		ERR(sh, "symbol_add denied for %s", id);
+		return -1;
+	}
+
+	return 0;
+}
+
+int sepol_role_allow_add_check(sepol_handle_t *sh, policydb_t *new_pol, uint32_t role, uint32_t new_role)
+{
+	role_allow_t *cur;
+	uint32_t *role_map;
+
+	if (!(sh->sec->role_allow_add))
+		return 0;
+
+	if (sh->sec->pvt->other_expanded) {
+		assert(sh->sec->pvt->maps[SYM_ROLES]);
+		role_map = sh->sec->pvt->maps[SYM_ROLES];
+		/* if either map to 0 this is a new role and must be checked */
+		if (role_map[role] == 0 || role_map[new_role] == 0)
+			goto check;
+
+		cur = sh->sec->pvt->other_expanded->role_allow;
+		while (cur) {
+			if (cur->role == role_map[role] &&
+			    cur->new_role == role_map[new_role]) {
+				/* found an equivalent role_allow, no checking required */
+				return 0;
+			}
+			cur = cur->next;
+		}
+	}
+
+check:
+	/* if we get here we either don't have another policy to compare or there 
+	 * wasn't an equivalent role_allow in the other policy */
+
+	INFO(sh, "calling role_allow_add hook for allow %s %s\n",new_pol->p_role_val_to_name[role],
+			new_pol->p_role_val_to_name[new_role]);
+
+	if (sh->sec->role_allow_add(new_pol->p_role_val_to_name[role], new_pol->p_role_val_to_name[new_role])) {
+		ERR(sh, "role_allow_add denied for allow %s %s\n", new_pol->p_role_val_to_name[role],
+			new_pol->p_role_val_to_name[new_role]);
+		return -1;
+	}
+
+	return 0;
+}
+
+int sepol_role_trans_check(sepol_handle_t *sh, policydb_t *new_pol, uint32_t role, uint32_t type, uint32_t new_role)
+{
+	role_trans_t *cur;
+	uint32_t *role_map, *type_map;
+
+	if (!(sh->sec->role_trans_add))
+		return 0;
+
+	if (sh->sec->pvt->other_expanded) {
+		assert(sh->sec->pvt->maps[SYM_ROLES]);
+		assert(sh->sec->pvt->maps[SYM_TYPES]);
+		role_map = sh->sec->pvt->maps[SYM_ROLES];
+		type_map = sh->sec->pvt->maps[SYM_TYPES];
+		/* if any symbol maps to 0 this is new and must be checked */
+		if (role_map[role] == 0 || type_map[type] == 0 ||
+				role_map[new_role] == 0)
+			goto check;
+
+		cur = sh->sec->pvt->other_expanded->role_tr;
+		while (cur) {
+			if (cur->role == role_map[role] &&
+			    cur->type == type_map[type] &&
+			    cur->new_role == role_map[new_role]) {
+				/* found an equivalent role_allow, no checking required */
+				return 0;
+			}
+			cur = cur->next;
+		}
+	}
+
+check:
+	/* if we get here we either don't have another policy to compare or there 
+	 * wasn't an equivalent role_allow in the other policy */
+
+	INFO(sh, "calling role_trans_add hook for role_trans %s %s %s\n",new_pol->p_role_val_to_name[role],
+			new_pol->p_type_val_to_name[type], new_pol->p_role_val_to_name[new_role]);
+
+	if (sh->sec->role_trans_add(new_pol->p_role_val_to_name[role], 
+				new_pol->p_type_val_to_name[type], new_pol->p_role_val_to_name[new_role])) {
+		ERR(sh, "role_trans_add denied for allow %s %s %s\n", new_pol->p_role_val_to_name[role],
+				new_pol->p_type_val_to_name[type], new_pol->p_role_val_to_name[new_role]);
+		return -1;
+	}
+
+	return 0;
+}
+
+int sepol_avrule_add_check(sepol_handle_t *sh, policydb_t *new_pol, int spec, uint32_t stype, uint32_t ttype, uint32_t class, sepol_access_vector_t perms)
+{
+	avtab_key_t avkey;
+	avtab_ptr_t node;
+	const char *buf;
+	char **p, *perm_buf;
+	int len;
+	sepol_access_vector_t av = 0;
+
+	if (!(sh->sec->avrule_add))
+		return 0;
+
+	if (sh->sec->pvt->other_expanded) {
+		avkey.source_type = sh->sec->pvt->maps[SYM_TYPES][stype - 1];
+		avkey.target_type = sh->sec->pvt->maps[SYM_TYPES][ttype - 1];
+		avkey.target_class = sh->sec->pvt->maps[SYM_CLASSES][class - 1];
+		avkey.specified = spec;
+
+		/* first get the unconditional av */
+		node = avtab_search_node(&sh->sec->pvt->other_expanded->te_avtab, &avkey);
+		if (node)
+			av = node->datum.data;	
+
+		/* Then aggregate all conditional av's */
+		for (node = avtab_search_node(&sh->sec->pvt->other_expanded->te_cond_avtab, &avkey);
+				node != NULL;
+				node = avtab_search_node_next(node, avkey.specified)) {
+			av &= node->datum.data;	
+		}
+	}
+
+	if ((av & perms) == perms) {
+		/* no new perms added, return success */
+		return 0;
+	}
+
+	if (spec & AVTAB_ALLOWED) 
+		buf = "allow";
+	else if (spec & AVTAB_AUDITDENY)
+		buf = "dontaudit";
+	else if (spec & AVTAB_AUDITALLOW)
+		buf = "auditallow";
+	else {
+		assert(0); /* unreachable */
+	}
+
+	len = sepol_av_to_a(new_pol, class, perms & ~av, &p);
+	perm_buf = perm_atos(p, len);
+
+	INFO(sh,"calling avrule_add hook for %s %s %s : %s {%s }",buf,new_pol->p_type_val_to_name[stype - 1], new_pol->p_type_val_to_name[ttype - 1], new_pol->p_class_val_to_name[class - 1], perm_buf);
+
+	if (sh->sec->avrule_add(spec, new_pol->p_type_val_to_name[stype - 1], new_pol->p_type_val_to_name[ttype - 1], new_pol->p_class_val_to_name[class - 1], p, len)) {
+		ERR(sh,"access denied for %s %s %s : %s {%s }",buf,new_pol->p_type_val_to_name[stype - 1], new_pol->p_type_val_to_name[ttype - 1], new_pol->p_class_val_to_name[class - 1], perm_buf);
+		free(p);
+		free(perm_buf);
+		return -1;
+	}
+
+	free(p);
+	free(perm_buf);
+
+	return 0;
+}



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
