Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8N9NcwH026981
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 05:23:38 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
 (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C2E37C05490D
 for <selinux@tycho.nsa.gov>; Fri, 23 Sep 2016 09:23:29 +0000 (UTC)
From: Petr Lautrbach <plautrba@redhat.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH] libsemanage: use pp module headers as a source for a module
 name
Date: Fri, 23 Sep 2016 11:23:20 +0200
Message-Id: <1474622600-22721-1-git-send-email-plautrba@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

When a user installs a module, the filename is used as the module name.
This change was introduced with CIL language where a module name is not
stored in the module itself. It means that when a pp module has
different filename and stored module name, the filename is used instead
of the stored module name. It brings problems with compatibility for
scripts and modules which were built and used on older system and were
migrated to the new userspace.

This patch changes the behavior of semanage_direct_install_file() which
is used by 'semodule -i' so that when a module with pp language
extension is installed, it tries to get and use a stored module name
instead of a filename.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 libsemanage/src/direct_api.c | 62 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 2187b65..f98d3d1 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -363,6 +363,48 @@ static int semanage_direct_begintrans(semanage_handle_t * sh)
 
 /********************* utility functions *********************/
 
+/* Takes a module stored in 'module_data' and parses its headers.
+ * Sets reference variables 'module_name' to module's name, and
+ * 'version' to module's version.  The caller is responsible for
+ * free()ing 'module_name', and 'version'; they will be
+ * set to NULL upon entering this function.  Returns 0 on success, -1
+ * if out of memory, or -2 if data did not represent a module.
+ */
+static int parse_module_headers(semanage_handle_t * sh, char *module_data,
+                               size_t data_len, char **module_name,
+                               char **version)
+{
+       struct sepol_policy_file *pf;
+       int file_type;
+       *module_name = *version = NULL;
+
+       if (sepol_policy_file_create(&pf)) {
+               ERR(sh, "Out of memory!");
+               return -1;
+       }
+       sepol_policy_file_set_mem(pf, module_data, data_len);
+       sepol_policy_file_set_handle(pf, sh->sepolh);
+       if (module_data == NULL ||
+           data_len == 0 ||
+           sepol_module_package_info(pf, &file_type, module_name,
+                                     version) == -1) {
+               sepol_policy_file_free(pf);
+               ERR(sh, "Could not parse module data.");
+               return -2;
+       }
+       sepol_policy_file_free(pf);
+       if (file_type != SEPOL_POLICY_MOD) {
+               if (file_type == SEPOL_POLICY_BASE)
+                       ERR(sh,
+                           "Received a base module, expected a non-base module.");
+               else
+                       ERR(sh, "Data did not represent a module.");
+               return -2;
+       }
+
+       return 0;
+}
+
 #include <stdlib.h>
 #include <bzlib.h>
 #include <string.h>
@@ -1524,7 +1566,9 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 	char *path = NULL;
 	char *filename;
 	char *lang_ext = NULL;
+	char *module_name = NULL;
 	char *separator;
+	char *version = NULL;
 
 	if ((data_len = map_file(sh, install_filename, &data, &compressed)) <= 0) {
 		ERR(sh, "Unable to read file %s\n", install_filename);
@@ -1564,10 +1608,26 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
 		lang_ext = separator + 1;
 	}
 
-	retval = semanage_direct_install(sh, data, data_len, filename, lang_ext);
+	if (strcmp(lang_ext, "pp") != 0)
+		module_name = strdup(filename);
+	else {
+		if (parse_module_headers(sh, data, data_len, &module_name, &version) != 0) {
+			free(module_name);
+			module_name = strdup(filename);
+		}
+		free(version);
+	}
+	if (module_name == NULL) {
+		ERR(sh, "No memory available for module_name.\n");
+		retval = -1;
+		goto cleanup;
+	}
+
+	retval = semanage_direct_install(sh, data, data_len, module_name, lang_ext);
 
 cleanup:
 	if (data_len > 0) munmap(data, data_len);
+	free(module_name);
 	free(path);
 
 	return retval;
-- 
1.8.3.1
