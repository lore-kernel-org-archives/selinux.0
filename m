From: Harry Ciao <qingtao.cao@windriver.com>
To: sds@tycho.nsa.gov, jmorris@namei.org, eparis@parisplace.org
Cc: selinux@tycho.nsa.gov
Subject: [v1 PATCH 4/5] Userspace: handle the class in role_trans_rule
Date: Thu, 24 Mar 2011 18:42:45 +0800
Message-Id: <1300963366-9169-8-git-send-email-qingtao.cao@windriver.com>
In-Reply-To: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
References: <1300963366-9169-1-git-send-email-qingtao.cao@windriver.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Harry Ciao <harrytaurus2002@hotmail.com>

Add class support to various functions to handle role_trans_rule_t
structures.

Signed-off-by: Harry Ciao <qingtao.cao@windriver.com>
---
 libsepol/src/expand.c   |   94 +++++++++++++++++++++++++----------------------
 libsepol/src/link.c     |   14 +++++++
 libsepol/src/policydb.c |    5 ++
 libsepol/src/write.c    |    2 +
 4 files changed, 71 insertions(+), 44 deletions(-)

diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
index 16d6bcb..f915f8a 100644
--- a/libsepol/src/expand.c
+++ b/libsepol/src/expand.c
@@ -1146,11 +1146,11 @@ static int copy_role_allows(expand_state_t * state, role_allow_rule_t * rules)
 
 static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 {
-	unsigned int i, j;
+	unsigned int i, j, k;
 	role_trans_t *n, *l, *cur_trans;
 	role_trans_rule_t *cur;
 	ebitmap_t roles, types;
-	ebitmap_node_t *rnode, *tnode;
+	ebitmap_node_t *rnode, *tnode, *cnode;
 
 	/* start at the end of the list */
 	for (l = state->out->role_tr; l && l->next; l = l->next) ;
@@ -1175,51 +1175,57 @@ static int copy_role_trans(expand_state_t * state, role_trans_rule_t * rules)
 			ebitmap_for_each_bit(&types, tnode, j) {
 				if (!ebitmap_node_get_bit(tnode, j))
 					continue;
+				ebitmap_for_each_bit(&cur->classes, cnode, k) {
+					if (!ebitmap_node_get_bit(cnode, k))
+						continue;
 
-				cur_trans = state->out->role_tr;
-				while (cur_trans) {
-					if ((cur_trans->role == i + 1) &&
-					    (cur_trans->type == j + 1)) {
-						if (cur_trans->new_role ==
-						    cur->new_role) {
-							break;
-						} else {
-							ERR(state->handle,
-							    "Conflicting role trans rule %s %s : %s",
-							    state->out->
-							    p_role_val_to_name
-							    [i],
-							    state->out->
-							    p_type_val_to_name
-							    [j],
-							    state->out->
-							    p_role_val_to_name
-							    [cur->new_role -
-							     1]);
-							return -1;
+					cur_trans = state->out->role_tr;
+					while (cur_trans) {
+						if ((cur_trans->role ==
+								i + 1) &&
+						    (cur_trans->type ==
+								j + 1) &&
+						    (cur_trans->classes ==
+								k + 1)) {
+							if (cur_trans->
+							    new_role ==
+								cur->new_role) {
+								break;
+							} else {
+								ERR(state->handle,
+									"Conflicting role trans rule %s %s : %s %s",
+									state->out->p_role_val_to_name[i],
+									state->out->p_type_val_to_name[j],
+									state->out->p_class_val_to_name[k],
+									state->out->p_role_val_to_name[cur->new_role - 1]);
+								return -1;
+							}
 						}
+						cur_trans = cur_trans->next;
 					}
-					cur_trans = cur_trans->next;
-				}
-				if (cur_trans)
-					continue;
+					if (cur_trans)
+						continue;
 
-				n = (role_trans_t *)
-				    malloc(sizeof(role_trans_t));
-				if (!n) {
-					ERR(state->handle, "Out of memory!");
-					return -1;
-				}
-				memset(n, 0, sizeof(role_trans_t));
-				n->role = i + 1;
-				n->type = j + 1;
-				n->new_role = state->rolemap[cur->new_role - 1];
-				if (l) {
-					l->next = n;
-				} else {
-					state->out->role_tr = n;
+					n = (role_trans_t *)
+						malloc(sizeof(role_trans_t));
+					if (!n) {
+						ERR(state->handle,
+							"Out of memory!");
+						return -1;
+					}
+					memset(n, 0, sizeof(role_trans_t));
+					n->role = i + 1;
+					n->type = j + 1;
+					n->classes = k + 1;
+					n->new_role = state->rolemap
+							[cur->new_role - 1];
+					if (l)
+						l->next = n;
+					else
+						state->out->role_tr = n;
+
+					l = n;
 				}
-				l = n;
 			}
 		}
 
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index d03e599..e33db0f 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1246,6 +1246,8 @@ static int copy_role_trans_list(role_trans_rule_t * list,
 				policy_module_t * module, link_state_t * state)
 {
 	role_trans_rule_t *cur, *new_rule = NULL, *tail;
+	unsigned int i;
+	ebitmap_node_t *cnode;
 
 	cur = list;
 	tail = *dst;
@@ -1267,6 +1269,18 @@ static int copy_role_trans_list(role_trans_rule_t * list,
 			goto cleanup;
 		}
 
+		ebitmap_for_each_bit(&cur->classes, cnode, i) {
+			if (ebitmap_node_get_bit(cnode, i)) {
+				assert(module->map[SYM_CLASSES][i]);
+				if (ebitmap_set_bit(&new_rule->classes,
+						    module->
+						    map[SYM_CLASSES][i] - 1,
+						    1)) {
+					goto cleanup;
+				}
+			}
+		}
+
 		new_rule->new_role = module->map[SYM_ROLES][cur->new_role - 1];
 
 		if (*dst == NULL) {
diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index d0bfbaf..90c2086 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -434,6 +434,7 @@ void role_trans_rule_init(role_trans_rule_t * x)
 	memset(x, 0, sizeof(*x));
 	role_set_init(&x->roles);
 	type_set_init(&x->types);
+	ebitmap_init(&x->classes);
 }
 
 void role_trans_rule_destroy(role_trans_rule_t * x)
@@ -441,6 +442,7 @@ void role_trans_rule_destroy(role_trans_rule_t * x)
 	if (x != NULL) {
 		role_set_destroy(&x->roles);
 		type_set_destroy(&x->types);
+		ebitmap_destroy(&x->classes);
 	}
 }
 
@@ -2956,6 +2958,9 @@ static int role_trans_rule_read(role_trans_rule_t ** r, struct policy_file *fp)
 		if (type_set_read(&tr->types, fp))
 			return -1;
 
+		if (ebitmap_read(&tr->classes, fp))
+			return -1;
+
 		rc = next_entry(buf, fp, sizeof(uint32_t));
 		if (rc < 0)
 			return -1;
diff --git a/libsepol/src/write.c b/libsepol/src/write.c
index 760b498..5cd460e 100644
--- a/libsepol/src/write.c
+++ b/libsepol/src/write.c
@@ -1464,6 +1464,8 @@ static int role_trans_rule_write(role_trans_rule_t * t, struct policy_file *fp)
 			return POLICYDB_ERROR;
 		if (type_set_write(&tr->types, fp))
 			return POLICYDB_ERROR;
+		if (ebitmap_write(&tr->classes, fp))
+			return POLICYDB_ERROR;
 		buf[0] = cpu_to_le32(tr->new_role);
 		items = put_entry(buf, sizeof(uint32_t), 1, fp);
 		if (items != 1)
-- 
1.7.0.4


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
