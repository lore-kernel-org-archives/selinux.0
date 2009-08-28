Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7SHwaQV005155
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 13:58:36 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7SHvxgp029401
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 17:57:59 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n7SHwYBs024417
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 13:58:34 -0400
Received: from localhost.localdomain (dhcp-100-2-12.bos.redhat.com [10.16.2.12])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n7SHwXYq014250
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 13:58:33 -0400
Message-ID: <4A981AC6.4040006@redhat.com>
Date: Fri, 28 Aug 2009 13:58:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: semodule/libsemanage patch to allow enable and disable of modules.
Content-Type: multipart/mixed;
 boundary="------------020400040707050805040004"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020400040707050805040004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

The general idea is to relabel a disabled policy module as policymodule.pp.disabled

Then make sure -u and -i update this name.

Rebuilding policy does not include .disabled

Listing shows disabled as disabled.

semodule -r will remove disabled modules. If you reinstall they will come back.

# /usr/sbin/semodule -d unconfined
# /usr/sbin/semodule -l | grep unc
unconfined	3.0.1	Disabled
unconfineduser	1.0.0	
# ls -lZ /etc/selinux/targeted/modules/active/modules/unconfined.pp*
-rw-------. root root staff_u:object_r:semanage_store_t:s0 /etc/selinux/targeted/modules/active/modules/unconfined.pp.disabled
# /usr/sbin/semodule -i /usr/share/selinux/targeted/unconfined.pp.bz2 
# /usr/sbin/semodule -l | grep unc
unconfined	3.0.1	Disabled
unconfineduser	1.0.0	
# /usr/sbin/semodule -e unconfined
# /usr/sbin/semodule -l | grep unc
unconfined	3.0.1	
unconfineduser	1.0.0	

This would allow an admin to disable a module and the module will stay disabled until he enables it.

--------------020400040707050805040004
Content-Type: text/plain;
 name="policycoreutils-enable.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="policycoreutils-enable.patch"

diff --git a/libsemanage/include/semanage/modules.h b/libsemanage/include/semanage/modules.h
index e169279..d1043f9 100644
--- a/libsemanage/include/semanage/modules.h
+++ b/libsemanage/include/semanage/modules.h
@@ -40,6 +40,8 @@ int semanage_module_install_base(semanage_handle_t *,
 				 char *module_data, size_t data_len);
 int semanage_module_install_base_file(semanage_handle_t *,
 				      const char *module_name);
+int semanage_module_enable(semanage_handle_t *, char *module_name);
+int semanage_module_disable(semanage_handle_t *, char *module_name);
 int semanage_module_remove(semanage_handle_t *, char *module_name);
 
 /* semanage_module_info is for getting information on installed
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index f7d65eb..49a2357 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -53,6 +53,8 @@
 #include "policy.h"
 #include <sys/mman.h>
 
+static const char *DISABLESTR=".disabled";
+
 static void semanage_direct_destroy(semanage_handle_t * sh);
 static int semanage_direct_disconnect(semanage_handle_t * sh);
 static int semanage_direct_begintrans(semanage_handle_t * sh);
@@ -66,6 +68,8 @@ static int semanage_direct_upgrade_file(semanage_handle_t * sh, const char *modu
 static int semanage_direct_install_base(semanage_handle_t * sh, char *base_data,
 					size_t data_len);
 static int semanage_direct_install_base_file(semanage_handle_t * sh, const char *module_name);
+static int semanage_direct_enable(semanage_handle_t * sh, char *module_name);
+static int semanage_direct_disable(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
 				semanage_module_info_t ** modinfo,
@@ -83,6 +87,8 @@ static struct semanage_policy_table direct_funcs = {
 	.upgrade_file = semanage_direct_upgrade_file,
 	.install_base = semanage_direct_install_base,
 	.install_base_file = semanage_direct_install_base_file,
+	.enable = semanage_direct_enable,
+	.disable = semanage_direct_disable,
 	.remove = semanage_direct_remove,
 	.list = semanage_direct_list
 };
@@ -1002,6 +1008,17 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	return retval;
 }
 
+static char * get_store_name(const char *file) 
+{
+	int len = strlen(file) + strlen(DISABLESTR) + 1;
+	char *storename = calloc(1, len);
+	if (! storename) return NULL;
+	snprintf(storename,len, "%s%s", file, DISABLESTR);
+	if ( access(storename, F_OK) == 0) return storename;
+	free(storename);
+	return strdup(file);
+}
+
 /* Writes a module to the sandbox's module directory, overwriting any
  * previous module stored within.  Note that module data are not
  * free()d by this function; caller is responsible for deallocating it
@@ -1019,11 +1036,20 @@ static int semanage_direct_install(semanage_handle_t * sh,
 					   &filename)) != 0) {
 		goto cleanup;
 	}
-	if (bzip(sh, filename, data, data_len) <= 0) {
+
+	char *storename = get_store_name(filename);
+	if (!storename) {
+		ERR(sh, "Could not allocate memory");
+		retval = -1;
+		goto cleanup;
+	}
+	if (bzip(sh, storename, data, data_len) <= 0) {
 		ERR(sh, "Error while writing to %s.", filename);
 		retval = -3;
 		goto cleanup;
 	}
+	free(storename);
+
 	retval = 0;
       cleanup:
 	free(version);
@@ -1268,6 +1294,107 @@ static int semanage_direct_install_base_file(semanage_handle_t * sh,
 	return retval;
 }
 
+/* Enables a module from the sandbox.  Returns 0 on success, -1 if out
+ * of memory, -2 if module not found or could not be enabled. */
+static int semanage_direct_enable(semanage_handle_t * sh, char *module_name)
+{
+	int i, retval = -1;
+	char **module_filenames = NULL;
+	int num_mod_files;
+	size_t name_len = strlen(module_name);
+	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
+	    -1) {
+		return -1;
+	}
+	for (i = 0; i < num_mod_files; i++) {
+		char *base = strrchr(module_filenames[i], '/');
+		if (base == NULL) {
+			ERR(sh, "Could not read module names.");
+			retval = -2;
+			goto cleanup;
+		}
+		base++;
+		if (memcmp(module_name, base, name_len) == 0 &&
+		    strcmp(base + name_len + 3, DISABLESTR) == 0) {
+			int len = strlen(module_filenames[i]) - strlen(DISABLESTR);
+			char *enabled_name = calloc(1, len+1);
+			if (!enabled_name) {
+				ERR(sh, "Could not allocate memory");
+				retval = -1;
+				goto cleanup;
+			}
+
+			strncpy(enabled_name, module_filenames[i],len);
+
+			if (rename(module_filenames[i], enabled_name) == -1) {
+				ERR(sh, "Could not enable module file %s.",
+				    enabled_name);
+				retval = -2;
+			}
+			retval = 0;
+			free(enabled_name);
+			goto cleanup;
+		}
+	}
+	ERR(sh, "Module %s was not found.", module_name);
+	retval = -2;		/* module not found */
+      cleanup:
+	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
+		free(module_filenames[i]);
+	}
+	free(module_filenames);
+	return retval;
+}
+
+/* Enables a module from the sandbox.  Returns 0 on success, -1 if out
+ * of memory, -2 if module not found or could not be enabled. */
+static int semanage_direct_disable(semanage_handle_t * sh, char *module_name)
+{
+	int i, retval = -1;
+	char **module_filenames = NULL;
+	int num_mod_files;
+	size_t name_len = strlen(module_name);
+	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) ==
+	    -1) {
+		return -1;
+	}
+	for (i = 0; i < num_mod_files; i++) {
+		char *base = strrchr(module_filenames[i], '/');
+		if (base == NULL) {
+			ERR(sh, "Could not read module names.");
+			retval = -2;
+			goto cleanup;
+		}
+		base++;
+		if (memcmp(module_name, base, name_len) == 0 &&
+		    strcmp(base + name_len, ".pp") == 0) {
+			char disabled_name[PATH_MAX];
+			if (snprintf(disabled_name, PATH_MAX, "%s%s", 
+				     module_filenames[i], DISABLESTR) == PATH_MAX) {
+				ERR(sh, "Could not disable module file %s.",
+				    module_filenames[i]);
+				retval = -2;
+				goto cleanup;
+			}
+			if (rename(module_filenames[i], disabled_name) == -1) {
+				ERR(sh, "Could not disable module file %s.",
+				    module_filenames[i]);
+				retval = -2;
+			}
+			retval = 0;
+			goto cleanup;
+		}
+	}
+	ERR(sh, "Module %s was not found.", module_name);
+	retval = -2;		/* module not found */
+      cleanup:
+	for (i = 0; module_filenames != NULL && i < num_mod_files; i++) {
+		free(module_filenames[i]);
+	}
+	free(module_filenames);
+	return retval;
+}
+
 /* Removes a module from the sandbox.  Returns 0 on success, -1 if out
  * of memory, -2 if module not found or could not be removed. */
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
diff --git a/libsemanage/src/libsemanage.map b/libsemanage/src/libsemanage.map
index 4c2996e..8230719 100644
--- a/libsemanage/src/libsemanage.map
+++ b/libsemanage/src/libsemanage.map
@@ -6,6 +6,8 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_install; semanage_module_install_file;
 	  semanage_module_upgrade; semanage_module_upgrade_file;
 	  semanage_module_install_base; semanage_module_install_base_file;
+	  semanage_module_enable;
+	  semanage_module_disable;
 	  semanage_module_remove;
 	  semanage_module_list; semanage_module_info_datum_destroy;
 	  semanage_module_list_nth; semanage_module_get_name;
diff --git a/libsemanage/src/modules.c b/libsemanage/src/modules.c
index d99ee5b..8ea8c90 100644
--- a/libsemanage/src/modules.c
+++ b/libsemanage/src/modules.c
@@ -154,6 +154,40 @@ int semanage_module_install_base_file(semanage_handle_t * sh,
 	return sh->funcs->install_base_file(sh, module_name);
 }
 
+int semanage_module_enable(semanage_handle_t * sh, char *module_name)
+{
+	if (sh->funcs->enable == NULL) {
+		ERR(sh, "No enable function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	} else if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			return -1;
+		}
+	}
+	sh->modules_modified = 1;
+	return sh->funcs->enable(sh, module_name);
+}
+
+int semanage_module_disable(semanage_handle_t * sh, char *module_name)
+{
+	if (sh->funcs->disable == NULL) {
+		ERR(sh, "No disable function defined for this connection type.");
+		return -1;
+	} else if (!sh->is_connected) {
+		ERR(sh, "Not connected.");
+		return -1;
+	} else if (!sh->is_in_transaction) {
+		if (semanage_begin_transaction(sh) < 0) {
+			return -1;
+		}
+	}
+	sh->modules_modified = 1;
+	return sh->funcs->disable(sh, module_name);
+}
+
 int semanage_module_remove(semanage_handle_t * sh, char *module_name)
 {
 	if (sh->funcs->remove == NULL) {
diff --git a/libsemanage/src/policy.h b/libsemanage/src/policy.h
index ebefc02..627b526 100644
--- a/libsemanage/src/policy.h
+++ b/libsemanage/src/policy.h
@@ -58,6 +58,12 @@ struct semanage_policy_table {
 	/* Upgrade a policy module */
 	int (*upgrade_file) (struct semanage_handle *, const char *);
 
+	/* Enable a policy module */
+	int (*enable) (struct semanage_handle *, char *);
+
+	/* Disable a policy module */
+	int (*disable) (struct semanage_handle *, char *);
+
 	/* Remove a policy module */
 	int (*remove) (struct semanage_handle *, char *);
 
diff --git a/policycoreutils/semodule/semodule.c b/policycoreutils/semodule/semodule.c
index ad6adca..94b3738 100644
--- a/policycoreutils/semodule/semodule.c
+++ b/policycoreutils/semodule/semodule.c
@@ -22,12 +22,12 @@
 
 #include <semanage/modules.h>
 
-enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
+enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, ENABLE_M, DISABLE_M, REMOVE_M,
 	LIST_M, RELOAD
 };
 /* list of modes in which one ought to commit afterwards */
 static const int do_commit[] = {
-	0, 1, 1, 1, 1,
+	0, 1, 1, 1, 1, 1, 1,
 	0, 0
 };
 
@@ -104,6 +104,8 @@ static void usage(char *progname)
 	printf("  -R, --reload		    reload policy\n");
 	printf("  -B, --build		    build and reload policy\n");
 	printf("  -i,--install=MODULE_PKG   install a new module\n");
+	printf("  -e,--enable=MODULE_PKG    enable existing module\n");
+	printf("  -d,--disable=MODULE_PKG   disable existing module\n");
 	printf("  -u,--upgrade=MODULE_PKG   upgrades or install module to a newer version\n");
 	printf("  -b,--base=MODULE_PKG      install new base module\n");
 	printf("  -r,--remove=MODULE_NAME   remove existing module\n");
@@ -152,6 +154,8 @@ static void parse_command_line(int argc, char **argv)
 		{"install", required_argument, NULL, 'i'},
 		{"list-modules", 0, NULL, 'l'},
 		{"verbose", 0, NULL, 'v'},
+		{"enable", required_argument, NULL, 'e'},
+		{"disable", required_argument, NULL, 'd'},
 		{"remove", required_argument, NULL, 'r'},
 		{"upgrade", required_argument, NULL, 'u'},
 		{"reload", 0, NULL, 'R'},
@@ -166,7 +170,7 @@ static void parse_command_line(int argc, char **argv)
 	no_reload = 0;
 	create_store = 0;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:lvqr:u:RnBD", opts,
+		getopt_long(argc, argv, "s:b:hi:lvqe:d:r:u:RnBD", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -185,6 +189,12 @@ static void parse_command_line(int argc, char **argv)
 		case 'v':
 			verbose = 1;
 			break;
+		case 'e':
+			set_mode(ENABLE_M, optarg);
+			break;
+		case 'd':
+			set_mode(DISABLE_M, optarg);
+			break;
 		case 'r':
 			set_mode(REMOVE_M, optarg);
 			break;
@@ -238,6 +248,10 @@ static void parse_command_line(int argc, char **argv)
 			mode = UPGRADE_M;
 		} else if (commands && commands[num_commands - 1].mode == REMOVE_M) {
 			mode = REMOVE_M;
+		} else if (commands && commands[num_commands - 1].mode == ENABLE_M) {
+			mode = ENABLE_M;
+		} else if (commands && commands[num_commands - 1].mode == DISABLE_M) {
+			mode = DISABLE_M;
 		} else {
 			fprintf(stderr, "unknown additional arguments:\n");
 			while (optind < argc)
@@ -352,6 +366,30 @@ int main(int argc, char *argv[])
 				    semanage_module_install_base_file(sh, mode_arg);
 				break;
 			}
+		case ENABLE_M:{
+				if (verbose) {
+					printf
+					    ("Attempting to enable module '%s':\n",
+					     mode_arg);
+				}
+				result = semanage_module_enable(sh, mode_arg);
+				if ( result == -2 ) { 
+					continue;
+				}
+				break;
+			}
+		case DISABLE_M:{
+				if (verbose) {
+					printf
+					    ("Attempting to disable module '%s':\n",
+					     mode_arg);
+				}
+				result = semanage_module_disable(sh, mode_arg);
+				if ( result == -2 ) { 
+					continue;
+				}
+				break;
+			}
 		case REMOVE_M:{
 				if (verbose) {
 					printf

--------------020400040707050805040004--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
