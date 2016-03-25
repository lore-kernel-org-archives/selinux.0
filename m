Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2PI3jdH032616
 for <selinux@tycho.nsa.gov>; Fri, 25 Mar 2016 14:03:45 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/3] libsepol: Add function to check if module name matches
 filename
Date: Fri, 25 Mar 2016 14:04:53 -0400
Message-Id: <1458929095-25819-2-git-send-email-jwcart2@tycho.nsa.gov>
In-Reply-To: <1458929095-25819-1-git-send-email-jwcart2@tycho.nsa.gov>
References: <1458929095-25819-1-git-send-email-jwcart2@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

The function sepol_module_check_name_matches_filename() compares
the module name with a filename (after stripping off path and file
extension) and returns 0 if they match. The function
sepol_module_get_name() returns the name of the module.

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/include/sepol/module.h |  3 +++
 libsepol/src/libsepol.map.in    |  2 ++
 libsepol/src/module.c           | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/libsepol/include/sepol/module.h b/libsepol/include/sepol/module.h
index ff27f96..4e31d6e 100644
--- a/libsepol/include/sepol/module.h
+++ b/libsepol/include/sepol/module.h
@@ -82,5 +82,8 @@ extern int sepol_expand_module(sepol_handle_t * handle,
 			       sepol_policydb_t * base,
 			       sepol_policydb_t * out, int verbose, int check);
 
+char *sepol_module_get_name(sepol_policydb_t *module);
+int sepol_module_check_name_matches_filename(sepol_policydb_t *module, const char *path);
+
 __END_DECLS
 #endif
diff --git a/libsepol/src/libsepol.map.in b/libsepol/src/libsepol.map.in
index 0a46b09..db2241b 100644
--- a/libsepol/src/libsepol.map.in
+++ b/libsepol/src/libsepol.map.in
@@ -48,5 +48,7 @@ LIBSEPOL_1.1 {
 	sepol_ppfile_to_module_package;
 	sepol_module_package_to_cil;
 	sepol_module_policydb_to_cil;
+	sepol_module_get_name;
+	sepol_module_check_name_matches_filename;
   local: *;
 } LIBSEPOL_1.0;
diff --git a/libsepol/src/module.c b/libsepol/src/module.c
index 1665ede..ce514d5 100644
--- a/libsepol/src/module.c
+++ b/libsepol/src/module.c
@@ -30,6 +30,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <limits.h>
+#include <libgen.h>
 
 #define SEPOL_PACKAGE_SECTION_FC 0xf97cff90
 #define SEPOL_PACKAGE_SECTION_SEUSER 0x97cff91
@@ -1006,3 +1007,38 @@ int sepol_expand_module(sepol_handle_t * handle,
 {
 	return expand_module(handle, &base->p, &out->p, verbose, check);
 }
+
+char *sepol_module_get_name(sepol_policydb_t *module)
+{
+	return module->p.name;
+}
+
+int sepol_module_check_name_matches_filename(sepol_policydb_t *module, const char *path)
+{
+	char *filepath, *filename, *separator;
+	int rc = -1;
+
+	if (module->p.policy_type == POLICY_BASE)
+		return 0;
+
+	filepath = strdup(path);
+	filename = basename(filepath);
+
+	if (strcmp(module->p.name, filename) != 0) {
+		separator = strrchr(filename, '.');
+		if (separator == NULL)
+			goto exit;
+
+		*separator = '\0';
+
+		if (strcmp(module->p.name, filename) != 0)
+			goto exit;
+	}
+
+	rc = 0;
+
+exit:
+	free(filepath);
+
+	return rc;
+}
-- 
2.5.5
