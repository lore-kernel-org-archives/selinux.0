Subject: Re: [PATCH] disallow * and ~ in rules
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1119549285.28493.173.camel@moss-spartans.epoch.ncsc.mil>
References: <1119543471.8955.5.camel@localhost>
	 <1119549285.28493.173.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-Mt2QaUhbk7I6abit9y8I"
Date: Thu, 23 Jun 2005 14:47:46 -0400
Message-Id: <1119552466.8955.22.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-Mt2QaUhbk7I6abit9y8I
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-06-23 at 13:54 -0400, Stephen Smalley wrote:
> On Thu, 2005-06-23 at 12:17 -0400, Joshua Brindle wrote:
> > The attached patch disallows * and ~ in certain kinds of rules, the list
> > of where they are allowed and where they are not follows. I'm very
> > willing to discuss any ideas or arguments as to why these should or
> > shouldn't be in the list they are in.
> > 
> > 
> > * and ~ allowed:
> > range_trans (I was hoping TCS had an opinion on this)
> > neverallow, dontaudit, auditallow
> > 
> > 
> > * and ~ not allowed:
> > allow rules
> > type_transition, type_member, type_change
> > role declarations (to add types to a role)
> > role transitions
> 
> The patch only appears to alter their use in type sets, nothing else
> (e.g. they can still be used for permission sets and role sets).  Is
> that your intent?
> 
This is definitely up for debate. The major problems with type sets was
that using * and ~ in types would add rules when types were added, even
without assigning attributes or writing explicit rules. Permissions are
something different because they are mostly static and it's fairly well
known what you are saying you want when you use * for permissions.

Roles are interesting and I hadn't really thought about them. The
attached patch disallows * and ~ in role transitions, role allows and
user declarations in the role sets.

> For type sets, I'd favor greater consistency, e.g. not allow their use
> in any type set except neverallow rules and only in them because they
> are used to catch ill-formed policies.  Otherwise, type set exclusion
> (e.g. domain -foo) is always preferable to set complement (e.g. ~foo),
> as the latter will include unrelated types (e.g. file types) that are
> not possible in that field, and a type attribute like domain or
> file_type should always be used rather than a * for the same reason.
> Looks like the FC4 strict and targeted policies are clean in this
> respect, not sure about everything in the example policy.

Ok, I wasn't really sure if * or ~ would be useful in range_trans so I
left that for an MLS user to say something. The attached patch disallows
it.

I agree that neverallow has very legitimate reasons for * but dontaudit
and auditallow are a little less clear. Perhaps auditallow should allow
*, it's conceivable that someone would want to audit all access to an
object (though in the current policies and reference policy * would have
the same net effect as domain with fewer avtab entries). This may not be
the case for all policies though. The attached patch disallows it in all
rule types but neverallow. 

I forgot to mention constraints, which currently allow * and ~, any
thoughts on this?


Joshua 

--=-Mt2QaUhbk7I6abit9y8I
Content-Disposition: attachment; filename=no-star-comp-allow.patch
Content-Type: text/x-patch; name=no-star-comp-allow.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Index: policy_parse.y
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/checkpolicy/policy_parse.y,v
retrieving revision 1.31
diff -u -u -p -r1.31 policy_parse.y
--- policy_parse.y	13 May 2005 19:53:31 -0000	1.31
+++ policy_parse.y	23 Jun 2005 18:44:30 -0000
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
+		if (set_types(&stypes, &negset, id, &add, which == -AVTAB_ALLOWED? 1 : 0 ))
 			return COND_ERR;
 	}
 	ebitmap_destroy(&negset);
@@ -2479,7 +2488,7 @@ static cond_av_list_t *define_cond_te_av
 			self = 1;
 			continue;
 		}
-		if (set_types(&ttypes, &negset, id, &add))
+		if (set_types(&ttypes, &negset, id, &add, which == -AVTAB_ALLOWED? 1 : 0 ))
 			return COND_ERR;
 	}
 	ebitmap_destroy(&negset);
@@ -2646,7 +2655,7 @@ static int define_te_avtab(int which)
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&stypes, &negset, id, &add))
+		if (set_types(&stypes, &negset, id, &add, which == -AVTAB_ALLOWED? 1 : 0 ))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
@@ -2657,7 +2666,7 @@ static int define_te_avtab(int which)
 			self = 1;
 			continue;
 		}
-		if (set_types(&ttypes, &negset, id, &add))
+		if (set_types(&ttypes, &negset, id, &add, which == -AVTAB_ALLOWED? 1 : 0 ))
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
@@ -3002,26 +3011,17 @@ static int set_roles(ebitmap_t *set,
 		     char *id)
 {
 	role_datum_t *r;
-	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
-		/* set all roles */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) 
-			ebitmap_set_bit(set, i, TRUE);
 		free(id);
-		return 0;
+		yyerror("* is not allowed for role sets");
+		return -1;
 	}
 
 	if (strcmp(id, "~") == 0) {
-		/* complement the set */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) {
-			if (ebitmap_get_bit(set, i))
-				ebitmap_set_bit(set, i, FALSE);
-			else 
-				ebitmap_set_bit(set, i, TRUE);
-		}
 		free(id);
-		return 0;
+		yyerror("~ is not allowed for role sets");
+		return -1;
 	}
 
 	r = hashtab_search(policydbp->p_roles.table, id);
@@ -3068,7 +3068,7 @@ static int define_role_trans(void)
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, &negset, id, &add))
+		if (set_types(&types, &negset, id, &add, 0))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
@@ -3493,7 +3493,7 @@ static uintptr_t
 				}
 				val = role->value;
 			} else if (expr->attr & CEXPR_TYPE) {
-				if (set_types(&expr->names, &negset, id, &add)) {
+				if (set_types(&expr->names, &negset, id, &add, 1)) {
 					free(expr);
 					return 0;
 				}
@@ -3862,23 +3862,15 @@ static int set_user_roles(ebitmap_t *set
 	unsigned int i;
 
 	if (strcmp(id, "*") == 0) {
-		/* set all roles */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) 
-			ebitmap_set_bit(set, i, TRUE);
 		free(id);
-		return 0;
+		yyerror("* not allowed in user declarations");
+		return -1;
 	}
 
 	if (strcmp(id, "~") == 0) {
-		/* complement the set */
-		for (i = 0; i < policydbp->p_roles.nprim; i++) {
-			if (ebitmap_get_bit(set, i))
-				ebitmap_set_bit(set, i, FALSE);
-			else 
-				ebitmap_set_bit(set, i, TRUE);
-		}
 		free(id);
-		return 0;
+		yyerror("~ not allowed in user declarations");
+		return -1;
 	}
 
 	r = hashtab_search(policydbp->p_roles.table, id);
@@ -4839,14 +4831,14 @@ static int define_range_trans(void)
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&doms, &negset, id, &add))
+		if (set_types(&doms, &negset, id, &add, 0))
 			return -1;
 	}
 	ebitmap_destroy(&negset);
 
 	ebitmap_init(&negset);
 	while ((id = queue_remove(id_queue))) {
-		if (set_types(&types, &negset, id, &add))
+		if (set_types(&types, &negset, id, &add, 0))
 			return -1;
 	}
 	ebitmap_destroy(&negset);

--=-Mt2QaUhbk7I6abit9y8I--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
