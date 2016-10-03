Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u93Ie4ed023116
 for <selinux@tycho.nsa.gov>; Mon, 3 Oct 2016 14:40:04 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: Fixes bug preventing the installation of base
 modules
Date: Mon,  3 Oct 2016 14:41:12 -0400
Message-Id: <1475520072-17880-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Commit 7a728e46 changed module installation so that a module pp would
be installed using its module name instead of its filename and a warning
would be printed if they were different. With this change, base modules
could no longer be installed because of the way error handling was done.

This change fixes the error handling, so that when a base module is
installed it will be installed using its filename (since it does not
have a module name).

Based on bug report by Jason Zaman

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsemanage/src/direct_api.c | 39 ++++++++++++++-------------------------
 1 file changed, 14 insertions(+), 25 deletions(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 3719cb1..e5c72cd 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -368,7 +368,7 @@ static int semanage_direct_begintrans(semanage_handle_t * sh)
  * 'version' to module's version.  The caller is responsible for
  * free()ing 'module_name', and 'version'; they will be
  * set to NULL upon entering this function.  Returns 0 on success, -1
- * if out of memory, or -2 if data did not represent a module.
+ * if out of memory.
  */
 static int parse_module_headers(semanage_handle_t * sh, char *module_data,
                                size_t data_len, char **module_name,
@@ -384,23 +384,10 @@ static int parse_module_headers(semanage_handle_t * sh, char *module_data,
        }
        sepol_policy_file_set_mem(pf, module_data, data_len);
        sepol_policy_file_set_handle(pf, sh->sepolh);
-       if (module_data == NULL ||
-           data_len == 0 ||
+       if (module_data != NULL && data_len > 0)
            sepol_module_package_info(pf, &file_type, module_name,
-                                     version) == -1) {
-               sepol_policy_file_free(pf);
-               ERR(sh, "Could not parse module data.");
-               return -2;
-       }
+                                     version);
        sepol_policy_file_free(pf);
-       if (file_type != SEPOL_POLICY_MOD) {
-               if (file_type == SEPOL_POLICY_BASE)
-                       ERR(sh,
-                           "Received a base module, expected a non-base module.");
-               else
-                       ERR(sh, "Data did not represent a module.");
-               return -2;
-       }
 
        return 0;
 }
@@ -1608,22 +1595,24 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 		lang_ext = separator + 1;
 	}
 
-	if (strcmp(lang_ext, "pp") != 0) {
+	if (strcmp(lang_ext, "pp") == 0) {
+		retval = parse_module_headers(sh, data, data_len, &module_name, &version);
+		free(version);
+		if (retval != 0)
+			goto cleanup;
+	}
+
+	if (module_name == NULL) {
 		module_name = strdup(filename);
 		if (module_name == NULL) {
 			ERR(sh, "No memory available for module_name.\n");
 			retval = -1;
 			goto cleanup;
 		}
-	} else {
-		if ((retval = parse_module_headers(sh, data, data_len, &module_name, &version)) != 0)
-			goto cleanup;
-
-		if (strcmp(module_name, filename) != 0)
-			fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
-
-		free(version);
+	} else if (strcmp(module_name, filename) != 0) {
+		fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
 	}
+
 	retval = semanage_direct_install(sh, data, data_len, module_name, lang_ext);
 
 cleanup:
-- 
2.7.4
