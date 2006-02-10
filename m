Message-ID: <43ED0594.6010605@tresys.com>
Date: Fri, 10 Feb 2006 16:28:52 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] optionals in base
Content-Type: multipart/mixed;
 boundary="------------020606050504020502010807"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020606050504020502010807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for optionals in base policy. This is necessary 
because currently optional policy in base is handled with m4 ifdefs 
which make the rules disappear if the corresponding module isn't 
present. This means that if the module is inserted at a later time the 
rules will not be enabled.

Since we didn't want to diverge the base policy and monolithic policy 
grammar monolithic policies also support optionals.

The link step resolves all optional dependancies and therefore all base 
modules (including ones which are being written to a kernel policy) must 
call link prior to calling expand. This was added to checkpolicy and to 
semodule_expand, as well as removing a check for 0 modules in 
semanage_store.c

--------------020606050504020502010807
Content-Type: text/x-patch;
 name="1-optional-in-base.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1-optional-in-base.diff"

diff -pruN -x .svn checkpolicy/checkpolicy.c checkpolicy/checkpolicy.c
--- checkpolicy/checkpolicy.c	2005-12-08 10:42:22.000000000 -0500
+++ checkpolicy/checkpolicy.c	2006-02-10 11:35:13.000000000 -0500
@@ -76,6 +76,7 @@
 #include <sepol/policydb/hierarchy.h>
 #include <sepol/policydb/flask.h>
 #include <sepol/policydb/expand.h>
+#include <sepol/policydb/link.h>
 
 #include "queue.h"
 #include "checkpolicy.h"
@@ -530,6 +531,12 @@ int main(int argc, char **argv)
 			exit(1);
 		}
 
+		/* Linking takes care of optional avrule blocks */
+        	if (link_modules(NULL, &parse_policy, NULL, 0, 0)) {
+			fprintf(stderr, "Error while resolving optionals\n");
+			exit(1);
+		}
+
 		if (expand_module(NULL, &parse_policy, &policydb, 0, 1)) {
                         fprintf(stderr, "Error while expanding policy\n");
 			exit(1);
diff -pruN -x .svn checkpolicy/module_compiler.c checkpolicy/module_compiler.c
--- checkpolicy/module_compiler.c	2005-12-08 10:42:22.000000000 -0500
+++ checkpolicy/module_compiler.c	2006-02-10 15:05:13.000000000 -0500
@@ -75,9 +75,6 @@ int define_policy(int pass, int module_h
                                 return -1;
                         }
                 }
-                /* the first declaration within the global avrule
-                   block will always have an id of 1 */
-                next_decl_id = 2;
         }
         else {
                 if (policydbp->policy_type == POLICY_MOD) {
@@ -85,6 +82,9 @@ int define_policy(int pass, int module_h
                         return -1;
                 }
         }
+	/* the first declaration within the global avrule
+	  block will always have an id of 1 */
+	next_decl_id = 2;
 
         /* reset the scoping stack */
         while (stack_top != NULL) {
@@ -462,9 +462,7 @@ type_datum_t *get_local_type(char *id, u
  * have its own requirements.
  */
 static int is_require_allowed(void) {
-        if (policydbp->policy_type == POLICY_MOD &&
-	    stack_top->type == 1 &&
-            !stack_top->in_else) {
+        if (stack_top->type == 1 && !stack_top->in_else) {
                 return 1;
         }
         return 0;
@@ -1184,9 +1182,14 @@ int end_avrule_block(int pass) {
                 return 0;
         }
         if (!stack_top->in_else && !stack_top->require_given) {
-                /* non-ELSE branches must have at least one thing required */
-                yyerror("This block has no require section.");
-                return -1;
+		if (policydbp->policy_type == POLICY_BASE && stack_top->parent != NULL) {
+			/* if this is base no require should be in the global block */
+			return 0;
+		} else {
+	                /* non-ELSE branches must have at least one thing required */
+        	        yyerror("This block has no require section.");
+                	return -1;
+		}
         }
         return 0;
 }
diff -pruN -x .svn checkpolicy/policy_parse.y checkpolicy/policy_parse.y
--- checkpolicy/policy_parse.y	2006-02-01 08:37:57.000000000 -0500
+++ checkpolicy/policy_parse.y	2006-02-10 15:05:29.000000000 -0500
@@ -305,6 +305,7 @@ te_rbac			: te_rbac_decl
 te_rbac_decl		: te_decl
 			| rbac_decl
                         | cond_stmt_def
+			| optional_block
 			| ';'
                         ;
 rbac_decl		: role_type_def
diff -pruN -x .svn libsemanage/src/semanage_store.c libsemanage/src/semanage_store.c
--- libsemanage/src/semanage_store.c	2006-02-10 13:41:04.000000000 -0500
+++ libsemanage/src/semanage_store.c	2006-02-10 14:18:39.000000000 -0500
@@ -1371,11 +1371,6 @@ int semanage_link_sandbox(semanage_handl
 	    semanage_load_module(sh, base_filename, base) == -1) {
 		goto cleanup;
 	}
-	if (num_modules == 0) {
-		/* no modules, so skip over the rest of this function */
-		retval = 0;
-		goto cleanup;
-	}
 	if ((mods = calloc(num_modules, sizeof(*mods))) == NULL) {
 		ERR(sh, "Out of memory!");
 		num_modules  = 0;
diff -pruN -x .svn libsepol/src/expand.c libsepol/src/expand.c
--- libsepol/src/expand.c	2006-01-06 10:02:02.000000000 -0500
+++ libsepol/src/expand.c	2006-02-10 16:00:51.000000000 -0500
@@ -1700,7 +1700,9 @@ err:
 	return -1;
 }
 
-
+/* Linking should always be done before calling expand, even if
+ * there is only a base since all optionals are dealt with at link time
+ */
 int expand_module(sepol_handle_t *handle,
 		  policydb_t *base, policydb_t *out,
 		  int verbose, int check)
diff -pruN -x .svn policycoreutils/semodule_expand/semodule_expand.c policycoreutils/semodule_expand/semodule_expand.c
--- policycoreutils/semodule_expand/semodule_expand.c	2006-02-06 17:23:54.000000000 -0500
+++ policycoreutils/semodule_expand/semodule_expand.c	2006-02-10 16:08:55.000000000 -0500
@@ -40,7 +40,7 @@ int main(int argc, char **argv)
 	int ch, ret, show_version = 0, verbose = 0;
 	struct sepol_policy_file *pf;
 	sepol_module_package_t *base;
-	sepol_policydb_t *out;
+	sepol_policydb_t *out, *p;
 	FILE *fp, *outfile;
 
 	while ((ch = getopt(argc, argv, "c:Vv")) != EOF) {
@@ -115,6 +115,13 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 	fclose(fp);
+
+	/* linking the base takes care of enabling optional avrules */
+	p = sepol_module_package_get_policy(base);
+	if (sepol_link_modules(NULL, p, NULL, 0, 0)) {
+		fprintf(stderr, "%s:  Error while enabling avrules\n", argv[0]);
+		exit(1);
+	}
 	
 	/* create the output policy */
 
@@ -123,7 +130,7 @@ int main(int argc, char **argv)
                 exit(1);
         }
 
-        if (sepol_expand_module(NULL, sepol_module_package_get_policy(base), out, verbose, 1)) {
+        if (sepol_expand_module(NULL, p, out, verbose, 1)) {
         	fprintf(stderr, "%s:  Error while expanding policy\n", argv[0]);
         	exit(1);
         }

--------------020606050504020502010807--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
