From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 12/13] SELinux: services.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:33 -0400
Message-Id: <12085547143470-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547143694-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
 <12085547141335-git-send-email-eparis@redhat.com>
 <12085547141160-git-send-email-eparis@redhat.com>
 <12085547142556-git-send-email-eparis@redhat.com>
 <12085547141952-git-send-email-eparis@redhat.com>
 <1208554714873-git-send-email-eparis@redhat.com>
 <12085547143694-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes services.c to fix whitespace and syntax issues.  Things that
are fixed may include (does not not have to include)

whitespace at end of lines
spaces followed by tabs
spaces used instead of tabs
spacing around parenthesis
locateion of { around struct and else clauses
location of * in pointer declarations
removal of initialization of static data to keep it in the right section
useless {} in if statemetns
useless checking for NULL before kfree
fixing of the indentation depth of switch statements
and any number of other things I forgot to mention

Signed-off-by: Eric Paris <eparis@redhat.com>

---
 security/selinux/ss/services.c |  131 +++++++++++++++++++---------------------
 1 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 0079889..ff2d65b 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -2,7 +2,7 @@
  * Implementation of the security services.
  *
  * Authors : Stephen Smalley, <sds@epoch.ncsc.mil>
- *           James Morris <jmorris@redhat.com>
+ *	     James Morris <jmorris@redhat.com>
  *
  * Updated: Trusted Computer Solutions, Inc. <dgoeddel@trustedcs.com>
  *
@@ -11,7 +11,7 @@
  *
  * Updated: Frank Mayer <mayerf@tresys.com> and Karl MacMillan <kmacmillan@tresys.com>
  *
- * 	Added conditional policy language extensions
+ *	Added conditional policy language extensions
  *
  * Updated: Hewlett-Packard <paul.moore@hp.com>
  *
@@ -27,7 +27,7 @@
  * Copyright (C) 2003 - 2004, 2006 Tresys Technology, LLC
  * Copyright (C) 2003 Red Hat, Inc., James Morris <jmorris@redhat.com>
  *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
+ *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  */
 #include <linux/kernel.h>
@@ -81,7 +81,7 @@ static DEFINE_MUTEX(load_mutex);
 
 static struct sidtab sidtab;
 struct policydb policydb;
-int ss_initialized = 0;
+int ss_initialized;
 
 /*
  * The largest sequence number that has been used when
@@ -89,7 +89,7 @@ int ss_initialized = 0;
  * The sequence number only changes when a policy change
  * occurs.
  */
-static u32 latest_granting = 0;
+static u32 latest_granting;
 
 /* Forward declaration. */
 static int context_struct_to_string(struct context *context, char **scontext,
@@ -162,10 +162,10 @@ static int constraint_expr_eval(struct context *scontext,
 								  val1 - 1);
 					continue;
 				case CEXPR_INCOMP:
-					s[++sp] = ( !ebitmap_get_bit(&r1->dominates,
-								     val2 - 1) &&
-						    !ebitmap_get_bit(&r2->dominates,
-								     val1 - 1) );
+					s[++sp] = (!ebitmap_get_bit(&r1->dominates,
+								    val2 - 1) &&
+						   !ebitmap_get_bit(&r2->dominates,
+								    val1 - 1));
 					continue;
 				default:
 					break;
@@ -408,7 +408,7 @@ static int context_struct_compute_av(struct context *scontext,
 		}
 		if (!ra)
 			avd->allowed = (avd->allowed) & ~(PROCESS__TRANSITION |
-			                                PROCESS__DYNTRANSITION);
+							PROCESS__DYNTRANSITION);
 	}
 
 	return 0;
@@ -445,9 +445,9 @@ int security_permissive_sid(u32 sid)
 }
 
 static int security_validtrans_handle_fail(struct context *ocontext,
-                                           struct context *ncontext,
-                                           struct context *tcontext,
-                                           u16 tclass)
+					   struct context *ncontext,
+					   struct context *tcontext,
+					   u16 tclass)
 {
 	char *o = NULL, *n = NULL, *t = NULL;
 	u32 olen, nlen, tlen;
@@ -459,9 +459,9 @@ static int security_validtrans_handle_fail(struct context *ocontext,
 	if (context_struct_to_string(tcontext, &t, &tlen) < 0)
 		goto out;
 	audit_log(current->audit_context, GFP_ATOMIC, AUDIT_SELINUX_ERR,
-	          "security_validate_transition:  denied for"
-	          " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
-	          o, n, t, policydb.p_class_val_to_name[tclass-1]);
+		  "security_validate_transition:  denied for"
+		  " oldcontext=%s newcontext=%s taskcontext=%s tclass=%s",
+		  o, n, t, policydb.p_class_val_to_name[tclass-1]);
 out:
 	kfree(o);
 	kfree(n);
@@ -473,7 +473,7 @@ out:
 }
 
 int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
-                                 u16 tclass)
+				 u16 tclass)
 {
 	struct context *ocontext;
 	struct context *ncontext;
@@ -533,9 +533,9 @@ int security_validate_transition(u32 oldsid, u32 newsid, u32 tasksid,
 	constraint = tclass_datum->validatetrans;
 	while (constraint) {
 		if (!constraint_expr_eval(ocontext, ncontext, tcontext,
-		                          constraint->expr)) {
+					  constraint->expr)) {
 			rc = security_validtrans_handle_fail(ocontext, ncontext,
-			                                     tcontext, tclass);
+							     tcontext, tclass);
 			goto out;
 		}
 		constraint = constraint->next;
@@ -623,9 +623,8 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 
 	/* Allocate space for the context; caller must free this space. */
 	scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
-	if (!scontextp) {
+	if (!scontextp)
 		return -ENOMEM;
-	}
 	*scontext = scontextp;
 
 	/*
@@ -636,8 +635,8 @@ static int context_struct_to_string(struct context *context, char **scontext, u3
 		policydb.p_role_val_to_name[context->role - 1],
 		policydb.p_type_val_to_name[context->type - 1]);
 	scontextp += strlen(policydb.p_user_val_to_name[context->user - 1]) +
-	             1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
-	             1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
+		     1 + strlen(policydb.p_role_val_to_name[context->role - 1]) +
+		     1 + strlen(policydb.p_type_val_to_name[context->type - 1]);
 
 	mls_sid_to_context(context, &scontextp);
 
@@ -678,7 +677,7 @@ int security_sid_to_context(u32 sid, char **scontext, u32 *scontext_len)
 			char *scontextp;
 
 			*scontext_len = strlen(initial_sid_to_string[sid]) + 1;
-			scontextp = kmalloc(*scontext_len,GFP_ATOMIC);
+			scontextp = kmalloc(*scontext_len, GFP_ATOMIC);
 			if (!scontextp) {
 				rc = -ENOMEM;
 				goto out;
@@ -737,7 +736,7 @@ static int security_context_to_sid_core(char *scontext, u32 scontext_len, u32 *s
 	   null suffix to the copy to avoid problems with the existing
 	   attr package, which doesn't view the null terminator as part
 	   of the attribute value. */
-	scontext2 = kmalloc(scontext_len+1,GFP_KERNEL);
+	scontext2 = kmalloc(scontext_len+1, GFP_KERNEL);
 	if (!scontext2) {
 		rc = -ENOMEM;
 		goto out;
@@ -837,7 +836,7 @@ out:
 int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-	                                    sid, SECSID_NULL);
+					    sid, SECSID_NULL);
 }
 
 /**
@@ -860,7 +859,7 @@ int security_context_to_sid(char *scontext, u32 scontext_len, u32 *sid)
 int security_context_to_sid_default(char *scontext, u32 scontext_len, u32 *sid, u32 def_sid)
 {
 	return security_context_to_sid_core(scontext, scontext_len,
-	                                    sid, def_sid);
+					    sid, def_sid);
 }
 
 static int compute_sid_handle_invalid_context(
@@ -972,7 +971,7 @@ static int security_compute_sid(u32 ssid,
 	avdatum = avtab_search(&policydb.te_avtab, &avkey);
 
 	/* If no permanent rule, also check for enabled conditional rules */
-	if(!avdatum) {
+	if (!avdatum) {
 		node = avtab_search_node(&policydb.te_cond_avtab, &avkey);
 		for (; node != NULL; node = avtab_search_node_next(node, specified)) {
 			if (node->key.specified & AVTAB_ENABLED) {
@@ -1286,26 +1285,23 @@ static int convert_context(u32 key,
 
 	/* Convert the user. */
 	usrdatum = hashtab_search(args->newp->p_users.table,
-	                          args->oldp->p_user_val_to_name[c->user - 1]);
-	if (!usrdatum) {
+				  args->oldp->p_user_val_to_name[c->user - 1]);
+	if (!usrdatum)
 		goto bad;
-	}
 	c->user = usrdatum->value;
 
 	/* Convert the role. */
 	role = hashtab_search(args->newp->p_roles.table,
-	                      args->oldp->p_role_val_to_name[c->role - 1]);
-	if (!role) {
+			      args->oldp->p_role_val_to_name[c->role - 1]);
+	if (!role)
 		goto bad;
-	}
 	c->role = role->value;
 
 	/* Convert the type. */
 	typdatum = hashtab_search(args->newp->p_types.table,
-	                          args->oldp->p_type_val_to_name[c->type - 1]);
-	if (!typdatum) {
+				  args->oldp->p_type_val_to_name[c->type - 1]);
+	if (!typdatum)
 		goto bad;
-	}
 	c->type = typdatum->value;
 
 	rc = mls_convert_context(args->oldp, args->newp, c);
@@ -1560,8 +1556,8 @@ static int match_ipv6_addrmask(u32 *input, u32 *addr, u32 *mask)
 {
 	int i, fail = 0;
 
-	for(i = 0; i < 4; i++)
-		if(addr[i] != (input[i] & mask[i])) {
+	for (i = 0; i < 4; i++)
+		if (addr[i] != (input[i] & mask[i])) {
 			fail = 1;
 			break;
 		}
@@ -1660,7 +1656,7 @@ out:
  */
 
 int security_get_user_sids(u32 fromsid,
-	                   char *username,
+			   char *username,
 			   u32 **sids,
 			   u32 *nel)
 {
@@ -1770,7 +1766,7 @@ out:
  * transition SIDs or task SIDs.
  */
 int security_genfs_sid(const char *fstype,
-	               char *path,
+		       char *path,
 		       u16 sclass,
 		       u32 *sid)
 {
@@ -1885,7 +1881,7 @@ int security_get_bools(int *len, char ***names, int **values)
 		goto out;
 	}
 
-       *names = kcalloc(*len, sizeof(char*), GFP_ATOMIC);
+       *names = kcalloc(*len, sizeof(char *), GFP_ATOMIC);
 	if (!*names)
 		goto err;
 
@@ -1897,7 +1893,7 @@ int security_get_bools(int *len, char ***names, int **values)
 		size_t name_len;
 		(*values)[i] = policydb.bool_val_to_struct[i]->state;
 		name_len = strlen(policydb.p_bool_val_to_name[i]) + 1;
-               (*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
+	       (*names)[i] = kmalloc(sizeof(char) * name_len, GFP_ATOMIC);
 		if (!(*names)[i])
 			goto err;
 		strncpy((*names)[i], policydb.p_bool_val_to_name[i], name_len);
@@ -1942,11 +1938,10 @@ int security_set_bools(int len, int *values)
 				audit_get_loginuid(current),
 				audit_get_sessionid(current));
 		}
-		if (values[i]) {
+		if (values[i])
 			policydb.bool_val_to_struct[i]->state = 1;
-		} else {
+		else
 			policydb.bool_val_to_struct[i]->state = 0;
-		}
 	}
 
 	for (cur = policydb.cond_list; cur != NULL; cur = cur->next) {
@@ -2308,7 +2303,7 @@ void selinux_audit_rule_free(struct selinux_audit_rule *rule)
 }
 
 int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
-                            struct selinux_audit_rule **rule)
+			    struct selinux_audit_rule **rule)
 {
 	struct selinux_audit_rule *tmprule;
 	struct role_datum *roledatum;
@@ -2401,8 +2396,8 @@ int selinux_audit_rule_init(u32 field, u32 op, char *rulestr,
 }
 
 int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
-                             struct selinux_audit_rule *rule,
-                             struct audit_context *actx)
+			     struct selinux_audit_rule *rule,
+			     struct audit_context *actx)
 {
 	struct context *ctxt;
 	struct mls_level *level;
@@ -2410,7 +2405,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
 
 	if (!rule) {
 		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
-		          "selinux_audit_rule_match: missing rule\n");
+			  "selinux_audit_rule_match: missing rule\n");
 		return -ENOENT;
 	}
 
@@ -2418,7 +2413,7 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
 
 	if (rule->au_seqno < latest_granting) {
 		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
-		          "selinux_audit_rule_match: stale rule\n");
+			  "selinux_audit_rule_match: stale rule\n");
 		match = -ESTALE;
 		goto out;
 	}
@@ -2426,8 +2421,8 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
 	ctxt = sidtab_search(&sidtab, sid);
 	if (!ctxt) {
 		audit_log(actx, GFP_ATOMIC, AUDIT_SELINUX_ERR,
-		          "selinux_audit_rule_match: unrecognized SID %d\n",
-		          sid);
+			  "selinux_audit_rule_match: unrecognized SID %d\n",
+			  sid);
 		match = -ENOENT;
 		goto out;
 	}
@@ -2473,36 +2468,36 @@ int selinux_audit_rule_match(u32 sid, u32 field, u32 op,
 	case AUDIT_OBJ_LEV_LOW:
 	case AUDIT_OBJ_LEV_HIGH:
 		level = ((field == AUDIT_SUBJ_SEN ||
-		          field == AUDIT_OBJ_LEV_LOW) ?
-		         &ctxt->range.level[0] : &ctxt->range.level[1]);
+			  field == AUDIT_OBJ_LEV_LOW) ?
+			 &ctxt->range.level[0] : &ctxt->range.level[1]);
 		switch (op) {
 		case AUDIT_EQUAL:
 			match = mls_level_eq(&rule->au_ctxt.range.level[0],
-			                     level);
+					     level);
 			break;
 		case AUDIT_NOT_EQUAL:
 			match = !mls_level_eq(&rule->au_ctxt.range.level[0],
-			                      level);
+					      level);
 			break;
 		case AUDIT_LESS_THAN:
 			match = (mls_level_dom(&rule->au_ctxt.range.level[0],
-			                       level) &&
-			         !mls_level_eq(&rule->au_ctxt.range.level[0],
-			                       level));
+					       level) &&
+				 !mls_level_eq(&rule->au_ctxt.range.level[0],
+					       level));
 			break;
 		case AUDIT_LESS_THAN_OR_EQUAL:
 			match = mls_level_dom(&rule->au_ctxt.range.level[0],
-			                      level);
+					      level);
 			break;
 		case AUDIT_GREATER_THAN:
 			match = (mls_level_dom(level,
-			                      &rule->au_ctxt.range.level[0]) &&
-			         !mls_level_eq(level,
-			                       &rule->au_ctxt.range.level[0]));
+					      &rule->au_ctxt.range.level[0]) &&
+				 !mls_level_eq(level,
+					       &rule->au_ctxt.range.level[0]));
 			break;
 		case AUDIT_GREATER_THAN_OR_EQUAL:
 			match = mls_level_dom(level,
-			                      &rule->au_ctxt.range.level[0]);
+					      &rule->au_ctxt.range.level[0]);
 			break;
 		}
 	}
@@ -2512,10 +2507,10 @@ out:
 	return match;
 }
 
-static int (*aurule_callback)(void) = NULL;
+static int (*aurule_callback)(void);
 
 static int aurule_avc_callback(u32 event, u32 ssid, u32 tsid,
-                               u16 class, u32 perms, u32 *retained)
+			       u16 class, u32 perms, u32 *retained)
 {
 	int err = 0;
 
@@ -2529,7 +2524,7 @@ static int __init aurule_init(void)
 	int err;
 
 	err = avc_add_callback(aurule_avc_callback, AVC_CALLBACK_RESET,
-	                       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
+			       SECSID_NULL, SECSID_NULL, SECCLASS_NULL, 0);
 	if (err)
 		panic("avc_add_callback() failed, error %d\n", err);
 
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
