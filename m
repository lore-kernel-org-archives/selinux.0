Date: Mon, 3 Dec 2007 14:41:07 -0500
From: "Todd C. Miller" <tmiller@tresys.com>
Message-Id: <200712031941.lB3Jf7PK008934@cadmus.columbia.tresys.com>
To: selinux@tycho.nsa.gov
Subject: Re: PATCH: peersid capability support
Cc: jbrindle@tresys.com, paul.moore@hp.com, sds@tycho.nsa.gov,
        tmiller@tresys.com
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> Stephen Smalley wrote:
> Looks like the libsepol patch puts the policycaps ebitmap at a different
> location in the policy image than the kernel patch expects.

I had initially changed the ebitmap reading/writing location from
where Josh had it to work around an issue with semodule.  This version
preserves the location in the final policy binary without confusing
sepol_module_package_info().

 - todd

--

Index: trunk/libsepol/include/sepol/policydb/polcaps.h
===================================================================
--- /dev/null
+++ trunk/libsepol/include/sepol/policydb/polcaps.h
@@ -0,0 +1,14 @@
+#ifndef _SEPOL_POLICYDB_POLCAPS_H_
+#define _SEPOL_POLICYDB_POLCAPS_H_
+
+/* Policy capabilities */
+enum {
+	POLICYDB_CAPABILITY_NETPEER,
+	__POLICYDB_CAPABILITY_MAX
+};
+#define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
+
+/* Convert a capability name to number. */
+extern int sepol_polcap_getnum(const char *name);
+
+#endif /* _SEPOL_POLICYDB_POLCAPS_H_ */
Index: trunk/libsepol/include/sepol/policydb/policydb.h
===================================================================
--- trunk.orig/libsepol/include/sepol/policydb/policydb.h
+++ trunk/libsepol/include/sepol/policydb/policydb.h
@@ -468,6 +468,8 @@ typedef struct policydb {
 
 	ebitmap_t *attr_type_map;	/* not saved in the binary policy */
 
+	ebitmap_t policycaps;
+
 	unsigned policyvers;
 
 	unsigned handle_unknown;
@@ -584,10 +586,11 @@ extern int policydb_write(struct policyd
 #define POLICYDB_VERSION_MLS		19
 #define POLICYDB_VERSION_AVTAB		20
 #define POLICYDB_VERSION_RANGETRANS	21
+#define POLICYDB_VERSION_POLCAP		22
 
 /* Range of policy versions we understand*/
 #define POLICYDB_VERSION_MIN	POLICYDB_VERSION_BASE
-#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_RANGETRANS
+#define POLICYDB_VERSION_MAX	POLICYDB_VERSION_POLCAP
 
 /* Module versions and specific changes*/
 #define MOD_POLICYDB_VERSION_BASE	   4
@@ -595,9 +598,10 @@ extern int policydb_write(struct policyd
 #define MOD_POLICYDB_VERSION_MLS	   5
 #define MOD_POLICYDB_VERSION_RANGETRANS	   6
 #define MOD_POLICYDB_VERSION_MLS_USERS	   6
+#define MOD_POLICYDB_VERSION_POLCAP	   7
 
 #define MOD_POLICYDB_VERSION_MIN MOD_POLICYDB_VERSION_BASE
-#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_MLS_USERS
+#define MOD_POLICYDB_VERSION_MAX MOD_POLICYDB_VERSION_POLCAP
 
 #define POLICYDB_CONFIG_MLS    1
 
Index: trunk/libsepol/src/polcaps.c
===================================================================
--- /dev/null
+++ trunk/libsepol/src/polcaps.c
@@ -0,0 +1,24 @@
+/*
+ * Policy capability support functions
+ */
+
+#include <string.h>
+#include <sepol/policydb/polcaps.h>
+
+static const char *polcap_names[] = {
+	"network_peer_controls",	/* POLICYDB_CAPABILITY_NETPEER */
+	NULL
+};
+
+int sepol_polcap_getnum(const char *name)
+{
+	int capnum;
+
+	for (capnum = 0; capnum <= POLICYDB_CAPABILITY_MAX; capnum++) {
+		if (polcap_names[capnum] == NULL)
+			continue;
+		if (strcasecmp(polcap_names[capnum], name) == 0)
+			return capnum;
+	}
+	return -1;
+}
Index: trunk/libsepol/src/policydb.c
===================================================================
--- trunk.orig/libsepol/src/policydb.c
+++ trunk/libsepol/src/policydb.c
@@ -99,6 +99,12 @@ static struct policydb_compat_info polic
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_KERN,
+	 .version = POLICYDB_VERSION_POLCAP,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_BASE,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -117,6 +123,12 @@ static struct policydb_compat_info polic
 	 .ocon_num = OCON_NODE6 + 1,
 	 },
 	{
+	 .type = POLICY_BASE,
+	 .version = MOD_POLICYDB_VERSION_POLCAP,
+	 .sym_num = SYM_NUM,
+	 .ocon_num = OCON_NODE6 + 1,
+	 },
+	{
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_BASE,
 	 .sym_num = SYM_NUM,
@@ -132,6 +144,12 @@ static struct policydb_compat_info polic
 	 .type = POLICY_MOD,
 	 .version = MOD_POLICYDB_VERSION_MLS_USERS,
 	 .sym_num = SYM_NUM,
+	 .ocon_num = 0
+	 },
+	{
+	 .type = POLICY_MOD,
+	 .version = MOD_POLICYDB_VERSION_POLCAP,
+	 .sym_num = SYM_NUM,
 	 .ocon_num = 0},
 };
 
@@ -447,6 +465,8 @@ int policydb_init(policydb_t * p)
 
 	memset(p, 0, sizeof(policydb_t));
 
+	ebitmap_init(&p->policycaps);
+
 	for (i = 0; i < SYM_NUM; i++) {
 		p->sym_val_to_name[i] = NULL;
 		rc = symtab_init(&p->symtab[i], symtab_sizes[i]);
@@ -971,6 +991,8 @@ void policydb_destroy(policydb_t * p)
 	if (!p)
 		return;
 
+	ebitmap_destroy(&p->policycaps);
+
 	symtabs_destroy(p->symtab);
 
 	for (i = 0; i < SYM_NUM; i++) {
@@ -3123,6 +3145,16 @@ int policydb_read(policydb_t * p, struct
 		p->version[len] = '\0';
 	}
 
+	if ((p->policyvers >= POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_KERN) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_BASE) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_MOD)) {
+		if (ebitmap_read(&p->policycaps, fp))
+			goto bad;
+	}
+
 	for (i = 0; i < info->sym_num; i++) {
 		rc = next_entry(buf, fp, sizeof(uint32_t) * 2);
 		if (rc < 0)
Index: trunk/libsepol/src/expand.c
===================================================================
--- trunk.orig/libsepol/src/expand.c
+++ trunk/libsepol/src/expand.c
@@ -2252,6 +2252,12 @@ int expand_module(sepol_handle_t * handl
 	out->mls = base->mls;
 	out->handle_unknown = base->handle_unknown;
 
+	/* Copy policy capabilities */
+	if (ebitmap_cpy(&out->policycaps, &base->policycaps)) {
+		ERR(handle, "Out of memory!");
+		goto cleanup;
+	}
+
 	if ((state.typemap =
 	     (uint32_t *) calloc(state.base->p_types.nprim,
 				 sizeof(uint32_t))) == NULL) {
@@ -2418,6 +2424,7 @@ int expand_module(sepol_handle_t * handl
 	retval = 0;
 
       cleanup:
+	ebitmap_destroy(&out->policycaps);
 	free(state.typemap);
 	free(state.boolmap);
 	return retval;
Index: trunk/libsepol/src/write.c
===================================================================
--- trunk.orig/libsepol/src/write.c
+++ trunk/libsepol/src/write.c
@@ -1595,6 +1595,17 @@ int policydb_write(policydb_t * p, struc
 		if (items != len)
 			return POLICYDB_ERROR;
 	}
+
+	if ((p->policyvers >= POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_KERN) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_BASE) ||
+	    (p->policyvers >= MOD_POLICYDB_VERSION_POLCAP &&
+	     p->policy_type == POLICY_MOD)) {
+		if (ebitmap_write(&p->policycaps, fp) == -1)
+			return POLICYDB_ERROR;
+	}
+
 	num_syms = info->sym_num;
 	for (i = 0; i < num_syms; i++) {
 		buf[0] = cpu_to_le32(p->symtab[i].nprim);
Index: trunk/libsepol/src/link.c
===================================================================
--- trunk.orig/libsepol/src/link.c
+++ trunk/libsepol/src/link.c
@@ -2177,8 +2177,14 @@ int link_modules(sepol_handle_t * handle
 		goto cleanup;
 	}
 
-	/* copy all types, declared and required */
+	/* copy all types, declared, required and polcaps */
 	for (i = 0; i < len; i++) {
+		ret = ebitmap_union(&state.base->policycaps,
+				    &modules[i]->policy->policycaps);
+		if (ret) {
+			retval = ret;
+			goto cleanup;
+		}
 		state.cur = modules[i];
 		state.cur_mod_name = modules[i]->policy->name;
 		ret =
Index: trunk/checkpolicy/policy_scan.l
===================================================================
--- trunk.orig/checkpolicy/policy_scan.l
+++ trunk/checkpolicy/policy_scan.l
@@ -201,6 +201,8 @@ h1 |
 H1				{ return(H1); }
 h2 |
 H2				{ return(H2); }
+policycap |
+POLICYCAP			{ return(POLICYCAP);}
 "/"({alnum}|[_.-/])*	        { return(PATH); }
 {letter}({alnum}|[_-])*([.]?({alnum}|[_-]))*	{ return(IDENTIFIER); }
 {digit}+                        { return(NUMBER); }
Index: trunk/checkpolicy/policy_parse.y
===================================================================
--- trunk.orig/checkpolicy/policy_parse.y
+++ trunk/checkpolicy/policy_parse.y
@@ -47,6 +47,7 @@
 #include <sepol/policydb/conditional.h>
 #include <sepol/policydb/flask.h>
 #include <sepol/policydb/hierarchy.h>
+#include <sepol/policydb/polcaps.h>
 #include "queue.h"
 #include "checkpolicy.h"
 #include "module_compiler.h"
@@ -198,6 +199,7 @@ typedef int (* require_func_t)();
 %token IPV4_ADDR
 %token IPV6_ADDR
 %token MODULE VERSION_IDENTIFIER REQUIRE OPTIONAL
+%token POLICYCAP
 
 %left OR
 %left XOR
@@ -323,6 +325,7 @@ te_decl			: attribute_def
                         | transition_def
                         | range_trans_def
                         | te_avtab_def
+			| policycap_def
 			;
 attribute_def           : ATTRIBUTE identifier ';'
                         { if (define_attrib()) return -1;}
@@ -765,6 +768,9 @@ number			: NUMBER 
 ipv6_addr		: IPV6_ADDR
 			{ if (insert_id(yytext,0)) return -1; }
 			;
+policycap_def		: POLICYCAP identifier ';'
+			{if (define_polcap()) return -1;}
+			;
 
 /*********** module grammar below ***********/
 
@@ -962,6 +968,44 @@ static int define_class(void)
 	return -1;
 }
 
+static int define_polcap(void)
+{
+	char *id = 0;
+	int capnum;
+
+	if (pass == 2) {
+		id = queue_remove(id_queue);
+		free(id);
+		return 0;
+	}
+
+	id = (char *)queue_remove(id_queue);
+	if (!id) {
+		yyerror("no capability name for policycap definition?");
+		goto bad;
+	}
+
+	/* Check for valid cap name -> number mapping */
+	capnum = sepol_polcap_getnum(id);
+	if (capnum < 0) {
+		yyerror2("invalid policy capability name %s", id);
+		goto bad;
+	}
+
+	/* Store it */
+	if (ebitmap_set_bit(&policydbp->policycaps, capnum, TRUE)) {
+		yyerror("out of memory");
+		goto bad;
+	}
+
+	free(id);
+	return 0;
+
+      bad:
+	free(id);
+	return -1;
+}
+
 static int define_initial_sid(void)
 {
 	char *id = 0;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
