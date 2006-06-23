Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NHaiNG009532
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 13:36:44 -0400
Received: from twoface.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5NHagZW022421
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 17:36:42 GMT
Subject: [PATCH 11/10] fix decl val index, other leaks
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 13:36:38 -0400
Message-Id: <1151084198.4719.0.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This makes the decl_val_to_struct index have a -1 offset to be
consistent with all the other indexes. It also fixes some memory leaks
in checkmodule and a fd leak in semodule_link.

diff -purN -x.svn trunk/checkpolicy/checkmodule.c optionals-in-base-take2/checkpolicy/checkmodule.c
--- trunk/checkpolicy/checkmodule.c	2006-05-08 14:42:37.000000000 -0400
+++ optionals-in-base-take2/checkpolicy/checkmodule.c	2006-06-23 12:26:49.000000000 -0400
@@ -27,6 +27,7 @@
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/expand.h>
 #include <sepol/policydb/link.h>
+#include <sepol/policydb/sidtab.h>
 
 #include "queue.h"
 #include "checkpolicy.h"
@@ -244,12 +245,16 @@ int main(int argc, char **argv)
 	if (policydb_load_isids(&modpolicydb, &sidtab))
 		exit(1);
 
+	sepol_sidtab_destroy(&sidtab);
+
 	printf("%s:  policy configuration loaded\n", argv[0]);
 
 	if (outfile &&
             write_binary_policy(&modpolicydb, outfile, argv[0]) == -1) {
                 exit(1);
         }
+	policydb_destroy(&modpolicydb);
+
 	return 0;
 }
 
diff -purN -x.svn trunk/libsepol/src/avrule_block.c optionals-in-base-take2/libsepol/src/avrule_block.c
--- trunk/libsepol/src/avrule_block.c	2006-06-23 11:57:50.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/avrule_block.c	2006-06-23 12:26:49.000000000 -0400
@@ -155,7 +155,7 @@ int is_id_enabled(char *id, policydb_t *
                 return 0;
         }
         for (i = 0; i < scope->decl_ids_len; i++) {
-                avrule_decl_t *decl = p->decl_val_to_struct[scope->decl_ids[i]];
+                avrule_decl_t *decl = p->decl_val_to_struct[scope->decl_ids[i] - 1];
                 if (decl != NULL && decl->enabled) {
                         return 1;
                 }
diff -purN -x.svn trunk/libsepol/src/link.c optionals-in-base-take2/libsepol/src/link.c
--- trunk/libsepol/src/link.c	2006-06-23 11:58:05.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/link.c	2006-06-23 12:26:49.000000000 -0400
@@ -1239,7 +1239,7 @@ static int copy_avrule_block(link_state_
                         last_decl->next = new_decl;
                 }
                 last_decl = new_decl;
-                state->base->decl_val_to_struct[state->next_decl_id] = new_decl;
+                state->base->decl_val_to_struct[state->next_decl_id - 1] = new_decl;
 		state->decl_to_mod[state->next_decl_id] = module->policy;
                 module->avdecl_map[decl->decl_id] = new_decl->decl_id;
 
@@ -1788,7 +1788,7 @@ static int prepare_base(link_state_t *st
         while (cur != NULL) {
                 avrule_decl_t *decl = cur->branch_list;
                 while (decl != NULL) {
-                        state->base->decl_val_to_struct[decl->decl_id] = decl;
+                        state->base->decl_val_to_struct[decl->decl_id - 1] = decl;
 			state->decl_to_mod[decl->decl_id] = state->base;
                         decl = decl->next;
                 }
diff -purN -x.svn trunk/libsepol/src/policydb.c optionals-in-base-take2/libsepol/src/policydb.c
--- trunk/libsepol/src/policydb.c	2006-06-23 11:58:03.000000000 -0400
+++ optionals-in-base-take2/libsepol/src/policydb.c	2006-06-23 12:26:49.000000000 -0400
@@ -655,7 +655,7 @@ int policydb_index_decls(policydb_t *p)
 {
 	avrule_block_t *curblock;
 	avrule_decl_t *decl;
-	int num_decls = 1;
+	int num_decls = 0;
 
 	free(p->decl_val_to_struct);
 
@@ -672,7 +672,7 @@ int policydb_index_decls(policydb_t *p)
 	
 	for (curblock = p->global; curblock != NULL; curblock = curblock->next) {
 		for (decl = curblock->branch_list; decl != NULL; decl = decl->next) {
-			p->decl_val_to_struct[decl->decl_id] = decl;
+			p->decl_val_to_struct[decl->decl_id - 1] = decl;
 		}
 	}
 
diff -purN -x.svn trunk/policycoreutils/semodule_link/semodule_link.c optionals-in-base-take2/policycoreutils/semodule_link/semodule_link.c
--- trunk/policycoreutils/semodule_link/semodule_link.c	2006-06-23 11:57:47.000000000 -0400
+++ optionals-in-base-take2/policycoreutils/semodule_link/semodule_link.c	2006-06-23 12:26:49.000000000 -0400
@@ -153,11 +153,13 @@ int main(int argc, char **argv)
         		exit(1);	
         	}
 		sepol_policy_file_free(pf);
+		fclose(outfile);
         }
 
 	sepol_module_package_free(base);
         for (i = 0; i < num_mods; i++)
         	sepol_module_package_free(mods[i]);
+	free(mods);
 	exit(0);
 }
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
