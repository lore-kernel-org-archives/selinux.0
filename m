Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i0GII2Rb011138
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 13:18:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i0GIGpxr013095
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 18:16:51 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id i0GIGpYc013092
	for <selinux@tycho.nsa.gov>; Fri, 16 Jan 2004 18:16:51 GMT
Subject: Re: specifying groups of types
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: david caplan <dac@tresys.com>, Chris PeBenito <pebenito@gentoo.org>,
   Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <1074271807.23661.119.camel@colossus.columbia.tresys.com>
References: <200310111435.46684.russell@coker.com.au>
	 <1066134168.5054.11.camel@moss-spartans.epoch.ncsc.mil>
	 <3F8C46E4.1030403@tresys.com>
	 <1074177115.17320.32.camel@moss-spartans.epoch.ncsc.mil>
	 <1074271807.23661.119.camel@colossus.columbia.tresys.com>
Content-Type: multipart/mixed; boundary="=-/9tl24a33VWiqNtayApB"
Message-Id: <1074277054.24719.113.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 16 Jan 2004 13:17:34 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-/9tl24a33VWiqNtayApB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2004-01-16 at 11:50, Karl MacMillan wrote:
> I'm not certain that we want these to be order dependent. I can imagine
> a policy writer doing
> 
> allow { attr_a -sysadm_t attr_b} . . . 
> 
> and being surprised that sysadm_t was allowed because it was in attr_b.

So, you want something like the attached (untested) patch?
Still wouldn't prevent one allow rule from adding back a
type excluded by another allow rule...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-/9tl24a33VWiqNtayApB
Content-Disposition: attachment; filename=checkpolicy-negset.patch
Content-Type: text/x-patch; name=checkpolicy-negset.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: checkpolicy/policy_parse.y
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.12
diff -u -r1.12 policy_parse.y
--- checkpolicy/policy_parse.y	16 Jan 2004 15:07:17 -0000	1.12
+++ checkpolicy/policy_parse.y	16 Jan 2004 18:11:50 -0000
@@ -1724,6 +1724,7 @@
 
 
 static int set_types(ebitmap_t *set,
+		     ebitmap_t *negset,
 		     char *id,
 		     int *add)
 {
@@ -1731,9 +1732,11 @@
 	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
-		/* set all types */
-		for (i = 0; i < policydbp->p_types.nprim; i++) 
-			ebitmap_set_bit(set, i, TRUE);
+		/* set all types not in negset */
+		for (i = 0; i < policydbp->p_types.nprim; i++) {
+			if (!ebitmap_get_bit(negset, i))
+				ebitmap_set_bit(set, i, TRUE);
+		}
 		free(id);
 		return 0;
 	}
@@ -1765,15 +1768,34 @@
 	}
 
 	if (t->isattr) {
-		/* set or clear all types with this attribute */
+		/* set or clear all types with this attribute,
+		   but do not set anything explicitly cleared previously */
 		for (i = ebitmap_startbit(&t->types); i < ebitmap_length(&t->types); i++) {
 			if (!ebitmap_get_bit(&t->types, i)) 
 				continue;		
-			ebitmap_set_bit(set, i, *add);
+			if (!(*add)) {
+				ebitmap_set_bit(set, i, FALSE);
+				ebitmap_set_bit(negset, i, TRUE);
+			} else if (!ebitmap_get_bit(negset, i)) {
+				ebitmap_set_bit(set, i, TRUE);
+			} else {
+				char *name = type_val_to_name(i+1);
+				sprintf(errormsg, "ignoring %s due to prior -%s", name, name);
+				yywarn(errormsg);
+			}
 		}
 	} else {
-		/* set or clear one type */
-		ebitmap_set_bit(set, t->value - 1, *add);
+		/* set or clear one type, but do not set anything
+		   explicitly cleared previously */	
+		if (!(*add)) {
+			ebitmap_set_bit(set, t->value - 1, FALSE);
+			ebitmap_set_bit(negset, t->value - 1, TRUE);
+		} else if (!ebitmap_get_bit(negset, t->value - 1)) {
+			ebitmap_set_bit(set, t->value - 1, TRUE);
+		} else {
+			sprintf(errormsg, "ignoring %s due to prior -%s", id, id);
+			yywarn(errormsg);
+		}
 	}
 
 	free(id);
@@ -1789,7 +1811,7 @@
 	avtab_datum_t avdatum, *avdatump;
 	type_datum_t *datum;
 	class_datum_t *cladatum;
-	ebitmap_t stypes, ttypes, tclasses;
+	ebitmap_t stypes, ttypes, tclasses, negset;
 	__u32 newtype = 0;
 	int ret, add = 1;
 	unsigned int i, j, k;
@@ -1810,15 +1832,19 @@
 	ebitmap_init(&ttypes);
 	ebitmap_init(&tclasses);
 
+	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, id, &add))
+		if (set_types(&stypes, &negset, id, &add))
 			return -1;
 	}
+	ebitmap_destroy(&negset);
 
+	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&ttypes, id, &add))
+		if (set_types(&ttypes, &negset, id, &add))
 			return -1;
 	}
+	ebitmap_destroy(&negset);
 
 	while ((id = queue_remove(id_queue))) {
 		cladatum = hashtab_search(policydbp->p_classes.table, id);
@@ -2035,7 +2061,7 @@
 	char *id;
 	class_datum_t *cladatum;
 	perm_datum_t *perdatum;
-	ebitmap_t stypes, ttypes, tclasses;
+	ebitmap_t stypes, ttypes, tclasses, negset;
 	access_vector_t *avp;
 	unsigned int i, j, hiclass;
 	int self = 0, add = 1;
@@ -2057,19 +2083,23 @@
 	ebitmap_init(&ttypes);
 	ebitmap_init(&tclasses);
 
+	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, id, &add))
+		if (set_types(&stypes, &negset, id, &add))
 			return -1;
 	}
+	ebitmap_destroy(&negset);
 
+	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
 		if (strcmp(id, "self") == 0) {
 			self = 1;
 			continue;
 		}
-		if (set_types(&ttypes, id, &add))
+		if (set_types(&ttypes, &negset, id, &add))
 			return -1;
 	}
+	ebitmap_destroy(&negset);
 
 	hiclass = 0;
 	while ((id = queue_remove(id_queue))) {
@@ -2211,6 +2241,7 @@
 	role_datum_t *role;
 	char *role_id, *id;
 	int ret, add = 1;
+	ebitmap_t negset;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2244,10 +2275,12 @@
 	} else
 		free(role_id);
 
+	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&role->types, id, &add))
+		if (set_types(&role->types, &negset, id, &add))
 			return -1;
 	}
+	ebitmap_destroy(&negset);
 
 	return 0;
 }
@@ -2396,7 +2429,7 @@
 {
 	char *id;
 	role_datum_t *role;
-	ebitmap_t roles, types;
+	ebitmap_t roles, types, negset;
 	struct role_trans *tr = 0;
 	unsigned int i, j;
 	int add = 1;
@@ -2419,10 +2452,12 @@
 			return -1;
 	}
 
+	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, id, &add))
+		if (set_types(&types, &negset, id, &add))
 			return -1;
 	}
+	ebitmap_destroy(&negset);
 
 	id = (char *) queue_remove(id_queue);
 	if (!id) {
@@ -2659,6 +2694,7 @@
 	struct constraint_expr *expr, *e1 = NULL, *e2;
 	user_datum_t *user;
 	role_datum_t *role;
+	ebitmap_t negset;
 	char *id;
 	__u32 val;
 	int add = 1;
@@ -2729,6 +2765,7 @@
 	case CEXPR_NAMES:
 		expr->attr = arg1;
 		expr->op = arg2;
+		ebitmap_init(&negset);
 		while ((id = (char *) queue_remove(id_queue))) {
 			if (expr->attr & CEXPR_USER) {
 				user = (user_datum_t *) hashtab_search(policydbp->p_users.table,
@@ -2751,7 +2788,7 @@
 				}
 				val = role->value;
 			} else if (expr->attr & CEXPR_TYPE) {
-				if (set_types(&expr->names, id, &add)) {
+				if (set_types(&expr->names, &negset, id, &add)) {
 					free(expr);
 					return 0;
 				}
@@ -2769,6 +2806,7 @@
 			}
 			free(id);
 		}
+		ebitmap_destroy(&negset);
 		return (uintptr_t)expr;
 	default:
 		yyerror("invalid constraint expression");

--=-/9tl24a33VWiqNtayApB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
