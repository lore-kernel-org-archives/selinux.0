From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] disallow * and ~ in rules
Date: Thu, 23 Jun 2005 16:36:35 -0400
References: <1119543471.8955.5.camel@localhost> <200506231529.07106.jbrindle@tresys.com> <1119557965.28493.273.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1119557965.28493.273.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_T1xuCCgov2KsQpU"
Message-Id: <200506231636.35348.jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_T1xuCCgov2KsQpU
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thursday 23 June 2005 16:19, you wrote:
> On Thu, 2005-06-23 at 15:29 -0400, Joshua Brindle wrote:
> > in the constraint case * seems to be entirely unnecessary. However I'm
> > not convinced that a compliment would never be useful in a constraint.
>
> I'm not sure why you'd ever use set complement (~b) rather than type set
> exclusion (a -b).
>
> > As for roles, it certainly isn't an issue now but one can easily concieve
> > a policy that creates a role for each user on the system. Then something
> > like allow system_r * would actually make sense (err, more sense than
> > now) but still isn't the best way, which would be adding the allow when
> > the role is created. I don't think it's a problem to remove * and ~ from
> > role sets, at least not yet.
>
> If we do retain them (or later restore them), it occurs to me that they
> need to exclude the implicitly defined object_r; otherwise, they are
> useless.

Fair enough, attached is hopefully the final patch, * and ~ disabled in all 
type sets other than neverallow and removed from role sets entirely.

Joshua

--Boundary-00=_T1xuCCgov2KsQpU
Content-Type: text/x-diff;
  charset="iso-8859-6";
  name="no-star-comp-allow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="no-star-comp-allow.patch"

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
+				if (set_types(&expr->names, &negset, id, &add, 0)) {
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

--Boundary-00=_T1xuCCgov2KsQpU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
