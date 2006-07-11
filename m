Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6BLBiYi003562
	for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2006 17:11:46 -0400
Received: from localhost.localdomain (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6BLBdAr003140
	for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2006 21:11:41 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.6/8.13.6) with ESMTP id k6BLBdG4004274
	for <selinux@tycho.nsa.gov>; Tue, 11 Jul 2006 17:11:39 -0400
Received: (from kmacmill@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k6BLBcmr004273
	for selinux@tycho.nsa.gov; Tue, 11 Jul 2006 17:11:38 -0400
Subject: [PATCH] semodule_deps
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 11 Jul 2006 17:11:38 -0400
Message-Id: <1152652298.12305.77.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Steve,

Below is a patch for a tool that generates dependency information about
policy modules (in the form of policy packages). It also adds a field to
export the source module name for each avrule_block in a linked policy.
Please apply.

Thanks,

Karl

diff --git a/libsepol/include/sepol/policydb/policydb.h b/libsepol/include/sepol/policydb/policydb.h
index 4ab43eb..9896d8b 100644
--- a/libsepol/include/sepol/policydb/policydb.h
+++ b/libsepol/include/sepol/policydb/policydb.h
@@ -326,6 +326,10 @@ typedef struct avrule_decl {
 
 	/* for additive statements (type attribute, roles, and users) */
 	symtab_t symtab[SYM_NUM];
+	
+	/* In a linked module this will contain the name of the module
+	 * from which this avrule_decl originated. */
+	char *module_name;
 
 	struct avrule_decl *next;
 } avrule_decl_t;
diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
index 576db49..73ff53d 100644
--- a/libsepol/src/avrule_block.c
+++ b/libsepol/src/avrule_block.c
@@ -102,6 +102,7 @@ void avrule_decl_destroy(avrule_decl_t *
 	scope_index_destroy(&x->required);
 	scope_index_destroy(&x->declared);
 	symtabs_destroy(x->symtab);
+	free(x->module_name);
 	free(x);
 }
 
diff --git a/libsepol/src/link.c b/libsepol/src/link.c
index 7162096..9f2c3a5 100644
--- a/libsepol/src/link.c
+++ b/libsepol/src/link.c
@@ -1319,6 +1319,16 @@ static int copy_avrule_block(link_state_
 			ret = -1;
 			goto cleanup;
 		}
+
+		if (module->policy->name != NULL) {
+			new_decl->module_name = strdup(module->policy->name);
+			if (new_decl->module_name == NULL) {
+				ERR(state->handle, "Out of memory\n");
+				ret = -1;
+				goto cleanup;
+			}
+		}
+
 		if (last_decl == NULL) {
 			new_block->branch_list = new_decl;
 		} else {
@@ -1328,6 +1338,7 @@ static int copy_avrule_block(link_state_
 		state->base->decl_val_to_struct[state->next_decl_id - 1] =
 		    new_decl;
 		state->decl_to_mod[state->next_decl_id] = module->policy;
+
 		module->avdecl_map[decl->decl_id] = new_decl->decl_id;
 
 		ret = copy_avrule_decl(state, module, decl, new_decl);
@@ -1609,10 +1620,8 @@ static int debug_requirements(link_state
 		if (ret < 0) {
 			return ret;
 		} else if (ret == 0) {
-			char *mod_name =
-			    state->decl_to_mod[cur->branch_list->decl_id]->
-			    name ? state->decl_to_mod[cur->branch_list->
-						      decl_id]->name : "BASE";
+			char *mod_name = cur->branch_list->module_name ?
+				cur->branch_list->module_name : "BASE";
 			if (req.symbol_type == SYM_CLASSES) {
 
 				struct find_perm_arg fparg;
@@ -1677,8 +1686,9 @@ static void print_missing_requirements(l
 				       missing_requirement_t * req)
 {
 	policydb_t *p = state->base;
-	char *mod_name = state->decl_to_mod[cur->branch_list->decl_id]->name ?
-	    state->decl_to_mod[cur->branch_list->decl_id]->name : "BASE";
+	char *mod_name = cur->branch_list->module_name ?
+		cur->branch_list->module_name : "BASE";
+
 	if (req->symbol_type == SYM_CLASSES) {
 
 		struct find_perm_arg fparg;
@@ -1749,10 +1759,8 @@ static int enable_avrules(link_state_t *
 			}
 			decl = block->branch_list;
 			if (state->verbose) {
-				char *mod_name =
-				    state->decl_to_mod[decl->decl_id]->
-				    name ? state->decl_to_mod[decl->decl_id]->
-				    name : "BASE";
+				char *mod_name = decl->module_name ?
+					decl->module_name : "BASE";
 				INFO(state->handle, "check module %s decl %d\n",
 				     mod_name, decl->decl_id);
 			}
diff --git a/policycoreutils/Makefile b/policycoreutils/Makefile
index c826ac8..c0c575f 100644
--- a/policycoreutils/Makefile
+++ b/policycoreutils/Makefile
@@ -1,4 +1,4 @@
-SUBDIRS=setfiles semanage load_policy newrole run_init restorecon restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand setsebool po
+SUBDIRS=setfiles semanage load_policy newrole run_init restorecon restorecond secon audit2allow audit2why scripts sestatus semodule_package semodule semodule_link semodule_expand semodule_deps setsebool po
 
 all install relabel clean: 
 	@for subdir in $(SUBDIRS); do \
diff --git a/policycoreutils/semodule_deps/Makefile b/policycoreutils/semodule_deps/Makefile
new file mode 100644
index 0000000..d8ad956
--- /dev/null
+++ b/policycoreutils/semodule_deps/Makefile
@@ -0,0 +1,24 @@
+# Installation directories.
+PREFIX ?= ${DESTDIR}/usr
+INCLUDEDIR ?= $(PREFIX)/include
+BINDIR ?= $(PREFIX)/bin
+LIBDIR ?= ${PREFIX}/lib
+MANDIR ?= $(PREFIX)/share/man
+
+CFLAGS ?= -Werror -Wall -W
+override CFLAGS += -I$(INCLUDEDIR)
+LDLIBS = $(LIBDIR)/libsepol.a
+
+all: semodule_deps
+
+semodule_deps:  semodule_deps.o 
+
+install: all
+	-mkdir -p $(BINDIR)
+	install -m 755 semodule_deps $(BINDIR)
+	test -d $(MANDIR)/man8 || install -m 755 -d $(MANDIR)/man8
+
+relabel:
+
+clean:
+	-rm -f semodule_deps *.o 
diff --git a/policycoreutils/semodule_deps/semodule_deps.8 b/policycoreutils/semodule_deps/semodule_deps.8
new file mode 100644
index 0000000..be0c393
--- /dev/null
+++ b/policycoreutils/semodule_deps/semodule_deps.8
@@ -0,0 +1,46 @@
+.TH SEMODULE_DEPS "8" "June 2006" "Security Enhanced Linux" NSA
+.SH NAME 
+semodule_deps \- show the dependencies between policy packages.
+
+.SH SYNOPSIS
+.B semodule_deps [-v -g -b] basemodpkg modpkg1 [modpkg2 ... ]
+.br
+.SH DESCRIPTION
+.PP
+semodule_deps is a developer tool for showing the dependencies
+between policy packages. For each module it prints a list of
+modules that must be present for a module's requirements to
+be satisfied. It only deals with requirements, not optional
+dependencies.
+
+In order for semodule_deps to give useful information the list
+of packages passed in cannot have unsatisfied dependencies. In
+general this means that the list of modules will usually be
+quite long.
+
+By default options to the base module are excluded as almost every
+module has this dependency. The -b option will include these
+dependencies.
+
+In addition to human readable output, semodule_deps can output the
+dependencies in the Graphviz dot format (http://www.graphviz.org/)
+using the -g option. This is useful for producing a picture of the
+dependencies.
+
+.SH "OPTIONS"
+.TP
+.B \-v
+verbose mode
+.TP
+.B \-g
+output dependency information in Graphviz dot format
+.TP
+.B \-b
+include dependencies to the base module - by default these are excluded
+
+.SH SEE ALSO
+.B checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)
+.SH AUTHORS
+.nf
+This manual page was written by Karl MacMillan <kmacmillan@mentalrootkit.com>.
+The program was written by Karl MacMillan <kmacmillan@mentalrootkit.com>.
diff --git a/policycoreutils/semodule_deps/semodule_deps.c b/policycoreutils/semodule_deps/semodule_deps.c
new file mode 100644
index 0000000..3f770db
--- /dev/null
+++ b/policycoreutils/semodule_deps/semodule_deps.c
@@ -0,0 +1,360 @@
+/* Authors: Karl MacMillan <kmacmillan@mentalrootkit.com>
+ *
+ * Copyright (C) 2006 Tresys Technology, LLC
+ * Copyright (C) 2006 Red Hat, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, version 2.
+ *
+ */
+ 
+
+/* Because we _must_ muck around in the internal representation of
+ * the policydb (and include the internal header below) this program
+ * must be statically linked to libsepol like checkpolicy. It is
+ * not clear if it is worthwhile to fix this, as exposing the details
+ * of avrule_blocks - even in an ABI safe way - seems undesirable.
+ */
+#include <sepol/module.h>
+#include <sepol/policydb/policydb.h>
+
+#include <getopt.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <string.h>
+#include <assert.h>
+
+/* for getopt */
+extern char *optarg;
+extern int optind;
+
+/* This is really a horrible hack, but the base module
+ * is referred to with the following name. The same
+ * thing is done in the linker for displaying error
+ * messages.
+ */
+#define BASE_NAME "BASE"
+
+static void usage(char *program_name)
+{
+        printf("usage: %s [-v -g -b] basemodpkg modpkg1 [modpkg2 ... ]\n", program_name);
+        exit(1);
+}
+
+/* Basic string hash and compare for the hashtables used in
+ * generate_requires. Copied from symtab.c.
+ */
+static unsigned int reqsymhash(hashtab_t h, hashtab_key_t key)
+{
+	char *p, *keyp;
+	size_t size;
+	unsigned int val;
+
+	val = 0;
+	keyp = (char *) key;
+	size = strlen(keyp);
+	for (p = keyp; ((size_t)(p - keyp)) < size; p++)
+		val = (val << 4 | (val >> (8*sizeof(unsigned int)-4))) ^ (*p);
+	return val & (h->size - 1);
+}
+
+static int reqsymcmp(hashtab_t h __attribute__ ((unused)), hashtab_key_t key1, hashtab_key_t key2)
+{
+	char *keyp1, *keyp2;
+
+	keyp1 = (char *) key1;
+	keyp2 = (char *) key2;
+	return strcmp(keyp1, keyp2);
+}
+
+/* Load a policy package from the given filename. Progname is used for
+ * error reporting.
+ */
+static sepol_module_package_t *load_module(char *filename, char *progname)
+{
+	int ret;
+	FILE *fp = NULL;
+	struct sepol_policy_file *pf = NULL;
+	sepol_module_package_t *p = NULL;
+
+	if (sepol_module_package_create(&p)) {
+		fprintf(stderr, "%s:  Out of memory\n", progname);
+		goto bad;
+	}
+	if (sepol_policy_file_create(&pf)) {
+		fprintf(stderr, "%s:  Out of memory\n", progname);
+		goto bad;
+	}
+	fp = fopen(filename, "r");
+	if (!fp) {
+		fprintf(stderr, "%s:  Could not open package %s:  %s", progname, filename, strerror(errno));
+		goto bad;
+	}
+	sepol_policy_file_set_fp(pf, fp);
+	
+	ret = sepol_module_package_read(p, pf, 0);
+	if (ret) {
+		fprintf(stderr, "%s:  Error while reading package from %s\n", progname, filename);
+		goto bad;
+	}
+	fclose(fp);
+	sepol_policy_file_free(pf);
+	return p;
+bad:
+	sepol_module_package_free(p);
+	sepol_policy_file_free(pf);
+	if (fp)
+		fclose(fp);
+	return NULL;
+}
+
+/* This function generates the requirements graph and stores it in
+ * a set of nested hashtables. The top level hash table stores modules
+ * keyed by name. The value of that module is a hashtable storing all
+ * of the requirements keyed by name. There is no value for the requirements
+ * hashtable.
+ *
+ * This only tracks symbols that are _required_ - optional symbols
+ * are completely ignored. A future version might look at this.
+ *
+ * This requirement generation only looks at booleans and types because:
+ *  - object classes: (for now) only present in bases
+ *  - roles: since they are multiply declared it is not clear how
+ *           to present these requirements as they will be satisfied
+ *           by multiple modules.
+ *  - users: same problem as roles plus they are usually defined outside
+ *           of the policy.
+ *  - levels / cats: can't be required or used in modules.
+ */
+static int generate_requires(policydb_t *p, hashtab_t *r)
+{
+	avrule_block_t *block;
+	avrule_decl_t *decl;
+	char *mod_name, *req_name, *id;
+	ebitmap_t *b;
+	ebitmap_node_t *node;
+	uint32_t i, j;
+	int ret;
+	scope_datum_t *scope;
+	hashtab_t mods;
+	hashtab_t reqs;
+
+	mods = hashtab_create(reqsymhash, reqsymcmp, 64);
+	if (mods == NULL)
+		return -1;
+
+	for (block = p->global; block != NULL; block = block->next) {
+		if (block->flags & AVRULE_OPTIONAL)
+			continue;
+		for (decl = block->branch_list; decl != NULL; decl = decl->next) {
+			mod_name = decl->module_name ? decl->module_name : BASE_NAME;
+			for (i = 0; i < SYM_NUM; i++) {
+				if (!(i == SYM_TYPES || i == SYM_BOOLS))
+					continue;
+				b = &decl->required.scope[i];
+				ebitmap_for_each_bit(b, node, j) {
+					if (!ebitmap_node_get_bit(node, j))
+						continue;
+					id = p->sym_val_to_name[i][j];
+					scope = (scope_datum_t *)hashtab_search(p->scope[i].table, id);
+					/* since this is only called after a successful link,
+					 * this should never happen */
+					assert(scope->scope == SCOPE_DECL);
+					req_name = p->decl_val_to_struct[scope->decl_ids[0]]->module_name ? 
+						p->decl_val_to_struct[scope->decl_ids[0]]->module_name : BASE_NAME;
+
+					reqs = (hashtab_t)hashtab_search(mods, mod_name);
+					if (!reqs) {
+						reqs = hashtab_create(reqsymhash, reqsymcmp, 64);
+						if (reqs == NULL) {
+							return -1;
+						}
+						ret = hashtab_insert(mods, mod_name, reqs);
+						if (ret != HASHTAB_SUCCESS)
+							return ret;
+					}
+					ret = hashtab_insert(reqs, req_name, NULL);
+					if (!(ret == HASHTAB_PRESENT || ret == HASHTAB_SUCCESS))
+						return -1;
+				}
+			}
+			
+		}
+	}
+
+	*r = mods;
+
+	return 0;
+}
+
+static void free_requires(hashtab_t req)
+{
+	unsigned int i;
+	hashtab_ptr_t cur;
+
+	/* We steal memory for everything stored in the hash tables
+	 * from the policydb, so this only looks like it leaks.
+	 */
+	for (i = 0; i < req->size; i++) {
+		cur = req->htable[i];
+		while (cur != NULL) {
+			hashtab_destroy((hashtab_t)cur->datum);
+			cur = cur->next;
+		}
+	}
+	hashtab_destroy(req);
+}
+
+static void output_graphviz(hashtab_t mods, int exclude_base, FILE *f)
+{
+	unsigned int i, j;
+	hashtab_ptr_t cur, cur2;
+	hashtab_t reqs;
+	
+	fprintf(f, "digraph mod_deps {\n");
+	fprintf(f, "\toverlap=false\n");
+
+	for (i = 0; i < mods->size; i++) {
+		cur = mods->htable[i];
+		while (cur != NULL) {
+			reqs = (hashtab_t)cur->datum;
+			assert(reqs);
+			for (j = 0; j < reqs->size; j++) {
+				cur2 = reqs->htable[j];
+				while (cur2 != NULL) {
+					if (exclude_base && strcmp(cur2->key, BASE_NAME) == 0) {
+						cur2 = cur2->next;
+						continue;
+					}
+					fprintf(f, "\t%s -> %s\n", cur->key, cur2->key);
+					cur2 = cur2->next;
+				}
+			}
+			cur = cur->next;
+		}
+	}
+	fprintf(f, "}\n");
+}
+
+static void output_requirements(hashtab_t mods, int exclude_base, FILE *f)
+{
+	unsigned int i, j;
+	hashtab_ptr_t cur, cur2;
+	hashtab_t reqs;
+	int found_req;
+	
+	for (i = 0; i < mods->size; i++) {
+		cur = mods->htable[i];
+		while (cur != NULL) {
+			reqs = (hashtab_t)cur->datum;
+			assert(reqs);
+			fprintf(f, "module: %s\n", cur->key);
+			found_req = 0;
+			for (j = 0; j < reqs->size; j++) {
+				cur2 = reqs->htable[j];
+				while (cur2 != NULL) {
+					if (exclude_base && strcmp(cur2->key, BASE_NAME) == 0) {
+						cur2 = cur2->next;
+						continue;
+					}
+					found_req = 1;
+					fprintf(f, "\t%s\n", cur2->key);
+					cur2 = cur2->next;
+				}
+			}
+			if (!found_req)
+				fprintf(f, "\t[no dependencies]\n");
+			cur = cur->next;
+		}
+	}
+	fprintf(f, "}\n");
+}
+
+/* Possible commands - see the command variable in
+ * main below and the man page for more info.
+ */
+#define SHOW_DEPS    1
+#define GEN_GRAPHVIZ 2
+
+
+int main(int argc, char **argv)
+{
+	int ch, i, num_mods;
+	int verbose = 0, exclude_base = 1, command = SHOW_DEPS;
+	char *basename;
+	sepol_module_package_t *base, **mods;
+	hashtab_t req;
+
+	while ((ch = getopt(argc, argv, "vgb")) != EOF) {
+                switch (ch) {
+                case 'v':
+                	verbose = 1;
+                	break;
+		case 'g':
+			command = GEN_GRAPHVIZ;
+			break;
+		case 'b':
+			exclude_base = 0;
+			break;
+                default:
+                        usage(argv[0]);
+                }
+        }
+        
+        /* check args */
+        if (argc < 3 || !(optind != (argc - 1))) {
+                fprintf(stderr, "%s:  You must provide the base module package and at least one other module package\n", argv[0]);
+                usage(argv[0]);
+        }
+        
+        basename = argv[optind++];
+        base = load_module(basename, argv[0]);
+        if (!base) {
+        	fprintf(stderr, "%s:  Could not load base module from file %s\n", argv[0], basename);
+        	exit(1);
+        }
+       
+        num_mods = argc - optind;
+        mods = (sepol_module_package_t**)malloc(sizeof(sepol_module_package_t*) * num_mods);
+        if (!mods) {
+        	fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+        	exit(1);	
+        }
+        memset(mods, 0, sizeof(sepol_module_package_t*) * num_mods);
+        
+        for (i = 0; optind < argc; optind++, i++) {
+        	mods[i] = load_module(argv[optind], argv[0]);
+        	if (!mods[i]) {
+			fprintf(stderr, "%s:  Could not load module from file %s\n", argv[0], argv[optind]);
+        		exit(1);
+		}
+        }
+
+        if (sepol_link_packages(NULL, base, mods, num_mods, verbose)) {
+        	fprintf(stderr, "%s:  Error while linking packages\n", argv[0]);
+        	exit(1);	
+        }
+        
+	if (generate_requires((policydb_t*)sepol_module_package_get_policy(base), &req) < 0)
+		exit(1);
+
+	if (command == SHOW_DEPS)
+		output_requirements(req, exclude_base, stdout);
+	else
+		output_graphviz(req, exclude_base, stdout);
+
+	sepol_module_package_free(base);
+        for (i = 0; i < num_mods; i++)
+        	sepol_module_package_free(mods[i]);
+
+	free_requires(req);
+
+	exit(0);
+}


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
