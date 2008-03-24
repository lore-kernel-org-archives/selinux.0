Subject: [PATCH] checkpolicy: support for permissive types
From: Eric Paris <eparis@redhat.com>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jbrindle@tresys.com, tmiller@tresys.com
Content-Type: text/plain
Date: Mon, 24 Mar 2008 10:11:20 -0400
Message-Id: <1206367880.3192.24.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds support for permissive domains.

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

 policy_define.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 policy_define.h |    1 +
 policy_parse.y  |    4 ++++
 policy_scan.l   |    4 +++-
 test/dismod.c   |    2 +-
 test/dispol.c   |   26 ++++++++++++++++++++++++++
 6 files changed, 78 insertions(+), 2 deletions(-)

diff -up checkpolicy-2.0.13/policy_parse.y.pre.permissive checkpolicy-2.0.13/policy_parse.y
--- checkpolicy-2.0.13/policy_parse.y.pre.permissive	2008-03-24 09:56:14.000000000 -0400
+++ checkpolicy-2.0.13/policy_parse.y	2008-03-24 09:56:23.000000000 -0400
@@ -135,6 +135,7 @@ typedef int (* require_func_t)();
 %token IPV6_ADDR
 %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
 %token POLICYCAP
+%token PERMISSIVE
 
 %left OR
 %left XOR
@@ -261,6 +262,7 @@ te_decl			: attribute_def
                         | transition_def
                         | range_trans_def
                         | te_avtab_def
+			| permissive_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) return -1;}
@@ -706,6 +708,8 @@ ipv6_addr		: IPV6_ADDR
 policycap_def		: POLICYCAP identifier ';'
 			{if (define_polcap()) return -1;}
 			;
+permissive_def		: PERMISSIVE identifier ';'
+			{if (define_permissive()) return -1;}
 
 /*********** module grammar below ***********/
 
diff -up checkpolicy-2.0.13/policy_define.c.pre.permissive checkpolicy-2.0.13/policy_define.c
--- checkpolicy-2.0.13/policy_define.c.pre.permissive	2008-03-24 09:56:14.000000000 -0400
+++ checkpolicy-2.0.13/policy_define.c	2008-03-24 10:06:56.000000000 -0400
@@ -195,6 +195,49 @@ int define_class(void)
 	return -1;
 }
 
+int define_permissive(void)
+{
+	char *type = NULL;
+	struct type_datum *t;
+	int rc = 0;
+
+	type = queue_remove(id_queue);
+
+	if (!type) {
+		yyerror2("forgot to include type in permissive definition?");
+		rc = -1;
+		goto out;
+	}
+
+	if (pass == 1)
+		goto out;
+
+	if (!is_id_in_scope(SYM_TYPES, type)) {
+		yyerror2("type %s is not within scope", type);
+		rc = -1;
+		goto out;
+	}
+
+	t = hashtab_search(policydbp->p_types.table, type);
+	if (!t) {
+		yyerror2("type is not defined: %s", type);
+		rc = -1;
+		goto out;
+	}
+
+	if (t->flavor == TYPE_ATTRIB) {
+		yyerror2("attributes may not be permissive: %s\n", type);
+		rc = -1;
+		goto out;
+	}
+
+	t->flags |= TYPE_FLAGS_PERMISSIVE;
+
+out:
+	free(type);
+	return rc;
+}
+
 int define_polcap(void)
 {
 	char *id = 0;
diff -up checkpolicy-2.0.13/policy_define.h.pre.permissive checkpolicy-2.0.13/policy_define.h
--- checkpolicy-2.0.13/policy_define.h.pre.permissive	2008-03-24 09:56:14.000000000 -0400
+++ checkpolicy-2.0.13/policy_define.h	2008-03-24 09:56:23.000000000 -0400
@@ -36,6 +36,7 @@ int define_ipv4_node_context(void);
 int define_ipv6_node_context(void);
 int define_level(void);
 int define_netif_context(void);
+int define_permissive(void);
 int define_polcap(void);
 int define_port_context(unsigned int low, unsigned int high);
 int define_range_trans(int class_specified);
diff -up checkpolicy-2.0.13/test/dispol.c.pre.permissive checkpolicy-2.0.13/test/dispol.c
--- checkpolicy-2.0.13/test/dispol.c.pre.permissive	2008-03-24 09:56:14.000000000 -0400
+++ checkpolicy-2.0.13/test/dispol.c	2008-03-24 09:58:00.000000000 -0400
@@ -319,6 +319,28 @@ static void display_policycaps(policydb_
 	}
 }
 
+static void display_id(policydb_t *p, FILE *fp, uint32_t symbol_type,
+		       uint32_t symbol_value, char *prefix)
+{
+	char *id = p->sym_val_to_name[symbol_type][symbol_value];
+	fprintf(fp, " %s%s", prefix, id);
+}
+
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
@@ -331,6 +353,7 @@ int menu()
 	printf("7)  change a boolean value\n");
 	printf("\n");
 	printf("c)  display policy capabilities\n");
+	printf("p)  display the list of permissive types\n");
 	printf("u)  display unknown handling setting\n");
 	printf("f)  set output file\n");
 	printf("m)  display menu\n");
@@ -447,6 +470,9 @@ int main(int argc, char **argv)
 		case 'c':
 			display_policycaps(&policydb, out_fp);
 			break;
+		case 'p':
+			display_permissive(&policydb, out_fp);
+			break;
 		case 'u':
 		case 'U':
 			display_handle_unknown(&policydb, out_fp);
diff -up checkpolicy-2.0.13/test/dismod.c.pre.permissive checkpolicy-2.0.13/test/dismod.c
--- checkpolicy-2.0.13/test/dismod.c.pre.permissive	2008-03-24 09:56:14.000000000 -0400
+++ checkpolicy-2.0.13/test/dismod.c	2008-03-24 09:56:23.000000000 -0400
@@ -323,7 +323,7 @@ int display_type_callback(hashtab_key_t 
 		fprintf(fp, "alias for type");
 		display_id(&policydb, fp, SYM_TYPES, type->s.value - 1, "");
 	}
-	fprintf(fp, "\n");
+	fprintf(fp, " flags:%x\n", type->flags);
 
 	return 0;
 }
diff -up checkpolicy-2.0.13/policy_scan.l.pre.permissive checkpolicy-2.0.13/policy_scan.l
--- checkpolicy-2.0.13/policy_scan.l.pre.permissive	2008-03-24 09:56:14.000000000 -0400
+++ checkpolicy-2.0.13/policy_scan.l	2008-03-24 09:56:23.000000000 -0400
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
