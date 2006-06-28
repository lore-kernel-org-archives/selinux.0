Subject: [PATCH] remove te rule conflict checking from parser
From: Joshua Brindle <jbrindle@tresys.com>
To: sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 28 Jun 2006 16:40:38 -0400
Message-Id: <1151527238.9361.9.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch removes the te rule conflict checking from the parser.
Duplicate te rules in different scopes (eg., conditional and
unconditional) are now fatal and the parser doesn't have enough
information to know if the te rules have the same conditional expression
if they are in different optional blocks. The expander correctly checks
for te rule duplicates and conflicts; unfortunately this means the
errors can't be caught until link/expand time (the base gets linked and
expanded during compilation for validation) and can't be caught at all
in modules until they are linked in.


diff -purN -x tests trunk/checkpolicy/policy_parse.y optionals-in-base-take2/checkpolicy/policy_parse.y
--- trunk/checkpolicy/policy_parse.y	2006-06-28 14:51:13.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/policy_parse.y	2006-06-28 16:31:09.000000000 -0400
@@ -923,22 +923,6 @@ static int insert_id(char *id, int push)
 	return 0;
 }
 
-/* Add a rule onto an avtab hash table only if it does not already
- * exist.  (Note that the avtab is discarded afterwards; it will be
- * regenerated during expansion.)  Return 1 if rule was added (or
- * otherwise handled successfully), 0 if it conflicted with something,
- * or -1 on error. */
-static int insert_check_type_rule(avrule_t *rule, avtab_t *avtab, cond_av_list_t **list, cond_av_list_t **other)
-{
-	int ret;
-
-	ret = expand_rule(NULL, policydbp, rule, avtab, list, other, 0);
-	if (ret < 0) {
-		yyerror("Failed on expanding rule");
-        }
-	return ret;
-}
-
 /* If the identifier has a dot within it and that its first character
    is not a dot then return 1, else return 0. */
 static int id_has_dot(char *id)
@@ -2082,7 +2066,6 @@ static int define_compute_type(int which
 {
 	char *id;
 	avrule_t *avrule;
-        int retval;
 
 	if (pass == 1) {
 		while ((id = queue_remove(id_queue))) 
@@ -2099,28 +2082,8 @@ static int define_compute_type(int which
 	if (define_compute_type_helper(which, &avrule))
 		return -1;
 	
-	retval = insert_check_type_rule(avrule, &policydbp->te_avtab, NULL, NULL);
-	switch (retval) {
-        case 1: {
-                /* append this avrule to the end of the current rules list */
-                append_avrule(avrule);
-                return 0;
-        }
-        case 0: {
-                /* rule conflicted, so don't actually add this rule */
-                avrule_destroy(avrule);
-                free(avrule);
-                return 0;
-        }
-        case -1: {
-                avrule_destroy(avrule);
-                free(avrule);
-                return -1;
-        }
-        default: {
-                assert(0); /* should never get here */
-        }
-        }
+	append_avrule(avrule);
+	return 0;
 }
 
 static avrule_t *define_cond_compute_type(int which)
@@ -3263,9 +3226,8 @@ static uintptr_t
 static int define_conditional(cond_expr_t *expr, avrule_t *t, avrule_t *f )
 {
 	cond_expr_t *e;
-	int depth, retval;
+	int depth;
         cond_node_t cn, *cn_old;
-        avrule_t *tmp, *last_tmp;
 
 	/* expression cannot be NULL */
 	if ( !expr) {
@@ -3344,61 +3306,6 @@ static int define_conditional(cond_expr_
                 return -1;
         }
 
-        /* verify te rules -- both true and false branches of conditional */
-	tmp = cn.avtrue_list;
-        last_tmp = NULL;
-	while (tmp) {
-		if (!tmp->specified & AVRULE_TRANSITION)
-			continue;
-		retval = insert_check_type_rule(tmp,
-                                                &policydbp->te_cond_avtab,
-                                                &cn_old->true_list, &cn_old->false_list);
-                switch (retval) {
-                case 1: {
-                        last_tmp = tmp;
-                        tmp = tmp->next;
-                        break;
-                }
-                case 0: {
-                        /* rule conflicted or dupe, so bail */
-                       return -1;
-                }
-                case -1: {
-                        return -1;
-                }
-                default: {
-                        assert(0);  /* should never get here */
-                }
-                }
-	}
-	
-	tmp = cn.avfalse_list;
-        last_tmp = NULL;
-	while (tmp) {
-		if (!tmp->specified & AVRULE_TRANSITION)
-			continue;
-		retval = insert_check_type_rule(tmp,
-                                                &policydbp->te_cond_avtab,
-                                                &cn_old->false_list, &cn_old->true_list);
-                switch (retval) {
-                case 1: {
-                        last_tmp = tmp;
-                        tmp = tmp->next;
-                        break;
-                }
-                case 0: {
-                        /* rule conflicted or dupe, so bail */
-                       return -1;
-                }
-                case -1: {
-                        return -1;
-                }
-                default: {
-                        assert(0);  /* should never get here */
-                }
-                }
-	}
-
         append_cond_list(&cn);
         
         /* note that there is no check here for duplicate rules, nor



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
