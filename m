Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5NGQkgA028311
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 12:26:46 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5NGGqNa027448
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:16:53 GMT
Subject: [PATCH] disallow * and ~ in rules
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: multipart/mixed; boundary="=-C1sPG3qwmCLGQ1GAvS9/"
Date: Thu, 23 Jun 2005 12:17:51 -0400
Message-Id: <1119543471.8955.5.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-C1sPG3qwmCLGQ1GAvS9/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch disallows * and ~ in certain kinds of rules, the list
of where they are allowed and where they are not follows. I'm very
willing to discuss any ideas or arguments as to why these should or
shouldn't be in the list they are in.


* and ~ allowed:
range_trans (I was hoping TCS had an opinion on this)
neverallow, dontaudit, auditallow


* and ~ not allowed:
allow rules
type_transition, type_member, type_change
role declarations (to add types to a role)
role transitions


Joshua Brindle
Tresys Technology

--=-C1sPG3qwmCLGQ1GAvS9/
Content-Disposition: attachment; filename=no-star-comp-allow.patch
Content-Type: text/x-patch; name=no-star-comp-allow.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: policy_parse.y
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.31
diff -u -u -p -r1.31 policy_parse.y
--- policy_parse.y	13 May 2005 19:53:31 -0000	1.31
+++ policy_parse.y	23 Jun 2005 14:49:29 -0000
@@ -1781,12 +1781,17 @@ static char *type_val_to_name(unsigned i
 static int set_types(ebitmap_t *set,
 		     ebitmap_t *negset,
 		     char *id,
-		     int *add)
+		     int *add, 
+		     char starallowed)
 {
 	type_datum_t *t;
 	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
+		if (!starallowed) {
+			yyerror("* not allowed in this type of rule");
+			return -1;
+		}
 		/* set all types not in negset */
 		for (i = 0; i < policydbp->p_types.nprim; i++) {
 			if (!ebitmap_get_bit(negset, i))
@@ -1797,6 +1802,10 @@ static int set_types(ebitmap_t *set,
 	}
 
 	if (strcmp(id, "~") == 0) {
+		if (!starallowed) {
+			yyerror("~ not allowed in this type of rule");
+			return -1;
+		}
 		/* complement the set */
 		for (i = 0; i < policydbp->p_types.nprim; i++) {
 			if (ebitmap_get_bit(set, i))
@@ -1893,14 +1902,14 @@ static int define_compute_type(int which
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
+		if (set_types(&stypes, &negset, id, &add, 0))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&ttypes, &negset, id, &add))
+		if (set_types(&ttypes, &negset, id, &add, 0))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
@@ -2033,14 +2042,14 @@ static cond_av_list_t *define_cond_compu
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
+		if (set_types(&stypes, &negset, id, &add, 0))
 			return  COND_ERR;
 	}
 	ebitmap_destroy(&negset);
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&ttypes, &negset, id, &add))
+		if (set_types(&ttypes, &negset, id, &add, 0))
 			return COND_ERR;
 	}
 	ebitmap_destroy(&negset);
@@ -2468,7 +2477,7 @@ static cond_av_list_t *define_cond_te_av
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
+		if (set_types(&stypes, &negset, id, &add, which == AVTAB_ALLOWED? 0 : 1 ))
 			return COND_ERR;
 	}
 	ebitmap_destroy(&negset);
@@ -2479,7 +2488,7 @@ static cond_av_list_t *define_cond_te_av
 			self = 1;
 			continue;
 		}
-		if (set_types(&ttypes, &negset, id, &add))
+		if (set_types(&ttypes, &negset, id, &add, which == AVTAB_ALLOWED? 0 : 1 ))
 			return COND_ERR;
 	}
 	ebitmap_destroy(&negset);
@@ -2646,7 +2655,7 @@ static int define_te_avtab(int which)
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
+		if (set_types(&stypes, &negset, id, &add, which == AVTAB_ALLOWED? 0 : 1 ))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
@@ -2657,7 +2666,7 @@ static int define_te_avtab(int which)
 			self = 1;
 			continue;
 		}
-		if (set_types(&ttypes, &negset, id, &add))
+		if (set_types(&ttypes, &negset, id, &add, which == AVTAB_ALLOWED? 0 : 1 ))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
@@ -2853,7 +2862,7 @@ static int define_role_types(void)
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&role->types, &negset, id, &add))
+		if (set_types(&role->types, &negset, id, &add, 0))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
@@ -3068,7 +3077,7 @@ static int define_role_trans(void)
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, &negset, id, &add))
+		if (set_types(&types, &negset, id, &add, 0))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
@@ -3493,7 +3502,7 @@ static uintptr_t
 				}
 				val = role->value;
 			} else if (expr->attr & CEXPR_TYPE) {
-				if (set_types(&expr->names, &negset, id, &add)) {
+				if (set_types(&expr->names, &negset, id, &add, 1)) {
 					free(expr);
 					return 0;
 				}
@@ -4839,14 +4848,14 @@ static int define_range_trans(void)
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&doms, &negset, id, &add))
+		if (set_types(&doms, &negset, id, &add, 1))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, &negset, id, &add))
+		if (set_types(&types, &negset, id, &add, 1))
 			return -1;
 	}
 	ebitmap_destroy(&negset);

--=-C1sPG3qwmCLGQ1GAvS9/--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
