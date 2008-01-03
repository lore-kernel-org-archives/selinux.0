Message-Id: <20080103184516.218603769@tresys.com>
References: <20080103184331.485176161@tresys.com>
Date: Thu, 03 Jan 2008 13:43:37 -0500
From: tmiller@tresys.com
To: selinux@tycho.nsa.gov
Cc: method@madmethod.com, sds@tycho.nsa.gov
Subject: [patch 6/7] quiet policycoreutils warnings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Avoid using "log" as a variable name, it conflicts with the gcc
log() builtin.

Fix gcc uninitialized variable warning false positives.

---
 policycoreutils/audit2why/audit2why.c         |    2 +-
 policycoreutils/semodule/semodule.c           |    4 ++--
 policycoreutils/semodule_deps/semodule_deps.c |   23 +++++++++++++----------
 policycoreutils/setfiles/setfiles.c           |    6 +++---
 4 files changed, 19 insertions(+), 16 deletions(-)

Index: trunk/policycoreutils/audit2why/audit2why.c
===================================================================
--- trunk.orig/policycoreutils/audit2why/audit2why.c
+++ trunk/policycoreutils/audit2why/audit2why.c
@@ -28,7 +28,7 @@ int main(int argc, char **argv)
 	char *buffer = NULL, *bufcopy = NULL;
 	unsigned int lineno = 0;
 	size_t len = 0, bufcopy_len = 0;
-	FILE *fp;
+	FILE *fp = NULL;
 	int opt, rc, set_path = 0;
 	char *p, *scon, *tcon, *tclassstr, *permstr;
 	sepol_security_id_t ssid, tsid;
Index: trunk/policycoreutils/semodule/semodule.c
===================================================================
--- trunk.orig/policycoreutils/semodule/semodule.c
+++ trunk/policycoreutils/semodule/semodule.c
@@ -339,8 +339,8 @@ int main(int argc, char *argv[])
 	for (i = 0; i < num_commands; i++) {
 		enum client_modes mode = commands[i].mode;
 		char *mode_arg = commands[i].arg;
-		char *data;
-		size_t data_len;
+		char *data = NULL;
+		size_t data_len = 0;
 		if (mode == INSTALL_M || mode == UPGRADE_M || mode == BASE_M) {
 			if ((data_len = map_file(mode_arg, &data)) == 0) {
 				fprintf(stderr,
Index: trunk/policycoreutils/semodule_deps/semodule_deps.c
===================================================================
--- trunk.orig/policycoreutils/semodule_deps/semodule_deps.c
+++ trunk/policycoreutils/semodule_deps/semodule_deps.c
@@ -139,7 +139,7 @@ static sepol_module_package_t *load_modu
  *           of the policy.
  *  - levels / cats: can't be required or used in modules.
  */
-static int generate_requires(policydb_t * p, hashtab_t * r)
+static hashtab_t generate_requires(policydb_t * p)
 {
 	avrule_block_t *block;
 	avrule_decl_t *decl;
@@ -154,7 +154,7 @@ static int generate_requires(policydb_t 
 
 	mods = hashtab_create(reqsymhash, reqsymcmp, 64);
 	if (mods == NULL)
-		return -1;
+		return NULL;
 
 	for (block = p->global; block != NULL; block = block->next) {
 		if (block->flags & AVRULE_OPTIONAL)
@@ -196,14 +196,14 @@ static int generate_requires(policydb_t 
 								   reqsymcmp,
 								   64);
 						if (reqs == NULL) {
-							return -1;
+							return NULL;
 						}
 						ret =
 						    hashtab_insert(mods,
 								   mod_name,
 								   reqs);
 						if (ret != SEPOL_OK)
-							return ret;
+							return NULL;
 					}
 					ret =
 					    hashtab_insert(reqs, req_name,
@@ -211,16 +211,14 @@ static int generate_requires(policydb_t 
 					if (!
 					    (ret == SEPOL_EEXIST
 					     || ret == SEPOL_OK))
-						return -1;
+						return NULL;
 				}
 			}
 
 		}
 	}
 
-	*r = mods;
-
-	return 0;
+	return mods;
 }
 
 static void free_requires(hashtab_t req)
@@ -323,6 +321,7 @@ int main(int argc, char **argv)
 	int verbose = 0, exclude_base = 1, command = SHOW_DEPS;
 	char *basename;
 	sepol_module_package_t *base, **mods;
+	policydb_t *p;
 	hashtab_t req;
 
 	while ((ch = getopt(argc, argv, "vgb")) != EOF) {
@@ -383,8 +382,12 @@ int main(int argc, char **argv)
 		exit(1);
 	}
 
-	if (generate_requires
-	    ((policydb_t *) sepol_module_package_get_policy(base), &req) < 0)
+	p = (policydb_t *) sepol_module_package_get_policy(base);
+	if (p == NULL)
+		exit(1);
+
+	req = generate_requires(p);
+	if (req == NULL)
 		exit(1);
 
 	if (command == SHOW_DEPS)
Index: trunk/policycoreutils/setfiles/setfiles.c
===================================================================
--- trunk.orig/policycoreutils/setfiles/setfiles.c
+++ trunk/policycoreutils/setfiles/setfiles.c
@@ -53,7 +53,7 @@ static int change = 1;
 static int quiet = 0;
 static int ignore_enoent;
 static int verbose = 0;
-static int log = 0;
+static int logging = 0;
 static int warn_no_match = 0;
 static char *rootpath = NULL;
 static int rootpathlen = 0;
@@ -519,7 +519,7 @@ static int restore(const char *file)
 		}
 	}
 
-	if (log && !user_only_changed) {
+	if (logging && !user_only_changed) {
 		if (context)
 			syslog(LOG_INFO, "relabeling %s from %s to %s\n",
 			       my_file, context, newcon);
@@ -858,7 +858,7 @@ int main(int argc, char **argv)
 			ignore_enoent = 1;
 			break;
 		case 'l':
-			log = 1;
+			logging = 1;
 			break;
 		case 'F':
 			force = 1;

-- 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
