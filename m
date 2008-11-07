Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA7EIgpI006520
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:18:42 -0500
Received: from mx2.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA7EH1Qi006009
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 14:17:01 GMT
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EIfh7031748
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:18:41 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mA7EIeUs025934
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:18:40 -0500
Received: from holycross.boston.devel.redhat.com (holycross.boston.devel.redhat.com [10.16.60.79])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mA7EId37011759
	for <selinux@tycho.nsa.gov>; Fri, 7 Nov 2008 09:18:39 -0500
Message-ID: <49144E3F.8080904@redhat.com>
Date: Fri, 07 Nov 2008 09:18:39 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Now that F11 has started, I am putting in the compression support.
Content-Type: multipart/mixed;
 boundary="------------010609010909050300060401"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010609010909050300060401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

libsemanage patch to add compression.

Uses bzip compression, all pp files in active/previous stored in
compressed state.  Added new interfaces to be user by policycoreutils to
specify file rather then memory map.

Also uses link instead of copy whenever possible to save disk space.
Seeing about a 10 fold savings on policy footprint.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkkUTj8ACgkQrlYvE4MpobN4zgCfSHfBKwWq1Bms+7CB17mcggGB
w80AnAn+PQs7UwLsZkSliJTKdeSHYcvR
=I8zL
-----END PGP SIGNATURE-----

--------------010609010909050300060401
Content-Type: text/plain;
 name="libsemanage-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibsemanage/include/semanage/modules.h libsemanage-2.0.28/include/semanage/modules.h
--- nsalibsemanage/include/semanage/modules.h	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/include/semanage/modules.h	2008-10-13 12:35:22.000000000 -0400
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
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/Makefile libsemanage-2.0.28/src/Makefile
--- nsalibsemanage/src/Makefile	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/src/Makefile	2008-10-13 12:35:22.000000000 -0400
@@ -54,7 +54,7 @@
 	ranlib $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
+	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ $^ -lsepol -lselinux -lbz2 -lustr -L$(LIBDIR) -Wl,-soname,$(LIBSO),--version-script=libsemanage.map,-z,defs
 	ln -sf $@ $(TARGET)
 
 conf-scan.c: conf-scan.l conf-parse.h
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.c libsemanage-2.0.28/src/direct_api.c
--- nsalibsemanage/src/direct_api.c	2008-09-15 12:20:44.000000000 -0400
+++ libsemanage-2.0.28/src/direct_api.c	2008-10-13 16:36:51.000000000 -0400
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
@@ -378,12 +385,157 @@
 	return 0;
 }
 
+#include <stdlib.h>
+#include <bzlib.h>
+#include <string.h>
+#include <sys/sendfile.h>
+
+/* bzip() a file to '*data', returning the total number of uncompressed bytes
+ * in the file.  Returns 0 if file could not be decompressed. */
+static size_t bzip(const char *filename, char *data, size_t num_bytes) {
+	BZFILE* b;
+	size_t  size = 1<<16;
+	int     bzerror;
+	size_t  total = 0;
+	size_t len = 0;
+	FILE *f;
+
+	if ((f = fopen(filename, "wb")) == NULL) {
+		return 0;
+	}
+
+	b = BZ2_bzWriteOpen( &bzerror, f, 9, 0, 0);
+	if (bzerror != BZ_OK) {
+		BZ2_bzWriteClose ( &bzerror, b, 1, 0, 0 );
+		return 0;
+	}
+	
+	while ( num_bytes > total ) {
+		if (num_bytes - total > size) {
+			len = size;
+		} else {
+			len = num_bytes - total;
+		}
+		BZ2_bzWrite ( &bzerror, b, &data[total], len );
+		if (bzerror == BZ_IO_ERROR) { 
+			BZ2_bzWriteClose ( &bzerror, b, 1, 0, 0 );
+			return 0;
+		}
+		total += len;
+	}
+
+	BZ2_bzWriteClose ( &bzerror, b, 0, 0, 0 );
+	fclose(f);
+	if (bzerror == BZ_IO_ERROR) {
+		return 0;
+	}
+	return total;
+}
+
+/* bunzip() a file to '*data', returning the total number of uncompressed bytes
+ * in the file.  Returns 0 if file could not be decompressed. */
+size_t bunzip(FILE *f, char **data) {
+	BZFILE* b;
+	size_t  nBuf;
+	char    buf[1<<18];
+	size_t  size = sizeof(buf);
+	int     bzerror;
+	size_t  total=0;
+	
+	b = BZ2_bzReadOpen ( &bzerror, f, 0, 0, NULL, 0 );
+	if ( bzerror != BZ_OK ) {
+		BZ2_bzReadClose ( &bzerror, b );
+		return 0;
+	}
+	
+	char *uncompress = realloc(NULL, size);
+	
+	while ( bzerror == BZ_OK) {
+		nBuf = BZ2_bzRead ( &bzerror, b, buf, sizeof(buf));
+		if (( bzerror == BZ_OK ) || ( bzerror == BZ_STREAM_END )) {
+			if (total + nBuf > size) {
+				size *= 2;
+				uncompress = realloc(uncompress, size);
+			}
+			memcpy(&uncompress[total], buf, nBuf);
+			total += nBuf;
+		}
+	}
+	if ( bzerror != BZ_STREAM_END ) {
+		BZ2_bzReadClose ( &bzerror, b );
+		free(uncompress);
+		return 0;
+	}
+	BZ2_bzReadClose ( &bzerror, b );
+
+	*data = uncompress;
+	return  total;
+}
+
+/* mmap() a file to '*data',
+ *  If the file is bzip compressed map_file will uncompress 
+ * the file into '*data'.
+ * Returns the total number of bytes in memory .
+ * Returns 0 if file could not be opened or mapped. */
+static size_t map_file(int fd, char **data, int *compressed)
+{
+	int size;
+	char *uncompress;
+	if ((size = bunzip(fdopen(fd, "r"), &uncompress)) > 0) {
+		*data = mmap(0, size, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
+		if (*data == MAP_FAILED) {
+			free(uncompress);
+			return 0;
+		} else {
+			memcpy(*data, uncompress, size);
+		}
+		free(uncompress);
+		*compressed = 1;
+	} else {
+		struct stat sb;
+		if (fstat(fd, &sb) == -1 ||
+		    (*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0)) ==
+		    MAP_FAILED) {
+			size = 0;
+		} else {
+			size = sb.st_size;
+		}
+		*compressed = 0;
+	} 
+
+	return size;
+}
+
+static int dupfile( const char *dest, int src_fd) {
+	int dest_fd = -1;
+	int retval = 0;
+	int cnt;
+	char    buf[1<<18];
+
+	if (lseek(src_fd, 0, SEEK_SET)  == -1 ) return -1;
+
+	if ((dest_fd = open(dest, O_WRONLY | O_CREAT | O_TRUNC,
+			   S_IRUSR | S_IWUSR)) == -1) {
+		return -1;
+	}
+
+	while (( retval == 0 ) && 
+	       ( cnt = read(src_fd, buf, sizeof(buf)))> 0 ) {
+		if (write(dest_fd, buf, cnt) < cnt) retval = -1;
+	}
+	close(dest_fd);
+	return retval;
+}
+
 /* Writes a block of data to a file.  Returns 0 on success, -1 on
  * error. */
 static int write_file(semanage_handle_t * sh,
 		      const char *filename, char *data, size_t num_bytes)
 {
 	int out;
+
+	/* Unlink no matter what, incase this file is a hard link, ignore error */
+	unlink(filename);
 	if ((out =
 	     open(filename, O_WRONLY | O_CREAT | O_TRUNC,
 		  S_IRUSR | S_IWUSR)) == -1) {
@@ -499,7 +651,7 @@
 	sepol_policydb_t *out = NULL;
 
 	/* Declare some variables */
-	int modified, fcontexts_modified, ports_modified,
+	int modified = 0, fcontexts_modified, ports_modified,
 	    seusers_modified, users_extra_modified;
 	dbase_config_t *users = semanage_user_dbase_local(sh);
 	dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
@@ -815,7 +967,9 @@
 					   &filename)) != 0) {
 		goto cleanup;
 	}
-	if (write_file(sh, filename, data, data_len) == -1) {
+
+	if (bzip(filename, data, data_len) == 0) {
+		ERR(sh, "Error while writing to %s.", filename);
 		retval = -3;
 	}
 	retval = 0;
@@ -826,19 +980,60 @@
 	return retval;
 }
 
-/* Similar to semanage_direct_install(), except that it checks that
- * there already exists a module with the same name and that the
- * module is an older version then the one in 'data'.  Returns 0 on
- * success, -1 if out of memory, -2 if the data does not represent a
- * valid module file, -3 if error while writing file or reading
- * modules directory, -4 if there does not exist an older module or if
- * the previous module is same or newer than 'data'.
- */
-static int semanage_direct_upgrade(semanage_handle_t * sh,
-				   char *data, size_t data_len)
+/* Attempts to link a module to the sandbox's module directory, unlinking any
+ * previous module stored within.  Returns 0 on success, -1 if out of memory, -2 if the
+ * data does not represent a valid module file, -3 if error while
+ * writing file. */
+
+static int semanage_direct_install_file(semanage_handle_t * sh,
+					const char *install_filename)
 {
+
+	int retval = -1;
+	char *data = NULL;
+	size_t data_len = 0;
+	int compressed = 0;
+	int in_fd = -1;
+
+	if ((in_fd = open(install_filename, O_RDONLY)) == -1) {
+		return 0;
+	}
+
+	if ((data_len = map_file(in_fd, &data, &compressed)) == 0) {
+		goto cleanup;
+	}
+		
+	if (compressed) {
+		char *module_name = NULL, *version = NULL, *filename = NULL;
+		if ((retval = parse_module_headers(sh, data, data_len,
+						   &module_name, &version,
+						   &filename)) != 0) {
+			goto cleanup;
+		}
+
+		if (data_len > 0) munmap(data, data_len);
+		data_len = 0;
+		retval = dupfile(filename, in_fd);
+		free(version);
+		free(filename);
+		free(module_name);
+
+	} else {
+		retval = semanage_direct_install(sh, data, data_len);
+	}
+
+      cleanup:
+	close(in_fd);
+	if (data_len > 0) munmap(data, data_len);
+
+	return retval;
+}
+
+
+static int get_direct_upgrade_filename(semanage_handle_t * sh,
+				       char *data, size_t data_len, char **outfilename) {
 	int i, retval, num_modules = 0;
-	char *module_name = NULL, *version = NULL, *filename = NULL;
+	char *filename = NULL, *module_name = NULL, *version = NULL;
 	semanage_module_info_t *modinfo = NULL;
 	if ((retval = parse_module_headers(sh, data, data_len,
 					   &module_name, &version,
@@ -868,14 +1063,10 @@
 	if (retval == -4) {
 		ERR(sh, "There does not already exist a module named %s.",
 		    module_name);
-		goto cleanup;
-	}
-	if (write_file(sh, filename, data, data_len) == -1) {
-		retval = -3;
 	}
+
       cleanup:
 	free(version);
-	free(filename);
 	free(module_name);
 	for (i = 0; modinfo != NULL && i < num_modules; i++) {
 		semanage_module_info_t *m =
@@ -883,6 +1074,80 @@
 		semanage_module_info_datum_destroy(m);
 	}
 	free(modinfo);
+	if (retval == 0) {
+		*outfilename = filename;
+	} else {
+		free(filename);
+	}
+	return retval;
+}
+
+/* Similar to semanage_direct_install(), except that it checks that
+ * there already exists a module with the same name and that the
+ * module is an older version then the one in 'data'.  Returns 0 on
+ * success, -1 if out of memory, -2 if the data does not represent a
+ * valid module file, -3 if error while writing file or reading
+ * modules directory, -4 if there does not exist an older module or if
+ * the previous module is same or newer than 'data'.
+ */
+static int semanage_direct_upgrade(semanage_handle_t * sh,
+				   char *data, size_t data_len)
+{
+	char *filename = NULL;
+	int retval = get_direct_upgrade_filename(sh,
+						 data, data_len, 
+						 &filename);
+	if (retval == 0) {
+		if (bzip(filename, data, data_len) == 0) {
+			ERR(sh, "Error while writing to %s.", filename);
+			retval = -3;
+		}
+		free(filename);
+	}
+	return retval;
+}
+
+/* Attempts to link a module to the sandbox's module directory, unlinking any
+ * previous module stored within.  
+ * Returns 0 on success, -1 if out of memory, -2 if the
+ * data does not represent a valid module file, -3 if error while
+ * writing file. */
+
+static int semanage_direct_upgrade_file(semanage_handle_t * sh,
+					const char *module_filename)
+{
+	int retval = -1;
+	char *data = NULL;
+	size_t data_len = 0;
+	int compressed = 0;
+	int in_fd = -1;
+
+	if ((in_fd = open(module_filename, O_RDONLY)) == -1) {
+		return 0;
+	}
+
+	if ((data_len = map_file(in_fd, &data, &compressed)) == 0) {
+		goto cleanup;
+	}
+
+	if (compressed) {
+		char *filename = NULL;
+		retval = get_direct_upgrade_filename(sh,
+					 	     data, data_len, 
+						     &filename);
+		
+		if (retval != 0)  goto cleanup;
+
+		retval = dupfile(filename, in_fd);
+		free(filename);
+	} else {
+		retval = semanage_direct_upgrade(sh, data, data_len);
+	}
+
+      cleanup:
+	close(in_fd);
+	if (data_len > 0) munmap(data, data_len);
+
 	return retval;
 }
 
@@ -903,7 +1168,8 @@
 	if ((filename = semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
 		goto cleanup;
 	}
-	if (write_file(sh, filename, base_data, data_len) == -1) {
+	if (bzip(filename, base_data, data_len) == 0) {
+		ERR(sh, "Error while writing to %s.", filename);
 		retval = -3;
 	}
 	retval = 0;
@@ -911,6 +1177,49 @@
 	return retval;
 }
 
+/* Writes a base module into a sandbox, overwriting any previous base
+ * module.  
+ * Returns 0 on success, -1 if out of memory, -2 if the data does not represent
+ * a valid base module file, -3 if error while writing file.
+ */
+static int semanage_direct_install_base_file(semanage_handle_t * sh,
+					     const char *install_filename)
+{
+	int retval = -1;
+	char *data = NULL;
+	size_t data_len = 0;
+	int compressed = 0;
+	int in_fd;
+
+	if ((in_fd = open(install_filename, O_RDONLY)) == -1) {
+		return 0;
+	}
+
+	if ((data_len = map_file(in_fd, &data, &compressed)) == 0) {
+		goto cleanup;
+	}
+		
+	if (compressed) {
+		const char *filename = NULL;
+		if ((retval = parse_base_headers(sh, data, data_len)) != 0) {
+			goto cleanup;
+		}
+		if ((filename = semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) == NULL) {
+			goto cleanup;
+		}
+
+		retval = dupfile(filename, in_fd);
+	} else {
+		retval = semanage_direct_install_base(sh, data, data_len);
+	}
+
+      cleanup:
+	close(in_fd);
+	if (data_len > 0) munmap(data, data_len);
+
+	return retval;
+}
+
 /* Removes a module from the sandbox.  Returns 0 on success, -1 if out
  * of memory, -2 if module not found or could not be removed. */
 static int semanage_direct_remove(semanage_handle_t * sh, char *module_name)
@@ -1005,15 +1314,26 @@
 			 * report it */
 			continue;
 		}
+		size_t size;
+		char *data = NULL;
+
+		if ((size = bunzip(fp, &data)) != 0) {
+			fclose(fp);
+			fp = fmemopen(data, size, "rb");
+		}
+		rewind(fp);
+
 		__fsetlocking(fp, FSETLOCKING_BYCALLER);
 		sepol_policy_file_set_fp(pf, fp);
 		if (sepol_module_package_info(pf, &type, &name, &version)) {
 			fclose(fp);
+			free(data);
 			free(name);
 			free(version);
 			continue;
 		}
 		fclose(fp);
+		free(data);
 		if (type == SEPOL_POLICY_MOD) {
 			(*modinfo)[*num_modules].name = name;
 			(*modinfo)[*num_modules].version = version;
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/direct_api.h libsemanage-2.0.28/src/direct_api.h
--- nsalibsemanage/src/direct_api.h	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/src/direct_api.h	2008-10-13 12:35:22.000000000 -0400
@@ -37,4 +37,7 @@
 
 int semanage_direct_access_check(struct semanage_handle *sh);
 
+#include <stdio.h>
+size_t bunzip(FILE *f, char **data);
+
 #endif
diff --exclude-from=exclude -N -u -r nsalibsemanage/src/libsemanage.map libsemanage-2.0.28/src/libsemanage.map
--- nsalibsemanage/src/libsemanage.map	2008-08-28 09:34:24.000000000 -0400
+++ libsemanage-2.0.28/src/libsemanage.map	2008-10-13 12:35:22.000000000 -0400
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
+++ libsemanage-2.0.28/src/modules.c	2008-10-13 12:35:22.000000000 -0400
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
+++ libsemanage-2.0.28/src/policy.h	2008-10-13 12:35:22.000000000 -0400
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
+++ libsemanage-2.0.28/src/semanage_store.c	2008-10-13 12:57:29.000000000 -0400
@@ -440,6 +440,8 @@
 	char tmp[PATH_MAX];
 	char buf[4192];
 
+	if (link(src,dst) == 0) return 0;
+
 	n = snprintf(tmp, PATH_MAX, "%s.tmp", dst);
 	if (n < 0 || n >= PATH_MAX)
 		return -1;
@@ -1522,16 +1524,26 @@
 		ERR(sh, "Could not open module file %s for reading.", filename);
 		goto cleanup;
 	}
+	size_t size;
+	char *data = NULL;
+
+	if ((size = bunzip(fp, &data)) != 0) {
+		fclose(fp);
+		fp = fmemopen(data, size, "rb");
+	}
+	rewind(fp);
 	__fsetlocking(fp, FSETLOCKING_BYCALLER);
 	sepol_policy_file_set_fp(pf, fp);
 	sepol_policy_file_set_handle(pf, sh->sepolh);
 	if (sepol_module_package_read(*package, pf, 0) == -1) {
 		ERR(sh, "Error while reading from module file %s.", filename);
 		fclose(fp);
+		free(data);
 		goto cleanup;
 	}
 	sepol_policy_file_free(pf);
 	fclose(fp);
+	free(data);
 	return retval;
 
       cleanup:

--------------010609010909050300060401
Content-Type: application/octet-stream;
 name="libsemanage-rhat.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libsemanage-rhat.patch.sig"

iEYEABECAAYFAkkUTj8ACgkQrlYvE4MpobMLpwCgh7HEDctzPpaJjRYy1e8LmWdwME0AnjeS
tzREkA7N4cuUSAV+C4X/71Fb
--------------010609010909050300060401--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
