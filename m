Message-ID: <42556015.6090405@trustedcs.com>
Date: Thu, 07 Apr 2005 11:30:13 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Joshua Brindle <jbrindle@tresys.com>, selinux <selinux@tycho.nsa.gov>,
   selinux-dev@tresys.com
Subject: Re: policy hierarchy patch
References: <1112631282.19526.18.camel@localhost>	 <1112635440.7629.125.camel@moss-spartans.epoch.ncsc.mil>	 <1112643447.19527.30.camel@localhost>  <4251BA1E.9040406@trustedcs.com>	 <1112709782.19531.39.camel@localhost> <425320BD.5050207@trustedcs.com>	 <425456F1.5000905@trustedcs.com> <1112877155.27110.15.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1112877155.27110.15.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------090301070409050908020704"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090301070409050908020704
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Wed, 2005-04-06 at 16:38 -0500, Darrel Goeddel wrote:
> 
>>Here is a version that I am happy with.  There were only a few minor fixes from
>>the past patch.  As before, this patch is relative to Joshua's
>>hierarchy-backport patch, and it should be applied when that patch is applied to
>>keep mls processing working in the policy compiler.  I haven't really looked
>>over Joshua's patch with a fine tooth comb, but it sure has been working nice
>>for me.  Anybody see anything wrong with the mls patch (or suggestions)?
> 
> 
> The original hierarchy patch also collapsed the identifier and
> user_identifier together, thereby allowing "-" to occur in any
> identifier.  As a result, if someone specifies s0-s9 in the policy
> without whitespace, it will be incorrectly interpreted as an attempt to
> specify a level named "s0-s9".  Further, nothing prevents someone from
> defining a level or category name that includes a "-" presently.
> Options are to revert the change from the original patch that collapsed
> identifier and user_identifier together (only adding "." to identifier,
> not "-") or to add further handling to the action routines to deal with
> it.
> 

That sure could lead to some confusion.  I am ok with either remedy.  Does
anyone have a good argument for one approach over the other?

> It also looks like you have double free error upon encountering an
> undefined sensitivity name in a user declaration.

Are you talking about the case where a unknown sensitivity is encountered and
ignored  (continue statement...).  If so, I think the correct behavior is to
return -1.  We should not be ignoring things that are not defined anyway.  I
also found that I was freeing the id before it was possibly used in the error 
case - I have fixed those.  If this is not the error you mentioned, could you
please elaborate (I apologize for not being able to see it).  Attached is a
version of the patch that addresses these issues (not the '-' issue yet).  Is
the bug still there?

> As a minor note, I suppose that the 'make mlsconvert' should also change
> MLS=y in the Makefile so that you don't have to do that as an extra
> step.

I can add that to the next version of this patch since I'm already hitting the
mlsconvert target.

-- 

Darrel

--------------090301070409050908020704
Content-Type: text/plain;
 name="hierarchy-mls-fix.patch3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hierarchy-mls-fix.patch3"

diff -ruNp hier/checkpolicy/policy_parse.y hier-mls/checkpolicy/policy_parse.y
--- hier/checkpolicy/policy_parse.y	2005-04-05 15:13:01.000000000 -0500
+++ hier-mls/checkpolicy/policy_parse.y	2005-04-07 11:18:24.272558452 -0500
@@ -73,7 +73,7 @@ static int define_av_perms(int inherits)
 static int define_sens(void);
 static int define_dominance(void);
 static int define_category(void);
-static int define_level(int range);
+static int define_level(void);
 static int define_attrib(void);
 static int define_typealias(void);
 static int define_typeattribute(void);
@@ -170,7 +170,6 @@ static int define_ipv6_node_context(void
 %token NOT AND OR XOR
 %token CTRUE CFALSE
 %token IDENTIFIER
-%token MLS_IDENTIFIER
 %token NUMBER
 %token EQUALS
 %token NOTEQUAL
@@ -256,12 +255,10 @@ category_def		: CATEGORY identifier alia
 levels	 		: level_def 
 			| levels level_def
 			;
-level_def		: LEVEL identifier ':' identifier '.' identifier ';'
-			{if (define_level(1)) return -1;}
-			| LEVEL identifier ':' id_comma_list ';'
-			{if (define_level(0)) return -1;}
+level_def		: LEVEL identifier ':' id_comma_list ';'
+			{if (define_level()) return -1;}
 			| LEVEL identifier ';' 
-			{if (define_level(0)) return -1;}
+			{if (define_level()) return -1;}
 			;
 mlspolicy		: mlspolicy_decl
 			| mlspolicy mlspolicy_decl
@@ -679,18 +676,11 @@ mls_range_def		: mls_level_def '-' mls_l
 	                | mls_level_def
 			{if (insert_separator(0)) return -1;}
 	                ;
-mls_level_def		: mls_identifier ':' cat_comma_list
+mls_level_def		: identifier ':' id_comma_list
 			{if (insert_separator(0)) return -1;}
-	                | mls_identifier 
+	                | identifier
 			{if (insert_separator(0)) return -1;}
 	                ;
-cat_comma_list		: cat_range
-			| cat_comma_list ',' cat_range
-			;
-cat_range		: mls_identifier
-			| mls_identifier '.' mls_identifier
-			{ if (insert_id("MLS_CAT_RANGE",0)) return -1; }
-			;
 id_comma_list           : identifier
 			| id_comma_list ',' identifier
 			;
@@ -744,12 +734,6 @@ nested_id_element       : identifier | '
 identifier		: IDENTIFIER
 			{ if (insert_id(yytext,0)) return -1; }
 			;
-mls_identifier		: MLS_IDENTIFIER
-			{ if (insert_id(yytext,0)) return -1; }
-			;
-mls_identifier_push	: MLS_IDENTIFIER
-			{ if (insert_id(yytext, 1)) return -1; }
-			;
 path     		: PATH
 			{ if (insert_id(yytext,0)) return -1; }
 			;
@@ -1141,6 +1125,10 @@ static int define_sens(void)
 		yyerror("no sensitivity name for sensitivity definition?");
 		return -1;
 	}
+	if (id_has_dot(id)) {
+		yyerror("sensitivity identifiers may not contain periods");
+		goto bad;
+	}
 	level = (mls_level_t *) malloc(sizeof(mls_level_t));
 	if (!level) {
 		yyerror("out of memory");
@@ -1175,6 +1163,10 @@ static int define_sens(void)
 	}
 
 	while ((id = queue_remove(id_queue))) {
+		if (id_has_dot(id)) {
+			yyerror("sensitivity aliases may not contain periods");
+			goto bad_alias;
+		}
 		aliasdatum = (level_datum_t *) malloc(sizeof(level_datum_t));
 		if (!aliasdatum) {
 			yyerror("out of memory");
@@ -1242,7 +1234,7 @@ static int define_dominance(void)
 			sprintf(errormsg, "unknown sensitivity %s used in dominance definition", id);
 			yyerror(errormsg);
 			free(id);
-			continue;
+			return -1;
 		}
 		if (datum->level->sens != 0) {
 			sprintf(errormsg, "sensitivity %s occurs multiply in dominance definition", id);
@@ -1285,6 +1277,10 @@ static int define_category(void)
 		yyerror("no category name for category definition?");
 		return -1;
 	}
+	if (id_has_dot(id)) {
+		yyerror("category identifiers may not contain periods");
+		goto bad;
+	}
 	datum = (cat_datum_t *) malloc(sizeof(cat_datum_t));
 	if (!datum) {
 		yyerror("out of memory");
@@ -1309,6 +1305,11 @@ static int define_category(void)
 	}
 
 	while ((id = queue_remove(id_queue))) {
+		if (id_has_dot(id)) {
+			free(id);
+			yyerror("category aliases may not contain periods");
+			goto bad_alias;
+		}
 		aliasdatum = (cat_datum_t *) malloc(sizeof(cat_datum_t));
 		if (!aliasdatum) {
 			yyerror("out of memory");
@@ -1350,13 +1351,10 @@ static int define_category(void)
 }
 
 
-static int define_level(int range)
+static int define_level(void)
 {
-	int i;
-	char *id, *levid;
+	char *id;
 	level_datum_t *levdatum;
-	cat_datum_t *catdatum = NULL;
-	cat_datum_t *catdatum_r = NULL;
 
 	if (!mlspol) {
 		yyerror("level definition in non-MLS configuration");
@@ -1388,65 +1386,59 @@ static int define_level(int range)
 		free(id);
 		return -1;
 	}
-	levid = id;
+	free(id);
 
 	while ((id = queue_remove(id_queue))) {
-		catdatum =(cat_datum_t *)hashtab_search(policydbp->p_cats.table,
-		                                        (hashtab_key_t) id);
-		if (!catdatum) {
-			sprintf(errormsg, "unknown category %s used in level definition", id);
-			yyerror(errormsg);
-			free(id);
-			continue;
-		}
-		if (ebitmap_set_bit(&levdatum->level->cat, catdatum->value - 1, TRUE)) {
-			yyerror("out of memory");
-			free(id);
-			free(levid);
-			return -1;
-		}
-		/* no need to keep category name */
-		free(id);
+		cat_datum_t *cdatum;
+		int range_start, range_end, i;
 
-		if (range)
-			break;
-	}
+		if (id_has_dot(id)) {
+			char *id_start = id;
+			char *id_end = strchr(id, '.');
+
+			*(id_end++) = '\0';
+
+			cdatum = (cat_datum_t *)hashtab_search(policydbp->p_cats.table,
+			                                       (hashtab_key_t)id_start);
+			if (!cdatum) {
+				sprintf(errormsg, "unknown category %s", id_start);
+				yyerror(errormsg);
+				free(id);
+				return -1;
+			}
+			range_start = cdatum->value - 1;
+			cdatum = (cat_datum_t *)hashtab_search(policydbp->p_cats.table,
+			                                       (hashtab_key_t)id_end);
+			if (!cdatum) {
+				sprintf(errormsg, "unknown category %s", id_end);
+				yyerror(errormsg);
+				free(id);
+				return -1;
+			}
+			range_end = cdatum->value - 1;
 
-	if (range)
-	{
-		id = queue_remove(id_queue);
-		catdatum_r =(cat_datum_t *)hashtab_search(
-							policydbp->p_cats.table,
-							(hashtab_key_t) id);
-		if (!catdatum_r) {
-			sprintf(errormsg,
-				"unknown category %s used in level definition",
-				id);
-			yyerror(errormsg);
-			free(levid);
-			free(id);
-			return -1;
-		}
-		if (catdatum_r->value < catdatum->value)
-		{
-			yyerror("category range is negative");
-			free(levid);
-			free(id);
-			return -1;
+			if (range_end < range_start) {
+				sprintf(errormsg, "category range is invalid");
+				yyerror(errormsg);
+				free(id);
+				return -1;
+			}
+		} else {
+			cdatum = (cat_datum_t *)hashtab_search(policydbp->p_cats.table,
+			                                       (hashtab_key_t)id);
+			range_start = range_end = cdatum->value - 1;
 		}
 
-		for (i = catdatum->value; i < catdatum_r->value; i++)
-		{
+		for (i = range_start; i <= range_end; i++) {
 			if (ebitmap_set_bit(&levdatum->level->cat, i, TRUE)) {
 				yyerror("out of memory");
 				free(id);
-				free(levid);
 				return -1;
 			}
 		}
-	}
 
-	free(levid);
+		free(id);
+	}
 
 	return 0;
 }
@@ -3889,16 +3881,74 @@ static int set_user_roles(ebitmap_t *set
 }
 
 
+static int
+parse_categories(char *id, level_datum_t *levdatum, ebitmap_t *cats)
+{
+	cat_datum_t *cdatum;
+	int range_start, range_end, i;
+
+	if (id_has_dot(id)) {
+		char *id_start = id;
+		char *id_end = strchr(id, '.');
+
+		*(id_end++) = '\0';
+
+		cdatum = (cat_datum_t *)hashtab_search(policydbp->p_cats.table,
+		                                       (hashtab_key_t)id_start);
+		if (!cdatum) {
+			sprintf(errormsg, "unknown category %s", id_start);
+			yyerror(errormsg);
+			return -1;
+		}
+		range_start = cdatum->value - 1;
+		cdatum = (cat_datum_t *)hashtab_search(policydbp->p_cats.table,
+		                                       (hashtab_key_t)id_end);
+		if (!cdatum) {
+			sprintf(errormsg, "unknown category %s", id_end);
+			yyerror(errormsg);
+			return -1;
+		}
+		range_end = cdatum->value - 1;
+
+		if (range_end < range_start) {
+			sprintf(errormsg, "category range is invalid");
+			yyerror(errormsg);
+			return -1;
+		}
+	} else {
+		cdatum = (cat_datum_t *)hashtab_search(policydbp->p_cats.table,
+		                                       (hashtab_key_t)id);
+		range_start = range_end = cdatum->value - 1;
+	}
+
+	for (i = range_start; i <= range_end; i++) {
+		if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
+			uint32_t level_value = levdatum->level->sens - 1;
+			policydb_index_others(policydbp, 0);
+			sprintf(errormsg, "category %s can not be associated "
+			        "with level %s",
+			        policydbp->p_cat_val_to_name[i],
+			        policydbp->p_sens_val_to_name[level_value]);
+			yyerror(errormsg);
+			return -1;
+		}
+		if (ebitmap_set_bit(cats, i, TRUE)) {
+			yyerror("out of memory");
+			return -1;
+		}
+	}
+
+	return 0;
+}
+
+
 static int define_user(void)
 {
 	char *id;
 	user_datum_t *usrdatum;
 	int ret;
 	level_datum_t *levdatum;
-	cat_datum_t *catdatum = NULL;
-	cat_datum_t *catdatum_r = NULL;
-	int l, i;
-	char *levid;
+	int l;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -3970,67 +4020,20 @@ static int define_user(void)
 			free(id);
 			return -1;
 		}
+		free(id);
 
 		usrdatum->dfltlevel.sens = levdatum->level->sens;
 		ebitmap_init(&usrdatum->dfltlevel.cat);
 
-		levid = id;
-
 		while ((id = queue_remove(id_queue))) {
-			/* Check for ranged entry */
-			if (strcmp(id, "MLS_CAT_RANGE") == 0) {
-				free(id);
-				if (catdatum_r->value >= catdatum->value) {
-					yyerror("category range is negative");
-					free(levid);
-					return -1;
-				}
-
-				for (i=catdatum_r->value;
-						i<catdatum->value-1; i++) {
-					if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
-						sprintf(errormsg, "category value=%d cannot be associated with level %s", i+1, levid);
-						yyerror(errormsg);
-						continue;
-					}
-					if (ebitmap_set_bit(&usrdatum->dfltlevel.cat, i, TRUE)) {
-						yyerror("out of memory");
-						free(levid);
-						return -1;
-					}
-				}
-				continue;
-			}
-			/* Save previous entry */	
-			catdatum_r = catdatum;
-
-			catdatum = (cat_datum_t *)
-					hashtab_search(policydbp->p_cats.table,
-							   (hashtab_key_t) id);
-			if (!catdatum) {
-				sprintf(errormsg, "unknown category %s used in user range definition", id);
-				yyerror(errormsg);
-				free(id);
-				continue;
-			}
-			if (!ebitmap_get_bit(&levdatum->level->cat, catdatum->value - 1)) {
-				sprintf(errormsg, "category %s cannot be associated with level %s", id, levid);
-				yyerror(errormsg);
-				free(id);
-				continue;
-			}
-			if (ebitmap_set_bit(&usrdatum->dfltlevel.cat, catdatum->value - 1, TRUE)) {
-				yyerror("out of memory");
+			if (parse_categories(id, levdatum,
+			                     &usrdatum->dfltlevel.cat)) {
 				free(id);
-				free(levid);
-				ebitmap_destroy(&usrdatum->dfltlevel.cat);
 				return -1;
 			}
 			free(id);
 		}
 
-		free(levid);
-
 		id = queue_remove(id_queue);
 
 		for (l = 0; l < 2; l++) {
@@ -4041,76 +4044,21 @@ static int define_user(void)
 				sprintf(errormsg, "unknown sensitivity %s used in user range definition", id);
 				yyerror(errormsg);
 				free(id);
-				continue;
+				return -1;
 			}
+			free(id);
 			usrdatum->range.level[l].sens = levdatum->level->sens;
 			ebitmap_init(&usrdatum->range.level[l].cat);
 
-			levid = id;
-
 			while ((id = queue_remove(id_queue))) {
-				/* Check for ranged entry */
-				if (strcmp(id, "MLS_CAT_RANGE") == 0) {
-					free(id);
-					if (catdatum_r->value >= catdatum->value) {
-						yyerror("category range is negative");
-						free(levid);
-						return -1;
-					}
-
-					for (i=catdatum_r->value; i<catdatum->value-1; i++) {
-						if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
-							sprintf(errormsg, "category value=%d cannot be associated with level %s", i+1, levid);
-							yyerror(errormsg);
-							continue;
-						}
-						if (ebitmap_set_bit(&usrdatum->range.level[l].cat, i, TRUE)) {
-							yyerror("out of memory");
-							free(levid);
-							return -1;
-						}
-					}
-					continue;
-				}
-				/* Save previous entry */
-				catdatum_r = catdatum;
-
-				catdatum = (cat_datum_t *)
-				hashtab_search(policydbp->p_cats.table,
-							(hashtab_key_t) id);
-				if (!catdatum) {
-					sprintf(errormsg, "unknown category %s used in user range definition", id);
-					yyerror(errormsg);
-					free(id);
-					continue;
-				}
-				if (!ebitmap_get_bit(&levdatum->level->cat,
-							catdatum->value - 1)) {
-					sprintf(errormsg,"category %s cannot be associated with level %s", id, levid);
-					yyerror(errormsg);
-					free(id);
-					continue;
-				}
-				if (ebitmap_set_bit(&usrdatum->range.level[l].cat, catdatum->value - 1, TRUE)) {
-					yyerror("out of memory");
+				if (parse_categories(id, levdatum,
+				              &usrdatum->range.level[l].cat)) {
 					free(id);
-					free(levid);
-					ebitmap_destroy(&usrdatum->dfltlevel.cat);
-					ebitmap_destroy(&usrdatum->range.level[l].cat);
 					return -1;
 				}
-
-				/*
-				 * no need to keep category name
-				 */
 				free(id);
 			}
 
-			/*
-			 * no need to keep sensitivity name
-			 */
-			free(levid);
-
 			id = queue_remove(id_queue);
 			if (!id)
 				break;
@@ -4153,11 +4101,8 @@ static int parse_security_context(contex
 	role_datum_t *role;
 	type_datum_t *typdatum;
 	user_datum_t *usrdatum;
-	char *levid;
 	level_datum_t *levdatum;
-	cat_datum_t *catdatum = NULL;
-	cat_datum_t *catdatum_r = NULL;
-	int l, i;
+	int l;
 
 	if (pass == 1) {
 		id = queue_remove(id_queue); free(id); /* user  */
@@ -4259,59 +4204,19 @@ static int parse_security_context(contex
 				free(id);
 				return -1;
 			}
+			free(id);
 			c->range.level[l].sens = levdatum->level->sens;
 
 			/* extract low category set */
-			levid = id;
 			while ((id = queue_remove(id_queue))) {
-				/* Check for ranged entry */
-				if (strcmp(id, "MLS_CAT_RANGE") == 0) {
+				if (parse_categories(id, levdatum,
+				                     &c->range.level[l].cat)) {
 					free(id);
-					if (catdatum_r->value >=
-								catdatum->value)
-					{
-						yyerror("category range is negative");
-						free(levid);
-						return -1;
-					}
-
-					for (i = catdatum_r->value;
-					     i < catdatum->value-1; i++) {
-						if (ebitmap_set_bit(&c->range.level[l].cat, i, TRUE)) {
-							yyerror("out of memory");
-							free(levid);
-							return -1;
-						}
-					}
-					continue;
-				}
-				/* Save previous entry */	
-				catdatum_r = catdatum;
-
-				catdatum = (cat_datum_t *)
-					hashtab_search(policydbp->p_cats.table,
-							(hashtab_key_t) id);
-				if (!catdatum) {
-					sprintf(errormsg, "unknown category %s used in initial sid context", id);
-					yyerror(errormsg);
-					free(levid);
-					free(id);
-					goto bad;
-				}
-				if (ebitmap_set_bit(&c->range.level[l].cat,
-					     catdatum->value - 1, TRUE)) {
-					yyerror("out of memory");
-					free(levid);
-					free(id);
-					goto bad;
+					return -1;
 				}
-				/* no need to keep category name */
 				free(id);
 			}
 
-			/* no need to keep the sensitivity name */
-			free(levid);
-
 			/* extract high sensitivity */
 			id = (char *) queue_remove(id_queue);
 			if (!id)
@@ -4881,10 +4786,7 @@ static int define_genfs_context(int has_
 static int define_range_trans(void)
 {
 	char *id;
-	char *levid;
 	level_datum_t *levdatum = 0;
-	cat_datum_t *catdatum = NULL;
-	cat_datum_t *catdatum_r = NULL;
 	mls_range_t range;
 	ebitmap_t doms, types, negset;
 	range_trans_t *rt = 0;
@@ -4941,58 +4843,22 @@ static int define_range_trans(void)
 		if (!levdatum) {
 			sprintf(errormsg, "unknown level %s used in range_transition definition", id);
 			yyerror(errormsg);
+			free(id);
 			return -1;
 		}
+		free(id);
 		range.level[l].sens = levdatum->level->sens;
 
-		levid = id;
 		ebitmap_init(&range.level[l].cat);
+
 		while ((id = queue_remove(id_queue))) {
-			/* Check for ranged entry */
-			if (strcmp(id, "MLS_CAT_RANGE") == 0) {
+			if (parse_categories(id, levdatum,
+			                     &range.level[l].cat)) {
 				free(id);
-				if (catdatum_r->value >= catdatum->value) {
-					yyerror("category range is negative");
-					free(levid);
-					return -1;
-				}
-
-				for (i = catdatum_r->value; i < catdatum->value - 1; i++) {
-					if (!ebitmap_get_bit(&levdatum->level->cat, i)) {
-						sprintf(errormsg, "category value=%d cannot be associated with level %s", i+1, levid);
-						yyerror(errormsg);
-						continue;
-					}
-					if (ebitmap_set_bit(&range.level[l].cat, i, TRUE)) {
-						yyerror("out of memory");
-						free(levid);
-						return -1;
-					}
-				}
-				continue;
-			}
-
-			/* Save previous entry */
-			catdatum_r = catdatum;
-
-			catdatum = hashtab_search(policydbp->p_cats.table, id);
-			if (!catdatum) {
-				sprintf(errormsg, "unknown category %s used in range_transition definition", id);
-				yyerror(errormsg);
-				return -1;
-			}
-			if (!ebitmap_get_bit(&levdatum->level->cat, catdatum->value - 1)) {
-				sprintf(errormsg, "category %s not allowed with specified sensitivity", id);
-				yyerror(errormsg);
-				return -1;
-			}		
-			if (ebitmap_set_bit(&range.level[l].cat, catdatum->value - 1, TRUE)) {
-				yyerror("out of memory");
 				return -1;
 			}
 			free(id);
 		}
-		free(levid);
 
 		id = (char *)queue_remove(id_queue);
 		if (!id)
diff -ruNp hier/checkpolicy/policy_scan.l hier-mls/checkpolicy/policy_scan.l
--- hier/checkpolicy/policy_scan.l	2005-04-05 15:13:01.000000000 -0500
+++ hier-mls/checkpolicy/policy_scan.l	2005-04-06 11:34:10.000000000 -0500
@@ -192,7 +192,6 @@ H2				{ return(H2); }
 					  else 
 					  	REJECT;
 					}
-{letter}({letter}|{digit}|_)*	{ return(MLS_IDENTIFIER); }
 {digit}{digit}*                 { return(NUMBER); }
 {hexval}{0,4}":"{hexval}{0,4}":"({hexval}|":"|".")*	{ return(IPV6_ADDR); }
 #line[ ]1[ ]\"[^\n]*\"		{ source_lineno = 1; strncpy(source_file, yytext+9, 255); source_file[strlen(source_file)-1] = '\0'; }
diff -ruNp hier/policy/Makefile hier-mls/policy/Makefile
--- hier/policy/Makefile	2005-04-05 15:31:32.000000000 -0500
+++ hier-mls/policy/Makefile	2005-04-07 11:19:15.931046020 -0500
@@ -327,8 +327,8 @@ mlsconvert: 
 	done
 	@for file in $(USER_FILES); do \
 		echo "Converting $$file"; \
-		sed -e 's/;/ level s0 range s0 - s9 : c0 . c127;/' $$file > $$file.new && \
+		sed -e 's/;/ level s0 range s0 - s9 : c0.c127;/' $$file > $$file.new && \
 		mv $$file.new $$file; \
 	done
-	@sed -e '/sid kernel/s/s0/s0 - s9 : c0 . c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
+	@sed -e '/sid kernel/s/s0/s0 - s9 : c0.c127/' initial_sid_contexts > initial_sid_contexts.new && mv initial_sid_contexts.new initial_sid_contexts
 	@echo "Done"
diff -ruNp hier/policy/mls hier-mls/policy/mls
--- hier/policy/mls	2005-04-05 16:09:29.000000000 -0500
+++ hier-mls/policy/mls	2005-04-06 11:31:01.000000000 -0500
@@ -160,16 +160,16 @@ category c127;
 # Each MLS level specifies a sensitivity and zero or more categories which may
 # be associated with that sensitivity.
 #
-level s0:c0 . c127;
-level s1:c0 . c127;
-level s2:c0 . c127;
-level s3:c0 . c127;
-level s4:c0 . c127;
-level s5:c0 . c127;
-level s6:c0 . c127;
-level s7:c0 . c127;
-level s8:c0 . c127;
-level s9:c0 . c127;
+level s0:c0.c127;
+level s1:c0.c127;
+level s2:c0.c127;
+level s3:c0.c127;
+level s4:c0.c127;
+level s5:c0.c127;
+level s6:c0.c127;
+level s7:c0.c127;
+level s8:c0.c127;
+level s9:c0.c127;
 
 
 #

--------------090301070409050908020704--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
