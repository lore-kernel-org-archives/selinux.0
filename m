Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m46F9Wtl014381
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 11:09:32 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m46F9UF5013298
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 15:09:30 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m46F9TFv014037
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 11:09:30 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m46F9Tvj032042
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 11:09:29 -0400
Received: from [10.11.14.254] (vpn-14-254.rdu.redhat.com [10.11.14.254])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m46F9S8w028015
	for <selinux@tycho.nsa.gov>; Tue, 6 May 2008 11:09:28 -0400
Subject: [RFC-v2] libsepol and checkpolicy: make genfs statements valid in
	modules
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-Mf1tPgS5HBhBZFp9AYOS"
Date: Tue, 06 May 2008 11:09:28 -0400
Message-Id: <1210086568.6771.21.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Mf1tPgS5HBhBZFp9AYOS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch fixes some sorting issues from the previous patch and appears
to work!  This one should be ready for testing, comments, review....

Anyway given a module with:
genfscon proc /paris4444	user_u:role_r:type2_t:s0
genfscon proc /			user_u:role_r:type2_t:s0
genfscon proc /paris333		user_u:role_r:type2_t:s0
genfscon proc /paris1		user_u:role_r:type2_t:s0
genfscon proc /paris22		user_u:role_r:type2_t:s0

genfscon a /22		user_u:role_r:type2_t:s0
genfscon a /1		user_u:role_r:type2_t:s0
genfscon a /333		user_u:role_r:type2_t:s0

genfscon z /1		user_u:role_r:type2_t:s0
genfscon z /333		user_u:role_r:type2_t:s0

And a base policy with:
genfscon proc /par	user_u:role_r:type1_t:s0
genfscon proc /paris	user_u:role_r:type1_t:s0
genfscon proc /pari	user_u:role_r:type1_t:s0


genfscon b /333	user_u:role_r:type1_t:s0
genfscon b /22	user_u:role_r:type1_t:s0
genfscon b /1	user_u:role_r:type1_t:s0


genfscon y /22	user_u:role_r:type1_t:s0
genfscon y /333	user_u:role_r:type1_t:s0
genfscon y /1	user_u:role_r:type1_t:s0

The final linked policy genfs looks like:
Command ('m' for menu):  g
genfs_context: fs=a
	/333                            	0	user_u:role_r:type2_t
	/22                             	0	user_u:role_r:type2_t
	/1                              	0	user_u:role_r:type2_t
genfs_context: fs=b
	/333                            	0	user_u:role_r:type1_t
	/22                             	0	user_u:role_r:type1_t
	/1                              	0	user_u:role_r:type1_t
genfs_context: fs=proc
	/paris4444                      	0	user_u:role_r:type2_t
	/paris333                       	0	user_u:role_r:type2_t
	/paris22                        	0	user_u:role_r:type2_t
	/paris1                         	0	user_u:role_r:type2_t
	/paris                          	0	user_u:role_r:type1_t
	/pari                           	0	user_u:role_r:type1_t
	/par                            	0	user_u:role_r:type1_t
	/                               	0	user_u:role_r:type2_t
genfs_context: fs=y
	/333                            	0	user_u:role_r:type1_t
	/22                             	0	user_u:role_r:type1_t
	/1                              	0	user_u:role_r:type1_t
genfs_context: fs=z
	/333                            	0	user_u:role_r:type2_t
	/1                              	0	user_u:role_r:type2_t

Which looks just great to me.....

-Eric


--=-Mf1tPgS5HBhBZFp9AYOS
Content-Disposition: attachment; filename=libsepol.patch
Content-Type: text/x-patch; name=libsepol.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naupr libsepol-2.0.26.orig/src/link.c libsepol-2.0.26/src/link.c
--- libsepol-2.0.26.orig/src/link.c	2008-03-27 13:20:03.000000000 -0400
+++ libsepol-2.0.26/src/link.c	2008-05-06 11:01:22.000000000 -0400
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
+		if (cmp > 0) {
+			con->next = base_con;
+			base_genfs->head = con;
+			continue;
+		} else if (cmp == 0)
+			goto merge;
+
+		/* walk the list until we either need to insert between base_con
+		 * and base_con->next or bomb cause of double/conflicting */
+		while (base_con->next && (strcmp(con->u.name, base_con->next->u.name) < 0))
+			base_con = base_con->next;
+
+		/* insert between base_con and base_con->next */
+		if (!base_con->next || (strcmp(con->u.name, base_con->next->u.name) > 0)) {
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

--=-Mf1tPgS5HBhBZFp9AYOS
Content-Disposition: attachment; filename=checkpolicy.patch
Content-Type: text/x-patch; name=checkpolicy.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naupr checkpolicy-2.0.14.orig/policy_define.c checkpolicy-2.0.14/policy_define.c
--- checkpolicy-2.0.14.orig/policy_define.c	2008-04-14 15:33:41.000000000 -0400
+++ checkpolicy-2.0.14/policy_define.c	2008-05-05 16:19:07.000000000 -0400
@@ -68,7 +68,6 @@ extern int yyerror(char *msg);
 static char errormsg[ERRORMSG_LEN + 1] = {0};
 
 static int id_has_dot(char *id);
-static int parse_security_context(context_struct_t *c);
 
 /* initialize all of the state variables for the scanner/parser */
 void init_parser(int pass_number)
@@ -3008,7 +3007,7 @@ int define_user(void)
 	return 0;
 }
 
-static int parse_security_context(context_struct_t * c)
+static int parse_security_context(context_struct_t * c, uint32_t check_valid)
 {
 	char *id;
 	role_datum_t *role;
@@ -3160,7 +3159,7 @@ static int parse_security_context(contex
 		}
 	}
 
-	if (!policydb_context_isvalid(policydbp, c)) {
+	if (check_valid && !policydb_context_isvalid(policydbp, c)) {
 		yyerror("invalid security context");
 		goto bad;
 	}
@@ -3180,7 +3179,7 @@ int define_initial_sid_context(void)
 	if (pass == 1) {
 		id = (char *)queue_remove(id_queue);
 		free(id);
-		parse_security_context(NULL);
+		parse_security_context(NULL, 1);
 		return 0;
 	}
 
@@ -3208,7 +3207,7 @@ int define_initial_sid_context(void)
 	/* no need to keep the sid name */
 	free(id);
 
-	if (parse_security_context(&c->context[0]))
+	if (parse_security_context(&c->context[0], 1))
 		return -1;
 
 	return 0;
@@ -3219,8 +3218,8 @@ int define_fs_context(unsigned int major
 	ocontext_t *newc, *c, *head;
 
 	if (pass == 1) {
-		parse_security_context(NULL);
-		parse_security_context(NULL);
+		parse_security_context(NULL, 1);
+		parse_security_context(NULL, 1);
 		return 0;
 	}
 
@@ -3239,12 +3238,12 @@ int define_fs_context(unsigned int major
 	}
 	sprintf(newc->u.name, "%02x:%02x", major, minor);
 
-	if (parse_security_context(&newc->context[0])) {
+	if (parse_security_context(&newc->context[0], 1)) {
 		free(newc->u.name);
 		free(newc);
 		return -1;
 	}
-	if (parse_security_context(&newc->context[1])) {
+	if (parse_security_context(&newc->context[1], 1)) {
 		context_destroy(&newc->context[0]);
 		free(newc->u.name);
 		free(newc);
@@ -3279,7 +3278,7 @@ int define_port_context(unsigned int low
 	if (pass == 1) {
 		id = (char *)queue_remove(id_queue);
 		free(id);
-		parse_security_context(NULL);
+		parse_security_context(NULL, 1);
 		return 0;
 	}
 
@@ -3315,7 +3314,7 @@ int define_port_context(unsigned int low
 		return -1;
 	}
 
-	if (parse_security_context(&newc->context[0])) {
+	if (parse_security_context(&newc->context[0], 1)) {
 		free(newc);
 		return -1;
 	}
@@ -3360,8 +3359,8 @@ int define_netif_context(void)
 
 	if (pass == 1) {
 		free(queue_remove(id_queue));
-		parse_security_context(NULL);
-		parse_security_context(NULL);
+		parse_security_context(NULL, 1);
+		parse_security_context(NULL, 1);
 		return 0;
 	}
 
@@ -3377,12 +3376,12 @@ int define_netif_context(void)
 		free(newc);
 		return -1;
 	}
-	if (parse_security_context(&newc->context[0])) {
+	if (parse_security_context(&newc->context[0], 1)) {
 		free(newc->u.name);
 		free(newc);
 		return -1;
 	}
-	if (parse_security_context(&newc->context[1])) {
+	if (parse_security_context(&newc->context[1], 1)) {
 		context_destroy(&newc->context[0]);
 		free(newc->u.name);
 		free(newc);
@@ -3417,7 +3416,7 @@ int define_ipv4_node_context()
 	if (pass == 1) {
 		free(queue_remove(id_queue));
 		free(queue_remove(id_queue));
-		parse_security_context(NULL);
+		parse_security_context(NULL, 1);
 		goto out;
 	}
 
@@ -3464,7 +3463,7 @@ int define_ipv4_node_context()
 	newc->u.node.addr = addr.s_addr;
 	newc->u.node.mask = mask.s_addr;
 
-	if (parse_security_context(&newc->context[0])) {
+	if (parse_security_context(&newc->context[0], 1)) {
 		free(newc);
 		return -1;
 	}
@@ -3498,7 +3497,7 @@ int define_ipv6_node_context(void)
 	if (pass == 1) {
 		free(queue_remove(id_queue));
 		free(queue_remove(id_queue));
-		parse_security_context(NULL);
+		parse_security_context(NULL, 1);
 		goto out;
 	}
 
@@ -3545,7 +3544,7 @@ int define_ipv6_node_context(void)
 	memcpy(&newc->u.node6.addr[0], &addr.s6_addr32[0], 16);
 	memcpy(&newc->u.node6.mask[0], &mask.s6_addr32[0], 16);
 
-	if (parse_security_context(&newc->context[0])) {
+	if (parse_security_context(&newc->context[0], 1)) {
 		free(newc);
 		rc = -1;
 		goto out;
@@ -3577,7 +3576,7 @@ int define_fs_use(int behavior)
 
 	if (pass == 1) {
 		free(queue_remove(id_queue));
-		parse_security_context(NULL);
+		parse_security_context(NULL, 1);
 		return 0;
 	}
 
@@ -3594,7 +3593,7 @@ int define_fs_use(int behavior)
 		return -1;
 	}
 	newc->v.behavior = behavior;
-	if (parse_security_context(&newc->context[0])) {
+	if (parse_security_context(&newc->context[0], 1)) {
 		free(newc->u.name);
 		free(newc);
 		return -1;
@@ -3624,13 +3623,14 @@ int define_genfs_context_helper(char *fs
 	ocontext_t *newc, *c, *head, *p;
 	char *type = NULL;
 	int len, len2;
+	uint32_t check_valid;
 
 	if (pass == 1) {
 		free(fstype);
 		free(queue_remove(id_queue));
 		if (has_type)
 			free(queue_remove(id_queue));
-		parse_security_context(NULL);
+		parse_security_context(NULL, 0);
 		return 0;
 	}
 
@@ -3701,7 +3701,11 @@ int define_genfs_context_helper(char *fs
 			goto fail;
 		}
 	}
-	if (parse_security_context(&newc->context[0]))
+	if (policydbp->policy_type == POLICY_MOD)
+		check_valid = 0;
+	else
+		check_valid = 1;
+	if (parse_security_context(&newc->context[0], check_valid))
 		goto fail;
 
 	head = genfs->head;
diff -Naupr checkpolicy-2.0.14.orig/policy_parse.y checkpolicy-2.0.14/policy_parse.y
--- checkpolicy-2.0.14.orig/policy_parse.y	2008-04-14 15:33:41.000000000 -0400
+++ checkpolicy-2.0.14/policy_parse.y	2008-05-06 09:41:16.000000000 -0400
@@ -612,12 +612,12 @@ fs_use_def              : FSUSEXATTR ide
                         | FSUSETRANS identifier security_context_def ';'
                         {if (define_fs_use(SECURITY_FS_USE_TRANS)) return -1;}
                         ;
-opt_genfs_contexts      : genfs_contexts
-                        |
-                        ;
-genfs_contexts          : genfs_context_def
-                        | genfs_contexts genfs_context_def
-                        ;
+opt_genfs_contexts	: genfs_context_defs
+			| /* empty */
+			;
+genfs_context_defs	: genfs_context_defs genfs_context_def
+			| genfs_context_def
+			;
 genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
 			{if (define_genfs_context(1)) return -1;}
 			| GENFSCON identifier path '-' '-' {insert_id("-", 0);} security_context_def
@@ -734,6 +734,7 @@ avrule_decl             : rbac_decl
                         | cond_stmt_def
                         | require_block
                         | optional_block
+			| genfs_context_defs
                         | ';'
                         ;
 require_block           : REQUIRE '{' require_list '}'
@@ -775,6 +776,6 @@ optional_decl           : OPTIONAL
 else_decl               : ELSE
                         { if (begin_optional_else(pass) == -1) return -1; }
                         ;
-avrule_user_defs        : user_def avrule_user_defs
-                        | /* empty */
+avrule_user_defs	: user_def avrule_user_defs
+			| /* empty */
                         ;
diff -Naupr checkpolicy-2.0.14.orig/test/dismod.c checkpolicy-2.0.14/test/dismod.c
--- checkpolicy-2.0.14.orig/test/dismod.c	2008-04-14 15:33:41.000000000 -0400
+++ checkpolicy-2.0.14/test/dismod.c	2008-05-06 11:01:31.000000000 -0400
@@ -787,6 +787,32 @@ static void display_policycaps(policydb_
 	}
 }
 
+static void display_context(policydb_t *p, context_struct_t *context, FILE *fp)
+{
+	char *user, *role, *type;
+	user = p->p_user_val_to_name[context->user - 1];
+	role = p->p_role_val_to_name[context->role - 1];
+	type = p->p_type_val_to_name[context->type - 1];
+	fprintf(fp, "%s:%s:%s", user, role, type);
+}
+
+static void display_genfs_context(policydb_t *p, FILE *fp)
+{
+	genfs_t *genfs = p->genfs;
+	ocontext_t *context;
+	while (genfs) {
+		fprintf(fp, "genfs_context: fs=%s\n", genfs->fstype);
+		context = genfs->head;
+		while (context) {
+			fprintf(fp, "\t%-32s\t%d\t", context->u.name, context->v.sclass);
+			display_context(p, &context->context[0], fp);
+			fprintf(fp, "\n");
+			context = context->next;
+		}
+		genfs = genfs->next;
+	}
+}
+
 int menu()
 {
 	printf("\nSelect a command:\n");
@@ -804,6 +830,7 @@ int menu()
 	printf("a)  Display avrule requirements\n");
 	printf("b)  Display avrule declarations\n");
 	printf("c)  Display policy capabilities\n");
+	printf("g)  Display genfs_context entries\n");
 	printf("l)  Link in a module\n");
 	printf("u)  Display the unknown handling setting\n");
 	printf("\n");
@@ -936,6 +963,10 @@ int main(int argc, char **argv)
 			if (out_fp != stdout)
 				printf("\nOutput to file: %s\n", OutfileName);
 			break;
+		case 'g':
+		case 'G':
+			display_genfs_context(&policydb, out_fp);
+			break;
 		case 'l':
 			link_module(&policydb, out_fp);
 			break;
diff -Naupr checkpolicy-2.0.14.orig/test/dispol.c checkpolicy-2.0.14/test/dispol.c
--- checkpolicy-2.0.14.orig/test/dispol.c	2008-04-14 15:33:41.000000000 -0400
+++ checkpolicy-2.0.14/test/dispol.c	2008-04-30 16:24:08.000000000 -0400
@@ -319,6 +319,31 @@ static void display_policycaps(policydb_
 	}
 }
 
+static void display_context(policydb_t *p, context_struct_t *context, FILE *fp)
+{
+	char *user, *role, *type;
+	user = p->p_user_val_to_name[context->user - 1];
+	role = p->p_role_val_to_name[context->role - 1];
+	type = p->p_type_val_to_name[context->type - 1];
+	fprintf(fp, "%s:%s:%s\n", user, role, type);
+}
+static void display_genfs_context(policydb_t *p, FILE *fp)
+{
+	genfs_t *genfs = p->genfs;
+	ocontext_t *context;
+	while (genfs) {
+		fprintf(fp, "genfs_context: fs=%s\n", genfs->fstype);
+		context = genfs->head;
+		while (context) {
+			fprintf(fp, "\t%s%16d\t", context->u.name, context->v.sclass);
+			display_context(p, &context->context[0], fp);
+			fprintf(fp, "\n");
+			context = context->next;
+		}
+		genfs = genfs->next;
+	}
+}
+
 static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
 		       uint32_t symbol_value, char *prefix)
 {
@@ -353,6 +378,7 @@ int menu()
 	printf("7)  change a boolean value\n");
 	printf("\n");
 	printf("c)  display policy capabilities\n");
+	printf("g)  display all genfs_context entries\n");
 	printf("p)  display the list of permissive types\n");
 	printf("u)  display unknown handling setting\n");
 	printf("f)  set output file\n");
@@ -470,6 +496,9 @@ int main(int argc, char **argv)
 		case 'c':
 			display_policycaps(&policydb, out_fp);
 			break;
+		case 'g':
+			display_genfs_context(&policydb, out_fp);
+			break;
 		case 'p':
 			display_permissive(&policydb, out_fp);
 			break;

--=-Mf1tPgS5HBhBZFp9AYOS--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
