Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8QGiIli020450
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 12:44:18 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8QGhJIp009635
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 16:43:19 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id m8QGiInM004103
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 12:44:18 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [10.16.255.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id m8QGiH9H007465
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 12:44:17 -0400
Received: from localhost.localdomain (vpn-10-42.bos.redhat.com [10.16.10.42])
	by mail.boston.redhat.com (8.13.1/8.13.1) with ESMTP id m8QGiHZA021123
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 12:44:17 -0400
Message-ID: <48DD1160.1040907@redhat.com>
Date: Fri, 26 Sep 2008 12:44:16 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Patch to make libsemanage/selinux policy require less space.
Content-Type: multipart/mixed;
 boundary="------------020002010600030809000303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020002010600030809000303
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Currently selinux-policy*rpm install the pp files in
/usr/share/selinux/POLICYTYPE/*.pp

Then it calls semodule on them to load the policy.  libsemanage copies
the policy package files to /etc/selinux/targeted/modules/active,  Then
it recopies the files to /etc/selinux/targeted/modules/previous, where
it finishes the assembly of the files.

So we end up requiring three times as much space as necessary if the
modules are not changing.

Policy in Rawhide is 36 megabytes.

So on small devices or even usb sticks and cd's this is a large waste of
space.  This patch is an attempt to use hard links when we can.

I have not put it in production, since I wanted people who know the
library better then me to tell me whether it is a cracked idea.

There is really two ideas in the patch.  One is to add interfaces
semanage_modules_*_file which take a file instead of a block of memory.
 semodule would then be changed to use these interfaces.

The library then calls semanage_link,  This function checks to make sure
the file countext of the source matches the file context of the
destination, if they match, the tool will attempt a link, if either
fails the tool will fall back to copy them.

I changed the write_file to unlink the destination file which would
remove the linked file if it exists.


semanage_store has been changed, so that the creation of the sandbox is
via link, if possible.

Is this a good idea or bad?

Also want to reinvestigate using some form of compression.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkjdEWAACgkQrlYvE4MpobNvEQCgsedSuXz9Igagh3jJF5gja4/U
18sAn0wDWTMjtu5gLrIN/zD/Ox0dk49z
=gtQW
-----END PGP SIGNATURE-----

--------------020002010600030809000303
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibsemanage/include/semanage/modules.h libsemanage-2.0.28/include/semanage/modules.h
--- nsalibsemanage/include/semanage/modules.h	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/include/semanage/modules.h	2008-09-17 11:17:56.000000000 -0400
@@ -30,10 +30,16 @@
 
 int semanage_module_install(semanage_handle_t *,
 			    char *module_data, size_t data_len);
+int semanage_module_install_file(semanage_handle_t *,
+				 const char *module_name);
 int semanage_module_upgrade(semanage_handle_t *,
 			    char *module_data, size_t data_len);
+int semanage_module_upgrade_file(semanage_handle_t *,
+				 const char *module_name);
 int semanage_module_install_base(semanage_handle_t *,
 				 char *module_data, size_t data_len);
+int semanage_module_install_base_file(semanage_handle_t *,
+				      const char *module_name);
 int semanage_module_remove(semanage_handle_t *, char *module_name);
 
 /* semanage_module_info is for getting information on installed
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.28/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2008-09-15 12:20:44.000000000 -0400
+++ libsemanage-2.0.28/src/direct_api.c	2008-09-26 11:43:24.000000000 -0400
@@ -50,6 +50,7 @@
 #include "semanage_store.h"
 #include "database_policydb.h"
 #include "policy.h"
+#include <sys/mman.h>
 
 static void semanage_direct_destroy(semanage_handle_t * sh);
 static int semanage_direct_disconnect(semanage_handle_t * sh);
@@ -57,10 +58,13 @@
 static int semanage_direct_commit(semanage_handle_t * sh);
 static int semanage_direct_install(semanage_handle_t * sh, char *data,
 				   size_t data_len);
+static int semanage_direct_install_file(semanage_handle_t * sh, const char *module_name);
 static int semanage_direct_upgrade(semanage_handle_t * sh, char *data,
 				   size_t data_len);
+static int semanage_direct_upgrade_file(semanage_handle_t * sh, const char *module_name);
 static int semanage_direct_install_base(semanage_handle_t * sh, char *base_data,
 					size_t data_len);
+static int semanage_direct_install_base_file(semanage_handle_t * sh, const char *module_name);
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name);
 static int semanage_direct_list(semanage_handle_t * sh,
 				semanage_module_info_t ** modinfo,
@@ -73,8 +77,11 @@
 	.begin_trans = semanage_direct_begintrans,
 	.commit = semanage_direct_commit,
 	.install = semanage_direct_install,
+	.install_file = semanage_direct_install_file,
 	.upgrade = semanage_direct_upgrade,
+	.upgrade_file = semanage_direct_upgrade_file,
 	.install_base = semanage_direct_install_base,
+	.install_base_file = semanage_direct_install_base_file,
 	.remove = semanage_direct_remove,
 	.list = semanage_direct_list
 };
@@ -384,6 +391,9 @@
 		      const char *filename, char *data, size_t num_bytes)
 {
 	int out;
+
+	/* Unlink no matter what, incase this file is a hard link, ignore error */
+	unlink(filename);
 	if ((out =
 	     open(filename, O_WRONLY | O_CREAT | O_TRUNC,
 		  S_IRUSR | S_IWUSR)) == -1) {
@@ -826,6 +836,79 @@
 	return retval;
 }
 
+/* mmap() a file to '*data', returning the total number of bytes in
+ * the file.  Returns 0 if file could not be opened or mapped. */
+static size_t map_file(char *filename, char **data)
+{
+	int fd;
+	struct stat sb;
+	if ((fd = open(filename, O_RDONLY)) == -1) {
+		return 0;
+	}
+	if (fstat(fd, &sb) == -1 ||
+	    (*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0)) ==
+	    MAP_FAILED) {
+		sb.st_size = 0;
+	}
+	close(fd);
+	return sb.st_size;
+}
+
+/* only link if the files have the same file context */
+static int semanage_link(const char *src, const char *dst) {
+	int retval = -1;
+	security_context_t scontext = NULL;
+	security_context_t tcontext = NULL;
+	if (getfilecon(src, &scontext) > -1 &&
+	    matchpathcon(dst,S_IFREG, &tcontext) > -1 ) {
+		if (strcmp(scontext, tcontext) == 0) {
+			unlink(dst);
+			retval = link(src, dst);
+		}
+	}
+	freecon(scontext);
+	freecon(tcontext);
+	return retval;
+}
+
+/* Attempts to link a module to the sandbox's module directory, unlinking any
+ * previous module stored within.  Returns 0 on success, -1 if out of memory, -2 if the
+ * data does not represent a valid module file, -3 if error while
+ * writing file. */
+
+static int semanage_direct_install_file(semanage_handle_t * sh,
+					const char *install_filename)
+{
+
+	int retval;
+	char *module_name = NULL, *version = NULL, *filename = NULL;
+	char *data = NULL;
+	size_t data_len = 0;
+	
+	if ((data_len = map_file((char *) install_filename, &data)) == 0) {
+		goto cleanup;
+	}
+		
+	if ((retval = parse_module_headers(sh, data, data_len,
+					   &module_name, &version,
+					   &filename)) != 0) {
+		goto cleanup;
+	}
+
+	if (semanage_link(install_filename, filename) < 0) {
+		if (write_file(sh, filename, data, data_len) == -1) {
+			retval = -3;
+		}
+	}
+	retval = 0;
+      cleanup:
+	if (data_len > 0) munmap(data, data_len);
+	free(version);
+	free(filename);
+	free(module_name);
+	return retval;
+}
+
 /* Similar to semanage_direct_install(), except that it checks that
  * there already exists a module with the same name and that the
  * module is an older version then the one in 'data'.  Returns 0 on
@@ -886,6 +969,85 @@
 	return retval;
 }
 
+/* Attempts to link a module to the sandbox's module directory, unlinking any
+ * previous module stored within.  Returns 0 on success, -1 if out of memory, -2 if the
+ * data does not represent a valid module file, -3 if error while
+ * writing file. */
+
+static int semanage_direct_upgrade_file(semanage_handle_t * sh,
+					const char *module_filename)
+{
+	int i, retval, num_modules = 0;
+	char *module_name = NULL, *version = NULL, *filename = NULL;
+	semanage_module_info_t *modinfo = NULL;
+
+	char *data = NULL;
+	size_t data_len = 0;
+	
+	if ((data_len = map_file((char *) module_filename, &data)) == 0) {
+		goto cleanup;
+	}
+		
+	if ((retval = parse_module_headers(sh, data, data_len,
+					   &module_name, &version,
+					   &filename)) != 0) {
+		goto cleanup;
+	}
+	if (semanage_direct_list(sh, &modinfo, &num_modules) < 0) {
+		goto cleanup;
+	}
+	retval = -4;
+	for (i = 0; i < num_modules; i++) {
+		semanage_module_info_t *m =
+		    semanage_module_list_nth(modinfo, i);
+		if (strcmp(semanage_module_get_name(m), module_name) == 0) {
+			if (strverscmp(version, semanage_module_get_version(m))
+			    > 0) {
+				retval = 0;
+				break;
+			} else {
+				ERR(sh, "Previous module %s is same or newer.",
+				    module_name);
+				retval = -4;
+				goto cleanup;
+			}
+		}
+	}
+	if (retval == -4) {
+		ERR(sh, "There does not already exist a module named %s.",
+		    module_name);
+		goto cleanup;
+	}
+	if (write_file(sh, filename, data, data_len) == -1) {
+		retval = -3;
+	}
+	if ((retval = parse_module_headers(sh, data, data_len,
+					   &module_name, &version,
+					   &filename)) != 0) {
+		goto cleanup;
+	}
+
+	if (semanage_link(module_filename, filename) < 0) {
+		if (write_file(sh, filename, data, data_len) == -1) {
+			retval = -3;
+		}
+	}
+	retval = 0;
+
+      cleanup:
+	if (data_len > 0) munmap(data, data_len);
+	free(version);
+	free(filename);
+	free(module_name);
+	for (i = 0; modinfo != NULL && i < num_modules; i++) {
+		semanage_module_info_t *m =
+		    semanage_module_list_nth(modinfo, i);
+		semanage_module_info_datum_destroy(m);
+	}
+	free(modinfo);
+	return retval;
+}
+
 /* Writes a base module into a sandbox, overwriting any previous base
  * module.  Note that 'module_data' is not free()d by this function;
  * caller is responsible for deallocating it if necessary.  Returns 0
@@ -911,6 +1073,41 @@
 	return retval;
 }
 
+/* Writes a base module into a sandbox, overwriting any previous base
+ * module.  Note that 'module_data' is not free()d by this function;
+ * caller is responsible for deallocating it if necessary.  Returns 0
+ * on success, -1 if out of memory, -2 if the data does not represent
+ * a valid base module file, -3 if error while writing file.
+ */
+static int semanage_direct_install_base_file(semanage_handle_t * sh,
+					     const char *install_filename)
+{
+	int retval = -1;
+	const char *filename = NULL;
+	char *data = NULL;
+	size_t data_len = 0;
+	
+	if ((data_len = map_file((char *) install_filename, &data)) == 0) {
+		goto cleanup;
+	}
+		
+	if ((retval = parse_base_headers(sh, data, data_len)) != 0) {
+		goto cleanup;
+	}
+	if ((filename = semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
+		goto cleanup;
+	}
+
+	if (semanage_link(install_filename, filename) < 0) {
+		if (write_file(sh, filename, data, data_len) == -1) {
+			retval = -3;
+		}
+	}
+	retval = 0;
+      cleanup:
+	return retval;
+}
+
 /* Removes a module from the sandbox.  Returns 0 on success, -1 if out
  * of memory, -2 if module not found or could not be removed. */
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/libsemanage.map libsemanage-2.0.28/src/libsemanage.map
--- nsalibsemanage/src/libsemanage.map	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/src/libsemanage.map	2008-09-17 11:16:20.000000000 -0400
@@ -3,8 +3,10 @@
           semanage_is_managed; semanage_connect; semanage_disconnect; 
 	  semanage_msg_*;
           semanage_begin_transaction; semanage_commit;
-          semanage_module_install; semanage_module_upgrade;
-	  semanage_module_install_base; semanage_module_remove;
+	  semanage_module_install; semanage_module_install_file;
+	  semanage_module_upgrade; semanage_module_upgrade_file;
+	  semanage_module_install_base; semanage_module_install_base_file;
+	  semanage_module_remove;
 	  semanage_module_list; semanage_module_info_datum_destroy;
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/modules.c libsemanage-2.0.28/src/modules.c
--- nsalibsemanage/src/modules.c	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/src/modules.c	2008-09-17 11:29:42.000000000 -0400
@@ -52,6 +52,25 @@
 	return sh->funcs->install(sh, module_data, data_len);
 }
 
+int semanage_module_install_file(semanage_handle_t * sh,
+				 const char *module_name) {
+
+	if (sh->funcs->install_file == NULL) {
+		ERR(sh,
+		    "No install function defined for this connection type.");
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
+	return sh->funcs->install_file(sh, module_name);
+}
+
 int semanage_module_upgrade(semanage_handle_t * sh,
 			    char *module_data, size_t data_len)
 {
@@ -71,6 +90,25 @@
 	return sh->funcs->upgrade(sh, module_data, data_len);
 }
 
+int semanage_module_upgrade_file(semanage_handle_t * sh,
+				 const char *module_name) {
+
+	if (sh->funcs->upgrade_file == NULL) {
+		ERR(sh,
+		    "No upgrade function defined for this connection type.");
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
+	return sh->funcs->upgrade_file(sh, module_name);
+}
+
 int semanage_module_install_base(semanage_handle_t * sh,
 				 char *module_data, size_t data_len)
 {
@@ -90,6 +128,25 @@
 	return sh->funcs->install_base(sh, module_data, data_len);
 }
 
+int semanage_module_install_base_file(semanage_handle_t * sh,
+				 const char *module_name) {
+
+	if (sh->funcs->install_base_file == NULL) {
+		ERR(sh,
+		    "No install base function defined for this connection type.");
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
+	return sh->funcs->install_base_file(sh, module_name);
+}
+
 int semanage_module_remove(semanage_handle_t * sh, char *module_name)
 {
 	if (sh->funcs->remove == NULL) {
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/policy.h libsemanage-2.0.28/src/policy.h
--- nsalibsemanage/src/policy.h	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/src/policy.h	2008-09-17 11:26:06.000000000 -0400
@@ -49,8 +49,14 @@
 	/* Install a policy module */
 	int (*install) (struct semanage_handle *, char *, size_t);
 
+	/* Install a policy module */
+	int (*install_file) (struct semanage_handle *, const char *);
+
 	/* Upgrade a policy module */
 	int (*upgrade) (struct semanage_handle *, char *, size_t);
+	
+	/* Upgrade a policy module */
+	int (*upgrade_file) (struct semanage_handle *, const char *);
 
 	/* Remove a policy module */
 	int (*remove) (struct semanage_handle *, char *);
@@ -61,6 +67,9 @@
 
 	/* Install base policy */
 	int (*install_base) (struct semanage_handle *, char *, size_t);
+
+	/* Install a base module */
+	int (*install_base_file) (struct semanage_handle *, const char *);
 };
 
 /* Should be backend independent */
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/semanage_store.c libsemanage-2.0.28/src/semanage_store.c
--- nsalibsemanage/src/semanage_store.c	2008-09-15 12:20:44.000000000 -0400
+++ libsemanage-2.0.28/src/semanage_store.c	2008-09-17 12:23:47.000000000 -0400
@@ -440,6 +440,8 @@
 	char tmp[PATH_MAX];
 	char buf[4192];
 
+	if (link(src,dst) == 0) return 0;
+
 	n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
 	if (n < 0 || n >= PATH_MAX)
 		return -1;

--------------020002010600030809000303
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iEYEABECAAYFAkjdEWAACgkQrlYvE4MpobPw+wCgh2CX2umKldAbOZOA7dba+qqkluUAn3FK
REhKbn0dd///usotPVPvnBuU
--------------020002010600030809000303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
