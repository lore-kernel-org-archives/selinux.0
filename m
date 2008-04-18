From: eparis@redhat.com
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Eric Paris <eparis@redhat.com>
Subject: [PATCH 08/13] SELinux: conditional.c whitespace, syntax, and static declaraction cleanups
Date: Fri, 18 Apr 2008 17:38:29 -0400
Message-Id: <12085547142556-git-send-email-eparis@redhat.com>
In-Reply-To: <12085547141160-git-send-email-eparis@redhat.com>
References: <1208554714617-git-send-email-eparis@redhat.com>
 <12085547142360-git-send-email-eparis@redhat.com>
 <12085547142711-git-send-email-eparis@redhat.com>
 <12085547143090-git-send-email-eparis@redhat.com>
 <12085547142971-git-send-email-eparis@redhat.com>
 <12085547141335-git-send-email-eparis@redhat.com>
 <12085547141160-git-send-email-eparis@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Eric Paris <eparis@redhat.com>

This patch changes conditional.c to fix whitespace and syntax issues.  Things that
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
 security/selinux/ss/conditional.c |   59 ++++++++++++++++--------------------
 1 files changed, 26 insertions(+), 33 deletions(-)

diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index df33aea..3a464c7 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -1,9 +1,9 @@
 /* Authors: Karl MacMillan <kmacmillan@tresys.com>
- *          Frank Mayer <mayerf@tresys.com>
+ *	    Frank Mayer <mayerf@tresys.com>
  *
  * Copyright (C) 2003 - 2004 Tresys Technology, LLC
  *	This program is free software; you can redistribute it and/or modify
- *  	it under the terms of the GNU General Public License as published by
+ *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation, version 2.
  */
 
@@ -90,7 +90,7 @@ static int cond_evaluate_expr(struct policydb *p, struct cond_expr *expr)
 int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 {
 	int new_state;
-	struct cond_av_list* cur;
+	struct cond_av_list *cur;
 
 	new_state = cond_evaluate_expr(p, node->expr);
 	if (new_state != node->cur_state) {
@@ -99,20 +99,18 @@ int evaluate_cond_node(struct policydb *p, struct cond_node *node)
 			printk(KERN_ERR "SELinux: expression result was undefined - disabling all rules.\n");
 		/* turn the rules on or off */
 		for (cur = node->true_list; cur != NULL; cur = cur->next) {
-			if (new_state <= 0) {
+			if (new_state <= 0)
 				cur->node->key.specified &= ~AVTAB_ENABLED;
-			} else {
+			else
 				cur->node->key.specified |= AVTAB_ENABLED;
-			}
 		}
 
 		for (cur = node->false_list; cur != NULL; cur = cur->next) {
 			/* -1 or 1 */
-			if (new_state) {
+			if (new_state)
 				cur->node->key.specified &= ~AVTAB_ENABLED;
-			} else {
+			else
 				cur->node->key.specified |= AVTAB_ENABLED;
-			}
 		}
 	}
 	return 0;
@@ -174,8 +172,8 @@ void cond_policydb_destroy(struct policydb *p)
 int cond_init_bool_indexes(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
-	p->bool_val_to_struct = (struct cond_bool_datum**)
-		kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum*), GFP_KERNEL);
+	p->bool_val_to_struct = (struct cond_bool_datum **)
+		kmalloc(p->p_bools.nprim * sizeof(struct cond_bool_datum *), GFP_KERNEL);
 	if (!p->bool_val_to_struct)
 		return -1;
 	return 0;
@@ -200,7 +198,7 @@ int cond_index_bool(void *key, void *datum, void *datap)
 		return -EINVAL;
 
 	p->p_bool_val_to_name[booldatum->value - 1] = key;
-	p->bool_val_to_struct[booldatum->value -1] = booldatum;
+	p->bool_val_to_struct[booldatum->value - 1] = booldatum;
 
 	return 0;
 }
@@ -252,8 +250,7 @@ err:
 	return -1;
 }
 
-struct cond_insertf_data
-{
+struct cond_insertf_data {
 	struct policydb *p;
 	struct cond_av_list *other;
 	struct cond_av_list *head;
@@ -353,9 +350,8 @@ static int cond_read_av_list(struct policydb *p, void *fp, struct cond_av_list *
 		return -1;
 
 	len = le32_to_cpu(buf[0]);
-	if (len == 0) {
+	if (len == 0)
 		return 0;
-	}
 
 	data.p = p;
 	data.other = other;
@@ -408,15 +404,14 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 	/* expr */
 	len = le32_to_cpu(buf[0]);
 
-	for (i = 0; i < len; i++ ) {
+	for (i = 0; i < len; i++) {
 		rc = next_entry(buf, fp, sizeof(u32) * 2);
 		if (rc < 0)
 			goto err;
 
 		expr = kzalloc(sizeof(struct cond_expr), GFP_KERNEL);
-		if (!expr) {
+		if (!expr)
 			goto err;
-		}
 
 		expr->expr_type = le32_to_cpu(buf[0]);
 		expr->bool = le32_to_cpu(buf[1]);
@@ -426,11 +421,10 @@ static int cond_read_node(struct policydb *p, struct cond_node *node, void *fp)
 			goto err;
 		}
 
-		if (i == 0) {
+		if (i == 0)
 			node->expr = expr;
-		} else {
+		else
 			last->next = expr;
-		}
 		last = expr;
 	}
 
@@ -469,11 +463,10 @@ int cond_read_list(struct policydb *p, void *fp)
 		if (cond_read_node(p, node, fp) != 0)
 			goto err;
 
-		if (i == 0) {
+		if (i == 0)
 			p->cond_list = node;
-		} else {
+		else
 			last->next = node;
-		}
 		last = node;
 	}
 	return 0;
@@ -490,24 +483,24 @@ void cond_compute_av(struct avtab *ctab, struct avtab_key *key, struct av_decisi
 {
 	struct avtab_node *node;
 
-	if(!ctab || !key || !avd)
+	if (!ctab || !key || !avd)
 		return;
 
-	for(node = avtab_search_node(ctab, key); node != NULL;
+	for (node = avtab_search_node(ctab, key); node != NULL;
 				node = avtab_search_node_next(node, key->specified)) {
-		if ( (u16) (AVTAB_ALLOWED|AVTAB_ENABLED) ==
-		     (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
+		if ((u16)(AVTAB_ALLOWED|AVTAB_ENABLED) ==
+		    (node->key.specified & (AVTAB_ALLOWED|AVTAB_ENABLED)))
 			avd->allowed |= node->datum.data;
-		if ( (u16) (AVTAB_AUDITDENY|AVTAB_ENABLED) ==
-		     (node->key.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
+		if ((u16)(AVTAB_AUDITDENY|AVTAB_ENABLED) ==
+		    (node->key.specified & (AVTAB_AUDITDENY|AVTAB_ENABLED)))
 			/* Since a '0' in an auditdeny mask represents a
 			 * permission we do NOT want to audit (dontaudit), we use
 			 * the '&' operand to ensure that all '0's in the mask
 			 * are retained (much unlike the allow and auditallow cases).
 			 */
 			avd->auditdeny &= node->datum.data;
-		if ( (u16) (AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
-		     (node->key.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
+		if ((u16)(AVTAB_AUDITALLOW|AVTAB_ENABLED) ==
+		    (node->key.specified & (AVTAB_AUDITALLOW|AVTAB_ENABLED)))
 			avd->auditallow |= node->datum.data;
 	}
 	return;
-- 
1.5.2.1


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
