Subject: Re: Attributes in new binary format
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <1123522526.13654.305.camel@moss-spartans.epoch.ncsc.mil>
References: <42F7805B.3040607@tresys.com>
	 <1123518614.13654.244.camel@moss-spartans.epoch.ncsc.mil>
	 <42F79427.6020307@tresys.com>
	 <1123522526.13654.305.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 17:05:55 -0400
Message-Id: <1123535155.13654.383.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-08-08 at 13:35 -0400, Stephen Smalley wrote:
> You need to pre-expand the avtab via expand_avtab, just like avtab_write
> and check_assertions are doing.  Note that the attribute->type mapping
> is built not only upon expansion, but also upon policydb_read (in
> libsepol only, not in the kernel). The latter builds an in-memory
> attribute->type mapping from the stored type->attribute reverse mapping
> for later use by expand_avtab and expand_cond_av_list, because we need
> that for performing a policydb_write for an older binary policy version.
> I needed that to avoid breaking /sbin/init and load_policy of a
> policy.19 file with the new libsepol (upon the genusers/genbools calls,
> which pull in the file via policydb_read, mutate it, and then write it
> to memory via policydb_write and load the result).  There is some up
> front cost to building that mapping and using expand_avtab, but I don't
> think it is prohibitive.

This patch changes the hierarchy checking code to use the expand_avtab
and expand_cond_av_list code that was added for the compatibility
support.  Along with an unrelated bug fix for the hierarchy checking
code sent separately, this seems to correctly catch a hierarchy
violation triggered by a rule that used an attribute.

diff -X /home/sds/dontdiff -rup libsepol.a/src/hierarchy.c libsepol/src/hierarchy.c
--- libsepol.a/src/hierarchy.c	2005-08-02 16:18:04.000000000 -0400
+++ libsepol/src/hierarchy.c	2005-08-08 16:52:10.000000000 -0400
@@ -27,9 +27,11 @@
 #include <sepol/policydb.h>
 #include <sepol/conditional.h>
 #include <sepol/hierarchy.h>
+#include <sepol/expand.h>
 
 typedef struct hierarchy_args {
 	policydb_t *p;
+	avtab_t    *expa; /* expanded avtab */
 	/* This tells check_avtab_hierarchy to check this list in addition to the unconditional avtab */
 	cond_av_list_t *opt_cond_list; 
 	char errmsg[ERRMSG_LEN];
@@ -153,7 +155,7 @@ static int check_avtab_hierarchy_callbac
 		key.target_class = k->target_class;
 		key.specified = AVTAB_ALLOWED;
 	
-		avdatump = avtab_search(&a->p->te_avtab, &key);
+		avdatump = avtab_search(a->expa, &key);
 		if (avdatump) {
 			/* search for access allowed between type 1's parent and type 2 */
 			if ((avdatump->data & d->data) == d->data) {
@@ -192,7 +194,7 @@ static int check_avtab_hierarchy_callbac
 		key.target_class = k->target_class;
 		key.specified = AVTAB_ALLOWED;
 		
-		avdatump = avtab_search(&a->p->te_avtab, &key);
+		avdatump = avtab_search(a->expa, &key);
 		if (avdatump) {
 			if ((avdatump->data & d->data) == d->data) {
 				return 0;
@@ -217,7 +219,7 @@ static int check_avtab_hierarchy_callbac
 		key.target_class = k->target_class;
 		key.specified = AVTAB_ALLOWED;
 	
-		avdatump = avtab_search(&a->p->te_avtab, &key);
+		avdatump = avtab_search(a->expa, &key);
 		if (avdatump) {
 			if ((avdatump->data & d->data) == d->data) {
 				return 0;
@@ -255,28 +257,53 @@ static int check_cond_avtab_hierarchy(co
 {
 	int rc;
 	cond_list_t *cur_node;
-	cond_av_list_t *cur_av;
+	cond_av_list_t *cur_av, *expl = NULL;
+	avtab_t expa;
 
 	for (cur_node = cond_list; cur_node != NULL; cur_node = cur_node ->next) {
-		args->opt_cond_list = cur_node->true_list;
-		for (cur_av = cur_node->true_list; cur_av != NULL; cur_av = cur_av->next) {
+		if (avtab_init(&expa))
+			goto oom;
+		if (expand_cond_av_list(args->p, cur_node->true_list, &expl, &expa)) {
+			avtab_destroy(&expa);
+			goto oom;
+		}
+		args->opt_cond_list = expl;
+		for (cur_av = expl; cur_av != NULL; cur_av = cur_av->next) {
 			rc = check_avtab_hierarchy_callback(&cur_av->node->key, &cur_av->node->datum, args);
 			if (rc == 0)
 				continue;
 			/* error condition */
+			cond_av_list_destroy(expl);
+			avtab_destroy(&expa);
 			return rc;
 		}
-		args->opt_cond_list = cur_node->false_list;
-		for (cur_av = cur_node->false_list; cur_av != NULL; cur_av = cur_av->next) {
+		cond_av_list_destroy(expl);
+		avtab_destroy(&expa);
+		if (avtab_init(&expa))
+			goto oom;
+		if (expand_cond_av_list(args->p, cur_node->false_list, &expl, &expa)) {
+			avtab_destroy(&expa);
+			goto oom;
+		}
+		args->opt_cond_list = expl;
+		for (cur_av = expl; cur_av != NULL; cur_av = cur_av->next) {
 			rc = check_avtab_hierarchy_callback(&cur_av->node->key, &cur_av->node->datum, args);
 			if (rc == 0)
 				continue;
 			/* error condition */
+			cond_av_list_destroy(expl);
+			avtab_destroy(&expa);
 			return rc;
 		}
+		cond_av_list_destroy(expl);
+		avtab_destroy(&expa);
 	}
 
 	return 0;
+
+oom:
+	snprintf(args->errmsg, ERRMSG_LEN, "out of memory on conditional av list expansion");
+	return 1;
 }
 
 /* The role hierarchy is defined as: a child role cannot have more types than it's parent.
@@ -332,14 +359,23 @@ static int check_role_hierarchy_callback
 int hierarchy_check_constraints(policydb_t *p, char *error_msg, uint32_t error_len)
 {
 	hierarchy_args_t args;
+	avtab_t expa;
+
+	if (avtab_init(&expa))
+		goto oom;
+	if (expand_avtab(p, &p->te_avtab, &expa)) {
+		avtab_destroy(&expa);
+		goto oom;
+	}
 
 	args.p = p;
+	args.expa = &expa;
 	args.opt_cond_list = NULL;
 
 	if (hashtab_map(p->p_types.table, check_type_hierarchy_callback, &args)) 
 		goto bad;
 
-	if (avtab_map(&p->te_avtab, check_avtab_hierarchy_callback, &args))
+	if (avtab_map(&expa, check_avtab_hierarchy_callback, &args))
 		goto bad;
 
 	if (check_cond_avtab_hierarchy(p->cond_list, &args))
@@ -348,12 +384,18 @@ int hierarchy_check_constraints(policydb
 	if (hashtab_map(p->p_roles.table, check_role_hierarchy_callback, &args)) 
 		goto bad;
 
+	avtab_destroy(&expa);
 	return 0;
 
 bad:
 	if (args.errmsg)
 		error_msg = strncpy(error_msg, args.errmsg, error_len);
 
+	avtab_destroy(&expa);
+	return -1;
+
+oom:
+	strncpy(error_msg, "Out of memory", error_len);
 	return -1;
 }
 

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
