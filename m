Subject: [RFC] checkpolicy: allow genfscon statements in modules
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, dwalsh@redhat.com, method@manicmethod.com,
        tmiller@tresys.com
Content-Type: text/plain
Date: Mon, 05 May 2008 16:36:49 -0400
Message-Id: <1210019809.3089.23.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dan wants to be able to give types to booleans declared in modules.
Since /selinux uses genfscon for its labeling we need to move the
ability to declare such statements in modules.

Interesting things to notice is that inside the module we have no way to
validate if the complete context is valid so I delay that checking until
link time.

This could be the first step on the path to allowing other things which
use full contexts (fs_uses) in modules.

Anyway, attack at will.  I still need to do more testing.  I haven't
tested to verify that sorting is correct in the base policy, that things
work if there are more than 1 FS in the base policy, or that we are
inserting the shortest path from a module.  I'll test all of those
before post a final.

-Eric

---
 policy_define.c |   50 +++++++++++++++++++++++++++-----------------------
 policy_parse.y  |    9 ++-------
 test/dismod.c   |   31 +++++++++++++++++++++++++++++++
 test/dispol.c   |   29 +++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+), 30 deletions(-)

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
+++ checkpolicy-2.0.14/policy_parse.y	2008-05-05 16:20:39.000000000 -0400
@@ -153,7 +153,7 @@ base_policy             : { if (define_p
 			  opt_mls te_rbac users opt_constraints 
                          { if (pass == 1) { if (policydb_index_bools(policydbp)) return -1;}
 			   else if (pass == 2) { if (policydb_index_others(NULL, policydbp, 0)) return -1;}}
-			  initial_sid_contexts opt_fs_contexts opt_fs_uses opt_genfs_contexts net_contexts 
+			  initial_sid_contexts opt_fs_contexts opt_fs_uses net_contexts 
 			;
 classes			: class_def 
 			| classes class_def
@@ -612,12 +612,6 @@ fs_use_def              : FSUSEXATTR ide
                         | FSUSETRANS identifier security_context_def ';'
                         {if (define_fs_use(SECURITY_FS_USE_TRANS)) return -1;}
                         ;
-opt_genfs_contexts      : genfs_contexts
-                        |
-                        ;
-genfs_contexts          : genfs_context_def
-                        | genfs_contexts genfs_context_def
-                        ;
 genfs_context_def	: GENFSCON identifier path '-' identifier security_context_def
 			{if (define_genfs_context(1)) return -1;}
 			| GENFSCON identifier path '-' '-' {insert_id("-", 0);} security_context_def
@@ -776,5 +770,6 @@ else_decl               : ELSE
                         { if (begin_optional_else(pass) == -1) return -1; }
                         ;
 avrule_user_defs        : user_def avrule_user_defs
+			| genfs_context_def avrule_user_defs
                         | /* empty */
                         ;
diff -Naupr checkpolicy-2.0.14.orig/test/dismod.c checkpolicy-2.0.14/test/dismod.c
--- checkpolicy-2.0.14.orig/test/dismod.c	2008-04-14 15:33:41.000000000 -0400
+++ checkpolicy-2.0.14/test/dismod.c	2008-05-05 16:03:30.000000000 -0400
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



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
