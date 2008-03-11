Subject: [PATCH] checkpolicy: support for permissive types
From: Eric Paris <eparis@redhat.com>
To: selinux <selinux@tycho.nsa.gov>
Cc: tmiller@tresys.com, sds@tycho.nsa.gov, jbrindle@tresys.com
Content-Type: text/plain
Date: Tue, 11 Mar 2008 10:30:45 -0400
Message-Id: <1205245845.5297.90.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for permissive types.

A very simple module to make httpd_t a permissive domain would be:

policy_module(permissiveapache, 1.0)
gen_require(`
	type httpd_t;
')
permissive httpd_t;

Obviously this syntax can be used in both the base policy and in a
policy module.

Signed-off-by: Eric Paris <eparis@redhat.com>

---

 policy_parse.y |   43 +++++++++++++++++++++++++++++++
 policy_scan.l  |    4 ++
 test/dismod.c  |    2 -
 test/dispol.c  |   78 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 2 deletions(-)

diff -up checkpolicy-2.0.10/policy_parse.y.pre.permissive checkpolicy-2.0.10/policy_parse.y
--- checkpolicy-2.0.10/policy_parse.y.pre.permissive	2008-03-11 10:18:31.000000000 -0400
+++ checkpolicy-2.0.10/policy_parse.y	2008-03-11 10:23:33.000000000 -0400
@@ -126,6 +126,7 @@ static int define_netif_context(void);
 static int define_ipv4_node_context(void);
 static int define_ipv6_node_context(void);
 static int define_polcap(void);
+static int define_permissive(void);
 
 typedef int (* require_func_t)();
 
@@ -201,6 +202,7 @@ typedef int (* require_func_t)();
 %token IPV6_ADDR
 %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
 %token POLICYCAP
+%token PERMISSIVE
 
 %left OR
 %left XOR
@@ -327,6 +329,7 @@ te_decl			: attribute_def
                         | transition_def
                         | range_trans_def
                         | te_avtab_def
+			| permissive_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) return -1;}
@@ -772,6 +775,8 @@ ipv6_addr		: IPV6_ADDR
 policycap_def		: POLICYCAP identifier ';'
 			{if (define_polcap()) return -1;}
 			;
+permissive_def		: PERMISSIVE identifier ';'
+			{if (define_permissive()) return -1;}
 
 /*********** module grammar below ***********/
 
@@ -1007,6 +1012,44 @@ static int define_polcap(void)
 	return -1;
 }
 
+static int define_permissive(void)
+{
+	char *type = NULL;
+	struct type_datum *t;
+
+	if (pass == 2) {
+		type = queue_remove(id_queue);
+		free(type);
+		return 0;
+	}
+
+	type = queue_remove(id_queue);
+
+	if (!is_id_in_scope(SYM_TYPES, type)) {
+		yyerror2("type %s is not within scope", type);
+		goto bad;
+	}
+
+	t = hashtab_search(policydbp->p_types.table, type);
+	if (!t) {
+		yyerror2("type is not defined: %s", type);
+		goto bad;
+	}
+
+	if (t->flavor == TYPE_ATTRIB) {
+		yyerror2("attributes may not be permissive: %s\n", type);
+		goto bad;
+	}
+
+	t->flags |= TYPE_FLAGS_PERMISSIVE;
+
+	free(type);
+	return 0;
+bad:
+	free(type);
+	return -1;
+}
+
 static int define_initial_sid(void)
 {
 	char *id = 0;
diff -up checkpolicy-2.0.10/test/dispol.c.pre.permissive checkpolicy-2.0.10/test/dispol.c
--- checkpolicy-2.0.10/test/dispol.c.pre.permissive	2008-03-11 10:18:31.000000000 -0400
+++ checkpolicy-2.0.10/test/dispol.c	2008-03-11 10:19:00.000000000 -0400
@@ -274,6 +274,61 @@ int display_cond_expressions(policydb_t 
 	return 1;
 }
 
+static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
+		       uint32_t symbol_value, char *prefix)
+{
+	char *id = p->sym_val_to_name[symbol_type][symbol_value];
+	fprintf(fp, " %s%s", prefix, id);
+}
+
+int display_type_callback(hashtab_key_t key, hashtab_datum_t datum, void *data)
+{
+	type_datum_t *type;
+	FILE *fp;
+	int i, first_attrib = 1;
+
+	type = (type_datum_t *) datum;
+	fp = (FILE *) data;
+
+	if (type->primary) {
+		display_id(&policydb, fp, SYM_TYPES, type->s.value - 1, "");
+		fprintf(fp, " [%d]: ", type->s.value);
+	} else {
+		/* as that aliases have no value of their own and that
+		 * they can never be required by a module, use this
+		 * alternative way of displaying a name */
+		fprintf(fp, " %s [%d]: ", (char *)key, type->s.value);
+	}
+	if (type->flavor == TYPE_ATTRIB) {
+		fprintf(fp, "attribute for types");
+		for (i = ebitmap_startbit(&type->types);
+		     i < ebitmap_length(&type->types); i++) {
+			if (!ebitmap_get_bit(&type->types, i))
+				continue;
+			if (first_attrib)
+				first_attrib = 0;
+			else
+				fprintf(fp, ",");
+			display_id(&policydb, fp, SYM_TYPES, i, "");
+		}
+	} else if (type->primary) {
+		fprintf(fp, "type");
+	} else {
+		fprintf(fp, "alias for type");
+		display_id(&policydb, fp, SYM_TYPES, type->s.value - 1, "");
+	}
+	fprintf(fp, "\n");
+
+	return 0;
+}
+
+int display_types(policydb_t *p, FILE *fp)
+{
+	if (hashtab_map(p->p_types.table, display_type_callback, fp))
+		return -1;
+	return 0;
+}
+
 int display_handle_unknown(policydb_t * p, FILE * out_fp)
 {
 	if (p->handle_unknown == ALLOW_UNKNOWN)
@@ -319,6 +374,21 @@ static void display_policycaps(policydb_
 	}
 }
 
+static void display_permissive(policydb_t *p, FILE *fp)
+{
+	ebitmap_node_t *node;
+	int i;
+
+	fprintf(fp, "permissive sids:\n");
+	ebitmap_for_each_bit(&p->permissive_map, node, i) {
+		if (ebitmap_node_get_bit(node, i)) {
+			fprintf(fp, "\t");
+			display_id(p, fp, SYM_TYPES, i - 1, "");
+			fprintf(fp, "\n");
+		}
+	}
+}
+
 int menu()
 {
 	printf("\nSelect a command:\n");
@@ -329,8 +399,10 @@ int menu()
 	printf("5)  display conditional bools\n");
 	printf("6)  display conditional expressions\n");
 	printf("7)  change a boolean value\n");
+	printf("8)  display all types\n");
 	printf("\n");
 	printf("c)  display policy capabilities\n");
+	printf("p)  display the list of permissive types\n");
 	printf("u)  display unknown handling setting\n");
 	printf("f)  set output file\n");
 	printf("m)  display menu\n");
@@ -443,9 +515,15 @@ int main(int argc, char **argv)
 			change_bool(name, state, &policydb, out_fp);
 			free(name);
 			break;
+		case '8':
+			display_types(&policydb, out_fp);
+			break;
 		case 'c':
 			display_policycaps(&policydb, out_fp);
 			break;
+		case 'p':
+			display_permissive(&policydb, out_fp);
+			break;
 		case 'u':
 		case 'U':
 			display_handle_unknown(&policydb, out_fp);
diff -up checkpolicy-2.0.10/test/dismod.c.pre.permissive checkpolicy-2.0.10/test/dismod.c
--- checkpolicy-2.0.10/test/dismod.c.pre.permissive	2008-03-11 10:18:31.000000000 -0400
+++ checkpolicy-2.0.10/test/dismod.c	2008-03-11 10:19:00.000000000 -0400
@@ -323,7 +323,7 @@ int display_type_callback(hashtab_key_t 
 		fprintf(fp, "alias for type");
 		display_id(&policydb, fp, SYM_TYPES, type->s.value - 1, "");
 	}
-	fprintf(fp, "\n");
+	fprintf(fp, " flags:%x\n", type->flags);
 
 	return 0;
 }
diff -up checkpolicy-2.0.10/policy_scan.l.pre.permissive checkpolicy-2.0.10/policy_scan.l
--- checkpolicy-2.0.10/policy_scan.l.pre.permissive	2008-03-11 10:18:31.000000000 -0400
+++ checkpolicy-2.0.10/policy_scan.l	2008-03-11 10:19:00.000000000 -0400
@@ -202,7 +202,9 @@ H1				{ return(H1); }
 h2 |
 H2				{ return(H2); }
 policycap |
-POLICYCAP			{ return(POLICYCAP);}
+POLICYCAP			{ return(POLICYCAP); }
+permissive |
+PERMISSIVE			{ return(PERMISSIVE); }
 "/"({alnum}|[_.-/])*	        { return(PATH); }
 {letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
 {digit}+                        { return(NUMBER); }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
