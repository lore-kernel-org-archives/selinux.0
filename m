Subject: [RFC] libsepol: allow genfscon statements in modules
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, dwalsh@redhat.com, method@manicmethod.com,
        tmiller@tresys.com
Content-Type: text/plain
Date: Mon, 05 May 2008 16:36:47 -0400
Message-Id: <1210019807.3089.22.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dan wants to be able to give types to booleans declared in modules.
Since /selinux uses genfscon for its labeling we need to move the
ability to declare such statements in modules.

Interesting things to notice is that inside the module we have no way to
validate if the complete context is valid so I delay that checking until
link time.

This could be the first step on the path to allowing other things which
use full contexts (fs_uses) in modules.

Anyway, attack at will.  I still need to do more testing.  I haven't
tested to verify that sorting is correct in the base policy, that things
work if there are more than 1 FS in the base policy, or that we are
inserting the shortest path from a module.  I'll test all of those
before post a final.

-Eric

---
 src/link.c     |  197 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 src/policydb.c |   25 ++++---
 2 files changed, 210 insertions(+), 12 deletions(-)

diff -Naupr libsepol-2.0.26.orig/src/link.c libsepol-2.0.26/src/link.c
--- libsepol-2.0.26.orig/src/link.c	2008-03-27 13:20:03.000000000 -0400
+++ libsepol-2.0.26/src/link.c	2008-05-05 16:08:23.000000000 -0400
@@ -34,6 +34,7 @@
 #include <assert.h>
 
 #include "debug.h"
+#include "context.h"
 
 #undef min
 #define min(a,b) (((a) < (b)) ? (a) : (b))
@@ -864,6 +865,10 @@ static int mls_level_convert(mls_semanti
 	if (!mod->policy->mls)
 		return 0;
 
+	/* Required not declared. */
+	if (!src->sens)
+		return 0;
+
 	assert(mod->map[SYM_LEVELS][src->sens - 1]);
 	dst->sens = mod->map[SYM_LEVELS][src->sens - 1];
 
@@ -2120,6 +2125,183 @@ static int prepare_base(link_state_t * s
 	return 0;
 }
 
+static int context_copy_and_validate(link_state_t *state, context_struct_t *dst, context_struct_t *src)
+{
+	user_datum_t *base_user_datum;
+	role_datum_t *base_role_datum;
+	type_datum_t *base_type_datum;
+	char *key;
+	int ret;
+
+	key = state->cur->policy->p_user_val_to_name[src->user - 1];
+	base_user_datum = hashtab_search(state->base->p_users.table, key);
+	dst->user = base_user_datum->s.value;
+
+	key = state->cur->policy->p_role_val_to_name[src->role - 1];
+	base_role_datum = hashtab_search(state->base->p_roles.table, key);
+	dst->role = base_role_datum->s.value;
+
+	key = state->cur->policy->p_type_val_to_name[src->type - 1];
+	base_type_datum = hashtab_search(state->base->p_types.table, key);
+	dst->type = base_type_datum->s.value;
+
+	ret = mls_context_cpy(dst, src);
+	if (ret)
+		return ret;
+
+	return context_is_valid(state->base, dst);
+}
+
+/* merge 2 genfs sets with the same fstype */
+static int genfs_merge(link_state_t *state, genfs_t *genfs, genfs_t *base_genfs)
+{
+	ocontext_t *con, *next_con, *base_con, *prev;
+	int cmp;
+
+	assert(!strcmp(genfs->fstype, base_genfs->fstype));
+
+
+	for(con = genfs->head; con; con = next_con) {
+		next_con = con->next;
+		base_con = base_genfs->head;
+		if (!base_con) {
+			base_genfs->head = con;
+			continue;
+		}
+		cmp = strcmp(con->u.name, base_con->u.name);
+		if (cmp < 0) {
+			con->next = base_con;
+			base_genfs->head = con;
+			continue;
+		} else if (cmp == 0)
+			goto merge;
+
+		/* walk the list until we either need to insert between base_con
+		 * and base_con->next or bomb cause of double/conflicting */
+		while (base_con->next && (strcmp(con->u.name, base_con->next->u.name) > 0))
+			base_con = base_con->next;
+
+		/* insert between base_con and base_con->next */
+		if (!base_con->next || (strcmp(con->u.name, base_con->next->u.name) < 0)) {
+			con->next = base_con->next;
+			base_con->next = con;
+			continue;
+		}
+
+		/* so now the fstype and the path are the same, so keep digging... */
+		base_con = base_con->next;
+merge:
+		if (!con->v.sclass || !base_con->v.sclass || con->v.sclass == base_con->v.sclass) {
+			ERR(state->handle, "dup genfs entry (%s,%s)", genfs->fstype, con->u.name);
+			/* everything earlier in the list is now associated with
+			 * the base genfs, so we need to leave all of it alone and
+			 * let it get freed naturaly when we tear down the base.
+			 */
+			while (con) {
+				free(con->u.name);
+				prev = con;
+				con = con->next;
+				free(prev);
+			}
+			free(genfs->fstype);
+			free(genfs);
+			return -1;
+		}
+		con->next = base_con->next;
+		base_con->next = con;
+	}
+	/* free these since we are using the genfs and fstype already in the base */
+	free(genfs->fstype);
+	free(genfs);
+	return 0;
+}
+
+/* so this is going to merge genfs info from modules into the base policy */
+static int genfs_context_copy_helper(link_state_t *state)
+{
+	ocontext_t *c, *newc, *l;
+	genfs_t *genfs, *newgenfs, *base_genfs;
+	int cmp;
+
+	for (genfs = state->cur->policy->genfs; genfs; genfs = genfs->next) {
+		/* build a newgenfs, we might free peices and parts
+		 * later if the base already had them */
+		newgenfs = calloc(1, sizeof(genfs_t));
+		if (!newgenfs) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+		newgenfs->fstype = strdup(genfs->fstype);
+		if (!newgenfs->fstype) {
+			ERR(state->handle, "Out of memory!");
+			return -1;
+		}
+
+		l = NULL;
+		for (c = genfs->head; c; c = c->next) {
+			newc = calloc(1, sizeof(ocontext_t));
+			if (!newc) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
+			newc->u.name = strdup(c->u.name);
+			if (!newc->u.name) {
+				ERR(state->handle, "Out of memory!");
+				return -1;
+			}
+			newc->v.sclass = c->v.sclass;
+			context_copy_and_validate(state, &newc->context[0], &c->context[0]);
+
+			if (l)
+				l->next = newc;
+			else
+				newgenfs->head = newc;
+			l = newc;
+		}
+
+		base_genfs = state->base->genfs;
+		/* base had no genfs, insert at front */
+		if (!base_genfs) {
+			state->base->genfs = newgenfs;
+			continue;
+		}
+		/* first base entry is after this entry, insert at front */
+		cmp = strcmp(newgenfs->fstype, base_genfs->fstype);
+		if (cmp < 0) {
+			newgenfs->next = base_genfs;
+			state->base->genfs = newgenfs;
+			continue;
+		} else if (cmp == 0) {
+			/* merge with head of list */
+			int ret = genfs_merge(state, newgenfs, base_genfs);
+			/* genfs_merge freed stuff if it blew up... */
+			if (ret)
+				return ret;
+			continue;
+		}
+		/* move down the list until we either need to be inserted between
+		 * base_genfs and base_genfs->next or we need to merge with
+		 * base_genfs->next */
+		while (base_genfs->next && (strcmp(newgenfs->fstype, base_genfs->next->fstype) > 0))
+			base_genfs = base_genfs->next;
+		/* insert between if appropiete */
+		if (!base_genfs->next || (strcmp(newgenfs->fstype, base_genfs->next->fstype) < 0)) {
+			newgenfs->next = base_genfs->next;
+			base_genfs->next = newgenfs;
+			continue;
+		}
+		/* this is the fun part, merge..... */
+		if (strcmp(newgenfs->fstype, base_genfs->next->fstype) == 0) {
+			int ret = genfs_merge(state, newgenfs, base_genfs->next);
+			/* genfs_merge freed stuff if it blew up... */
+			if (ret)
+				return ret;
+		} else
+			assert(1);
+	}
+	return 0;
+}
+
 /* Link a set of modules into a base module. This process is somewhat
  * similar to an actual compiler: it requires a set of order dependent
  * steps.  The base and every module must have been indexed prior to
@@ -2202,8 +2384,19 @@ int link_modules(sepol_handle_t * handle
 	for (i = 0; i < len; i++) {
 		state.cur = modules[i];
 		state.cur_mod_name = modules[i]->policy->name;
-		ret =
-		    copy_identifiers(&state, modules[i]->policy->symtab, NULL);
+		ret = copy_identifiers(&state, modules[i]->policy->symtab, NULL);
+		if (ret) {
+			retval = ret;
+			goto cleanup;
+		}
+	}
+
+	/* copy genfs_context stuff into base */
+	for (i = 0; i < len; i++) {
+		state.cur = modules[i];
+		state.cur_mod_name = modules[i]->policy->name;
+
+		ret = genfs_context_copy_helper(&state);
 		if (ret) {
 			retval = ret;
 			goto cleanup;
diff -Naupr libsepol-2.0.26.orig/src/policydb.c libsepol-2.0.26/src/policydb.c
--- libsepol-2.0.26.orig/src/policydb.c	2008-03-27 13:20:03.000000000 -0400
+++ libsepol-2.0.26/src/policydb.c	2008-05-05 16:11:26.000000000 -0400
@@ -1564,7 +1564,8 @@ static int mls_range_to_semantic(mls_ran
  * from a policydb binary representation file.
  */
 static int context_read_and_validate(context_struct_t * c,
-				     policydb_t * p, struct policy_file *fp)
+				     policydb_t * p, struct policy_file *fp,
+				     uint32_t validate)
 {
 	uint32_t buf[3];
 	int rc;
@@ -1588,7 +1589,7 @@ static int context_read_and_validate(con
 		}
 	}
 
-	if (!policydb_context_isvalid(p, c)) {
+	if (validate && !policydb_context_isvalid(p, c)) {
 		ERR(fp->handle, "invalid security context");
 		context_destroy(c);
 		return -1;
@@ -2076,7 +2077,7 @@ static int ocontext_read(struct policydb
 					return -1;
 				c->sid[0] = le32_to_cpu(buf[0]);
 				if (context_read_and_validate
-				    (&c->context[0], p, fp))
+				    (&c->context[0], p, fp, 1))
 					return -1;
 				break;
 			case OCON_FS:
@@ -2093,10 +2094,10 @@ static int ocontext_read(struct policydb
 					return -1;
 				c->u.name[len] = 0;
 				if (context_read_and_validate
-				    (&c->context[0], p, fp))
+				    (&c->context[0], p, fp, 1))
 					return -1;
 				if (context_read_and_validate
-				    (&c->context[1], p, fp))
+				    (&c->context[1], p, fp, 1))
 					return -1;
 				break;
 			case OCON_PORT:
@@ -2107,7 +2108,7 @@ static int ocontext_read(struct policydb
 				c->u.port.low_port = le32_to_cpu(buf[1]);
 				c->u.port.high_port = le32_to_cpu(buf[2]);
 				if (context_read_and_validate
-				    (&c->context[0], p, fp))
+				    (&c->context[0], p, fp, 1))
 					return -1;
 				break;
 			case OCON_NODE:
@@ -2117,7 +2118,7 @@ static int ocontext_read(struct policydb
 				c->u.node.addr = le32_to_cpu(buf[0]);
 				c->u.node.mask = le32_to_cpu(buf[1]);
 				if (context_read_and_validate
-				    (&c->context[0], p, fp))
+				    (&c->context[0], p, fp, 1))
 					return -1;
 				break;
 			case OCON_FSUSE:
@@ -2134,7 +2135,7 @@ static int ocontext_read(struct policydb
 					return -1;
 				c->u.name[len] = 0;
 				if (context_read_and_validate
-				    (&c->context[0], p, fp))
+				    (&c->context[0], p, fp, 1))
 					return -1;
 				break;
 			case OCON_NODE6:{
@@ -2151,7 +2152,7 @@ static int ocontext_read(struct policydb
 						c->u.node6.mask[k] =
 						    le32_to_cpu(buf[k + 4]);
 					if (context_read_and_validate
-					    (&c->context[0], p, fp))
+					    (&c->context[0], p, fp, 1))
 						return -1;
 					break;
 				}
@@ -2173,6 +2174,10 @@ static int genfs_read(policydb_t * p, st
 	ocontext_t *l, *c, *newc = NULL;
 	int rc;
 
+	/* don't validate full contexts in modules, will do that at link
+	 * time later */
+	int validate = (p->policy_type != POLICY_MOD);
+
 	rc = next_entry(buf, fp, sizeof(uint32_t));
 	if (rc < 0)
 		goto bad;
@@ -2240,7 +2245,7 @@ static int genfs_read(policydb_t * p, st
 			if (rc < 0)
 				goto bad;
 			newc->v.sclass = le32_to_cpu(buf[0]);
-			if (context_read_and_validate(&newc->context[0], p, fp))
+			if (context_read_and_validate(&newc->context[0], p, fp, validate))
 				goto bad;
 			for (l = NULL, c = newgenfs->head; c;
 			     l = c, c = c->next) {



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
