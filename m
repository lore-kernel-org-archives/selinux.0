Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8REooNs023885
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 10:50:50 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8REgCpk016907
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 14:42:12 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4) with ESMTP id j8REcMN5011288
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 10:38:22 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.4/8.13.4/Submit) id j8REcMWI011287
	for selinux@tycho.nsa.gov; Tue, 27 Sep 2005 10:38:22 -0400
Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCu8Ns021776
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:56:09 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCohpk004357
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:50:43 GMT
Message-Id: <200509271250.j8RConYs026116@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 14/17
Date: Tue, 27 Sep 2005 08:50:49 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0037_01C5C340.8F255940"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0037_01C5C340.8F255940
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds semanage_store.c. This is a modified version of
module_store.c.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0037_01C5C340.8F255940
Content-Type: application/octet-stream;
	name="libsemanage_src_semanage_store.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_semanage_store.c.diff"

diff -purN -x .svn libsemanage/src/semanage_store.c =
libsemanage/src/semanage_store.c=0A=
--- libsemanage/src/semanage_store.c	1969-12-31 19:00:00.000000000 -0500=0A=
+++ libsemanage/src/semanage_store.c	2005-09-26 12:21:22.000000000 -0400=0A=
@@ -0,0 +1,1316 @@=0A=
+/* Authors: Karl MacMillan <kmacmillan@tresys.com>=0A=
+ *	    Joshua Brindle <jbrindle@tresys.com>=0A=
+ *	    Jason Tang <jtang@tresys.com>=0A=
+ *=0A=
+ * Copyright (C) 2004-2005 Tresys Technology, LLC=0A=
+ *=0A=
+ *  This library is free software; you can redistribute it and/or=0A=
+ *  modify it under the terms of the GNU Lesser General Public=0A=
+ *  License as published by the Free Software Foundation; either=0A=
+ *  version 2.1 of the License, or (at your option) any later version.=0A=
+ *=0A=
+ *  This library is distributed in the hope that it will be useful,=0A=
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
+ *  Lesser General Public License for more details.=0A=
+ *=0A=
+ *  You should have received a copy of the GNU Lesser General Public=0A=
+ *  License along with this library; if not, write to the Free Software=0A=
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
+ */=0A=
+=0A=
+/* This file contains semanage routines that manipulate the files on a=0A=
+ * local module store.	Sandbox routines, used by both source and=0A=
+ * direct connections, are here as well.=0A=
+ */=0A=
+=0A=
+#include "semanage_store.h"=0A=
+=0A=
+#include <selinux/selinux.h>=0A=
+#include <sepol/module.h>=0A=
+#include <sepol/sepol.h>=0A=
+#include <sepol/link.h>=0A=
+#include <sepol/expand.h>=0A=
+=0A=
+#include <assert.h>=0A=
+#include <ctype.h>=0A=
+#include <dirent.h>=0A=
+#include <errno.h>=0A=
+#include <fcntl.h>=0A=
+#include <stdio.h>=0A=
+#include <stdlib.h>=0A=
+#include <string.h>=0A=
+#include <unistd.h>=0A=
+#include <sys/stat.h>=0A=
+#include <sys/types.h>=0A=
+#include <sys/wait.h>=0A=
+=0A=
+=0A=
+/* relative path names to enum semanage_paths to special files and=0A=
+ * directories for the module store */=0A=
+enum semanage_file_defs {=0A=
+	SEMANAGE_ROOT, =0A=
+	SEMANAGE_TRANS_LOCK, =0A=
+	SEMANAGE_READ_LOCK,=0A=
+	SEMANAGE_CONF,=0A=
+	SEMANAGE_NUM_FILES=0A=
+};=0A=
+=0A=
+static char =
*semanage_paths[SEMANAGE_NUM_STORES][SEMANAGE_STORE_NUM_PATHS];=0A=
+static char *semanage_files[SEMANAGE_NUM_FILES] =3D { NULL };=0A=
+static int semanage_paths_initialized =3D 0;=0A=
+=0A=
+/* These are paths relative to the bottom of the module store */=0A=
+static const char *semanage_relative_files[SEMANAGE_NUM_FILES] =3D {=0A=
+	"", =0A=
+	"/semanage.trans.LOCK",=0A=
+	"/semanage.read.LOCK",=0A=
+	"/semanage.conf"=0A=
+};=0A=
+=0A=
+static const char *semanage_store_paths[SEMANAGE_NUM_STORES] =3D {=0A=
+	"/active", =0A=
+	"/previous",=0A=
+	"/tmp"=0A=
+};=0A=
+=0A=
+/* this is the module store path relative to selinux_policy_root() */=0A=
+#define SEMANAGE_MOD_DIR "/modules"=0A=
+/* relative path names to enum sandbox_paths for special files within=0A=
+ * a sandbox */=0A=
+static const char *semanage_sandbox_paths[SEMANAGE_STORE_NUM_PATHS] =3D =
{=0A=
+	"",=0A=
+	"/modules",=0A=
+	"/policy.kern",=0A=
+	"/base.pp",=0A=
+	"/base.linked",=0A=
+	"/file_contexts",=0A=
+	"/commit_num"=0A=
+};=0A=
+=0A=
+/* Initialize the paths to config file, lock files and store root.=0A=
+ */=0A=
+static int semanage_init_paths(const char *root) {=0A=
+	size_t len, prefix_len;=0A=
+	int i;=0A=
+=0A=
+	if (!root)=0A=
+		return -1;=0A=
+=0A=
+	prefix_len =3D (strlen(root) + strlen(SEMANAGE_MOD_DIR));	=0A=
+=0A=
+	for (i =3D 0; i < SEMANAGE_NUM_FILES; i++) {=0A=
+		len =3D (strlen(semanage_relative_files[i]) + prefix_len);=0A=
+		semanage_files[i] =3D calloc(len + 1, sizeof(char));=0A=
+		if (!semanage_files[SEMANAGE_ROOT])=0A=
+			return -1;=0A=
+		sprintf(semanage_files[i], "%s%s%s", root, SEMANAGE_MOD_DIR,=0A=
+				  semanage_relative_files[i]); =0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+	=0A=
+=0A=
+/* This initializes the paths inside the stores, this is only necessary =0A=
+ * when directly accessing the store=0A=
+ */=0A=
+static int semanage_init_store_paths(const char *root) {=0A=
+	int i, j;=0A=
+	size_t len;=0A=
+	size_t prefix_len;=0A=
+	char *prefix;=0A=
+=0A=
+	if (!root)=0A=
+		return -1;=0A=
+=0A=
+	prefix_len =3D (strlen(root) + strlen(SEMANAGE_MOD_DIR));=0A=
+	prefix =3D calloc(prefix_len + 1, sizeof(char));=0A=
+	if (!prefix)=0A=
+		return -1;=0A=
+	sprintf(prefix, "%s%s", root, SEMANAGE_MOD_DIR);=0A=
+=0A=
+	for (i =3D 0; i < SEMANAGE_NUM_STORES; i++) {=0A=
+		for (j =3D 0; j < SEMANAGE_STORE_NUM_PATHS; j++) {=0A=
+			len =3D prefix_len + strlen(semanage_store_paths[i]) =0A=
+					 + strlen(semanage_sandbox_paths[j]);=0A=
+			semanage_paths[i][j] =3D calloc(len + 1, sizeof(char));=0A=
+			if (!semanage_paths[i][j])=0A=
+				goto cleanup;=0A=
+			sprintf(semanage_paths[i][j], "%s%s%s", prefix, =0A=
+						semanage_store_paths[i],=0A=
+						semanage_sandbox_paths[j]);=0A=
+		}=0A=
+	}=0A=
+=0A=
+cleanup:=0A=
+	free(prefix);	=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* THIS MUST BE THE FIRST FUNCTION CALLED IN THIS LIBRARY.  If the=0A=
+ * library has nnot been initialized yet then call the functions that=0A=
+ * initialize the path variables.  This function does nothing if it=0A=
+ * was previously called and that call was successful.  Return 0 on=0A=
+ * success, -1 on error.=0A=
+ *=0A=
+ * Note that this function is NOT thread-safe.=0A=
+ */=0A=
+int semanage_check_init(const char *root) {=0A=
+	int rc;	=0A=
+	if (semanage_paths_initialized =3D=3D 0) {=0A=
+		rc =3D semanage_init_paths(root);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		rc =3D semanage_init_store_paths(root);=0A=
+		if (rc)=0A=
+			return rc;=0A=
+		semanage_paths_initialized =3D 1;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+#define SEMANAGE_CHECK_INIT if (semanage_check_init() < 0) return NULL;=0A=
+=0A=
+=0A=
+/* Given a store location (active/previous/tmp) and a definition=0A=
+ * number, return a fully-qualified path to that file or directory.=0A=
+ * The caller must not alter the string returned (and hence why this=0A=
+ * function return type is const).=0A=
+ *=0A=
+ * This function shall never return a NULL, assuming that=0A=
+ * semanage_check_init() was previously called.=0A=
+ */=0A=
+const char *semanage_path(enum semanage_store_defs store, enum =
semanage_sandbox_defs path_name) {=0A=
+	assert(semanage_paths[store][path_name]);=0A=
+	return semanage_paths[store][path_name];=0A=
+}=0A=
+=0A=
+/* Return a fully-qualified path + filename to the semanage=0A=
+ * configuration file.  The caller must not alter the string returned=0A=
+ * (and hence why this function return type is const).=0A=
+ *=0A=
+ * This function shall never return a NULL, assuming that=0A=
+ * semanage_check_init() was previously called.=0A=
+ */=0A=
+const char *semanage_conf_path(void) {=0A=
+	return semanage_files[SEMANAGE_CONF];=0A=
+}=0A=
+=0A=
+/**************** functions that create module store ***************/=0A=
+=0A=
+/* Check that the semanage store exists.  If 'create' is non-zero then=0A=
+ * create the directories.  Returns 0 if module store exists (either=0A=
+ * already or just created), -1 if does not exist or could not be=0A=
+ * read, or -2 if it could not create the store. */=0A=
+int semanage_create_store(semanage_handle_t *sh, int create) {=0A=
+	struct stat sb;=0A=
+	int mode_mask =3D R_OK | W_OK | X_OK;=0A=
+	const char *path =3D semanage_files[SEMANAGE_ROOT];=0A=
+	if (stat(path, &sb) =3D=3D -1) {=0A=
+		if (errno =3D=3D ENOENT && create) {=0A=
+			if (mkdir(path, S_IRWXU) =3D=3D -1) {=0A=
+				semanage_write_error(sh, "Could not create module store at %s.", =
path);=0A=
+				return -2;=0A=
+			}=0A=
+		}=0A=
+		else {=0A=
+			semanage_write_error(sh, "Could not read from module store at %s.", =
path);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	else {=0A=
+		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) =3D=3D -1) {=0A=
+			semanage_write_error(sh, "Could not access module store at %s, or it =
is not a directory.", path);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_TOPLEVEL);=0A=
+	if (stat(path, &sb) =3D=3D -1) {=0A=
+		if (errno =3D=3D ENOENT && create) {=0A=
+			if (mkdir(path, S_IRWXU) =3D=3D -1) {=0A=
+				semanage_write_error(sh, "Could not create module store, active =
subdirectory at %s.", path);=0A=
+				return -2;=0A=
+			}=0A=
+		}=0A=
+		else {=0A=
+			semanage_write_error(sh, "Could not read from module store, active =
subdirectory at %s.", path);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	else {=0A=
+		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) =3D=3D -1) {=0A=
+			semanage_write_error(sh, "Could not access module store active =
subdirectory at %s, or it is not a directory.", path);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);=0A=
+	if (stat (path, &sb) =3D=3D -1) {=0A=
+		if (errno =3D=3D ENOENT && create) {=0A=
+			if (mkdir(path, S_IRWXU) =3D=3D -1) {=0A=
+				semanage_write_error(sh, "Could not create module store, active =
modules subdirectory at %s.", path);=0A=
+				return -2;=0A=
+			}=0A=
+		}=0A=
+		else {=0A=
+			semanage_write_error(sh, "Could not read from module store, active =
modules subdirectory at %s.", path);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	else {=0A=
+		if (!S_ISDIR(sb.st_mode) || access(path, mode_mask) =3D=3D -1) {=0A=
+			semanage_write_error(sh, "Could not access module store active =
modules subdirectory at %s, or it is not a directory.", path);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
+/********************* other I/O functions *********************/=0A=
+=0A=
+/* Callback used by scandir() to select files. */=0A=
+static int semanage_filename_select(const struct dirent *d) {=0A=
+	int len;=0A=
+=0A=
+	/* For some reason XFS doesn't set d_type so we actually have=0A=
+	 * to use stat() to decide if it's a directory or not :(=0A=
+	 */=0A=
+	len =3D strlen(d->d_name);=0A=
+	if (len =3D=3D 1 && d->d_name[0] =3D=3D '.')=0A=
+		return 0;=0A=
+	if (len =3D=3D 2 && d->d_name[0] =3D=3D '.' &&=0A=
+	    d->d_name[1] =3D=3D '.')=0A=
+		return 0;=0A=
+	return 1;=0A=
+}=0A=
+=0A=
+/* Copies a file from src to dst.  If dst already exists then=0A=
+ * overwrite it.  Returns 0 on success, -1 on error. */=0A=
+static int semanage_copy_file(const char *src, const char *dst) {=0A=
+	int in, out, retval =3D 0, amount_read;=0A=
+	char buf[4192];=0A=
+	if ((in =3D open(src, O_RDONLY)) =3D=3D -1) {=0A=
+		return -1;=0A=
+	}=0A=
+	if ((out =3D open(dst, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) =3D=3D =
-1) {=0A=
+		close(in);=0A=
+		return -1;=0A=
+	}=0A=
+	while (retval =3D=3D 0 &&=0A=
+	       (amount_read =3D read(in, buf, sizeof(buf))) > 0) {=0A=
+		if (write(out, buf, amount_read) !=3D amount_read) {=0A=
+			retval =3D -1;=0A=
+		}=0A=
+	}=0A=
+	if (amount_read < 0)=0A=
+		retval =3D -1;=0A=
+	close(in);=0A=
+	close(out);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Copies all of the files from src to dst, recursing into=0A=
+ * subdirectories.  Returns 0 on success, -1 on error. */=0A=
+static int semanage_copy_dir(const char *src, const char *dst) {=0A=
+	int i, len =3D 0, retval =3D -1;=0A=
+	struct stat sb;=0A=
+	struct dirent **names =3D NULL;=0A=
+	char path[PATH_MAX], path2[PATH_MAX];=0A=
+=0A=
+	if ((len =3D scandir(src, &names, semanage_filename_select, NULL)) =
=3D=3D -1) {=0A=
+		return -1;=0A=
+	}=0A=
+	for (i =3D 0; i < len; i++) {=0A=
+		snprintf(path, sizeof(path), "%s/%s", src, names[i]->d_name);=0A=
+		/* stat() to see if this entry is a file or not since=0A=
+		 * d_type isn't set properly on XFS */=0A=
+		if (stat(path, &sb)) {=0A=
+			goto cleanup;=0A=
+		}=0A=
+		snprintf(path2, sizeof(path2), "%s/%s", dst, names[i]->d_name);=0A=
+		if (S_ISDIR(sb.st_mode)) {=0A=
+			if (mkdir(path2, 0700) =3D=3D -1 ||=0A=
+			    semanage_copy_dir(path, path2) =3D=3D -1) {=0A=
+				goto cleanup;=0A=
+			}=0A=
+		}=0A=
+		else if (S_ISREG(sb.st_mode)) {=0A=
+			if (semanage_copy_file(path, path2) =3D=3D -1) {=0A=
+				goto cleanup;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	retval =3D 0;=0A=
+ cleanup:=0A=
+	for (i =3D 0; names !=3D NULL && i < len; i++) {=0A=
+		free(names[i]);=0A=
+	}=0A=
+	free(names);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+=0A=
+/* Recursively removes the contents of a directory along with the=0A=
+ * directory itself.  Returns 0 on success, non-zero on error. */=0A=
+int semanage_remove_directory(const char *path) {=0A=
+	struct dirent **namelist =3D NULL;=0A=
+	int num_entries, i;=0A=
+	if ((num_entries =3D scandir(path, &namelist, semanage_filename_select,=0A=
+				   NULL)) =3D=3D -1) {=0A=
+		return -1;=0A=
+	}=0A=
+	for (i =3D 0; i < num_entries; i++) {=0A=
+		char s[NAME_MAX];=0A=
+		struct stat buf;=0A=
+		snprintf(s, sizeof (s), "%s/%s", path, namelist[i]->d_name);=0A=
+		if (stat(s, &buf) =3D=3D -1) {=0A=
+			return -2;=0A=
+		}=0A=
+		if (S_ISDIR(buf.st_mode)) {=0A=
+			int retval;=0A=
+			if ((retval =3D semanage_remove_directory(s)) !=3D 0) {=0A=
+				return retval;=0A=
+			}=0A=
+		}=0A=
+		else {=0A=
+			if (remove(s) =3D=3D -1) {=0A=
+				return -3;=0A=
+			}=0A=
+		}=0A=
+		free(namelist[i]);=0A=
+	}=0A=
+	free(namelist);=0A=
+	if (remove(path) =3D=3D -1) {=0A=
+		return -4;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/********************* sandbox management routines =
*********************/=0A=
+=0A=
+/* Creates a sandbox for a single client. Returns 0 if a=0A=
+ * sandbox was created (and thus assigned to sh->conn.module.sandbox),=0A=
+ * -1 on error.=0A=
+ */=0A=
+int semanage_make_sandbox(semanage_handle_t *sh) {=0A=
+	const char *sandbox =3D semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);=0A=
+	struct stat buf;=0A=
+=0A=
+	if (stat(sandbox, &buf) =3D=3D -1) {=0A=
+		if (errno !=3D ENOENT) {=0A=
+			semanage_write_error(sh, "Error scanning directory %s.", sandbox);=0A=
+			return -1;=0A=
+	       }=0A=
+	}=0A=
+	else {=0A=
+		/* remove the old sandbox */=0A=
+		if (semanage_remove_directory(sandbox) !=3D 0) {=0A=
+			semanage_write_error(sh, "Error removing old sandbox directory %s.", =
sandbox);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (mkdir(sandbox, S_IRWXU) =3D=3D -1 ||=0A=
+	    semanage_copy_dir(semanage_path(SEMANAGE_ACTIVE, =
SEMANAGE_TOPLEVEL), sandbox) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not copy files to sandbox %s.", =
sandbox);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	return 0;=0A=
+=0A=
+ cleanup:=0A=
+	semanage_remove_directory(sandbox);=0A=
+	return -1;=0A=
+}=0A=
+=0A=
+/* Scans the modules directory for the current semanage handler.  This=0A=
+ * might be the active directory or sandbox, depending upon if the=0A=
+ * handler has a transaction lock.  Allocates and fills in *filenames=0A=
+ * with an array of module filenames; length of array is stored in=0A=
+ * *len.  The caller is responsible for free()ing *filenames and its=0A=
+ * individual elements.	 Upon success returns 0, -1 on error.=0A=
+ */=0A=
+int semanage_get_modules_names(semanage_handle_t *sh, char =
***filenames, int *len) {=0A=
+	const char *modules_path;=0A=
+	struct dirent **namelist =3D NULL;=0A=
+	int num_files, i, retval =3D -1;=0A=
+=0A=
+	if (sh->is_in_transaction) {=0A=
+		modules_path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES);=0A=
+	} else {=0A=
+		modules_path =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_MODULES);=0A=
+	}=0A=
+=0A=
+	*filenames =3D NULL;=0A=
+	*len =3D 0;=0A=
+	if ((num_files =3D scandir(modules_path, &namelist,=0A=
+				 semanage_filename_select, alphasort)) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while scanning directory %s.", =
modules_path);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (num_files =3D=3D 0) {=0A=
+		retval =3D 0;=0A=
+		goto cleanup;=0A=
+	}	=0A=
+	if ((*filenames =3D (char **) calloc(num_files, sizeof(**filenames))) =
=3D=3D NULL) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		goto cleanup;=0A=
+	}	=0A=
+	for (i =3D 0; i < num_files; i++) {=0A=
+		char *filename;=0A=
+		char path[PATH_MAX];=0A=
+=0A=
+		snprintf(path, PATH_MAX, "%s/%s", modules_path, namelist[i]->d_name);=0A=
+		if ((filename =3D strdup(path)) =3D=3D NULL) {=0A=
+			int j;=0A=
+			semanage_write_error(sh, "Out of memory!");=0A=
+			for (j =3D 0; j < i; j++) {=0A=
+				free((*filenames)[j]);=0A=
+			}=0A=
+			free(*filenames);=0A=
+			*filenames =3D NULL;=0A=
+			goto cleanup;=0A=
+		}=0A=
+		(*filenames)[i] =3D filename;=0A=
+	}=0A=
+	*len =3D num_files;=0A=
+	retval =3D 0;=0A=
+ cleanup:=0A=
+	for (i =3D 0; i < num_files; i++) {=0A=
+		free(namelist[i]);=0A=
+	}=0A=
+	free(namelist);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+=0A=
+/* Prepare the sandbox to be installed by making a backup of the=0A=
+ * current active directory.  Then copy the sandbox to the active=0A=
+ * directory.  Return the new commit number on success, negative=0A=
+ * values on error. */=0A=
+static int semanage_commit_sandbox(semanage_handle_t *sh) {=0A=
+	int commit_number, fd;=0A=
+	char write_buf[32];=0A=
+	const char *commit_filename =3D semanage_path(SEMANAGE_TMP, =
SEMANAGE_COMMIT_NUM_FILE);=0A=
+	ssize_t amount_written;=0A=
+	const char *active =3D semanage_path(SEMANAGE_ACTIVE, =
SEMANAGE_TOPLEVEL);=0A=
+	const char *backup =3D semanage_path(SEMANAGE_PREVIOUS, =
SEMANAGE_TOPLEVEL);=0A=
+	const char *sandbox =3D semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL);=0A=
+	struct stat buf;=0A=
+=0A=
+	/* update the commit number */=0A=
+	if ((commit_number =3D semanage_get_commit_number(sh)) < 0) {=0A=
+		return -1;=0A=
+	}=0A=
+	commit_number++;=0A=
+	memset(write_buf, 0, sizeof(write_buf));=0A=
+	snprintf(write_buf, sizeof(write_buf), "%d", commit_number);=0A=
+	if ((fd =3D open(commit_filename, O_WRONLY | O_CREAT, S_IRUSR | =
S_IWUSR)) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not open commit number file %s for =
writing.", commit_filename);=0A=
+		return -1;=0A=
+	}=0A=
+	amount_written =3D write(fd, write_buf, sizeof(write_buf));=0A=
+	if (amount_written =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while writing commit number to %s.", =
commit_filename);=0A=
+		close(fd);=0A=
+		return -1;=0A=
+	}=0A=
+	close(fd);=0A=
+=0A=
+	/* make the backup of the current active directory */=0A=
+	if (stat(backup, &buf) =3D=3D 0) {=0A=
+		if (S_ISDIR(buf.st_mode) && =0A=
+		    semanage_remove_directory(backup) !=3D 0) {=0A=
+			semanage_write_error(sh, "Could not remove previous backup %s.", =
backup);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	else if (errno !=3D ENOENT) {=0A=
+		semanage_write_error(sh, "Could not stat directory %s.", backup);=0A=
+		return -1;=0A=
+	}=0A=
+=0A=
+	if (rename(active, backup) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while renaming %s to %s.", active, =
backup);=0A=
+		return -1;=0A=
+	}=0A=
+	if (rename(sandbox, active) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while renaming %s to %s.", sandbox, =
active);=0A=
+		/* note that if an error occurs during the next=0A=
+		 * function then the store will be left in an=0A=
+		 * inconsistent state */=0A=
+		rename(backup, active);=0A=
+		return -1;=0A=
+	}=0A=
+	return commit_number;=0A=
+}=0A=
+=0A=
+/******************* routines that run external programs =
*******************/=0A=
+=0A=
+/* Appends a single character to a string.  Returns a pointer to the=0A=
+ * realloc()ated string.  If out of memory return NULL; original=0A=
+ * string will remain untouched.=0A=
+ */=0A=
+static char *append(char *s, char c) {=0A=
+	size_t len =3D (s =3D=3D NULL ? 0 : strlen(s));=0A=
+	char *new_s =3D realloc(s, len + 2);=0A=
+	if (new_s =3D=3D NULL) {=0A=
+		return NULL;=0A=
+	}=0A=
+	s =3D new_s;=0A=
+	s[len] =3D c;=0A=
+	s[len + 1] =3D '\0';=0A=
+	return s;=0A=
+}=0A=
+=0A=
+/* Append string 't' to string 's', realloc()ating 's' as needed.  't'=0A=
+ * may be safely free()d afterwards.  Returns a pointer to the=0A=
+ * realloc()ated 's'.  If out of memory return NULL; original strings=0A=
+ * will remain untouched.=0A=
+ */=0A=
+static char *append_str(char *s, const char *t) {=0A=
+	size_t s_len =3D (s =3D=3D NULL ? 0 : strlen(s));=0A=
+	size_t t_len =3D (t =3D=3D NULL ? 0 : strlen(t));=0A=
+	char *new_s =3D realloc(s, s_len + t_len + 1);=0A=
+	if (new_s =3D=3D NULL) {=0A=
+		return NULL;=0A=
+	}=0A=
+	s =3D new_s;=0A=
+	memcpy(s + s_len, t, t_len);=0A=
+	s[s_len + t_len] =3D '\0';=0A=
+	return s;=0A=
+}=0A=
+=0A=
+/* Append an argument string to an argument vector, returning a=0A=
+ * pointer to the realloc()ated argument vector.  Also increments=0A=
+ * 'num_args'.=0A=
+ */=0A=
+static char **append_arg(char **argv, int *num_args, const char *arg) {=0A=
+	char **a;=0A=
+	if ((a =3D realloc(argv, sizeof(*argv) * (*num_args + 1))) =3D=3D =
NULL) {=0A=
+		return NULL;=0A=
+	}=0A=
+	argv =3D a;=0A=
+	if (arg =3D=3D NULL) {=0A=
+		argv[*num_args] =3D NULL;=0A=
+	}=0A=
+	else {=0A=
+		argv[*num_args] =3D strdup(arg);=0A=
+		if (!argv[*num_args]) {=0A=
+			return NULL;=0A=
+		}=0A=
+	}=0A=
+	(*num_args)++;=0A=
+	return argv;=0A=
+}=0A=
+=0A=
+=0A=
+/* free()s all strings within a null-terminated argument vector, as=0A=
+ * well as the pointer itself. */=0A=
+static void free_argv(char **argv) {=0A=
+	int i;=0A=
+	for (i =3D 0; argv !=3D NULL && argv[i] !=3D NULL; i++) {=0A=
+		free(argv[i]);=0A=
+	}=0A=
+	free(argv);=0A=
+}=0A=
+=0A=
+/* Take an argument string and split and place into an argument=0A=
+ * vector.  Respect normal quoting, double-quoting, and backslash=0A=
+ * conventions.	 Perform substitutions on $@ and $< symbols.  Returns=0A=
+ * a NULL-terminated argument vector; caller is responsible for=0A=
+ * free()ing the vector and its elements. */=0A=
+static char **split_args(const char *arg0, char *arg_string,=0A=
+			 const char *new_name, const char *old_name) {=0A=
+	char **argv =3D NULL, **tv, *s, *arg =3D NULL, *targ;=0A=
+	int num_args =3D 0, in_quote =3D 0, in_dquote =3D 0;=0A=
+=0A=
+	if ((tv =3D append_arg(argv, &num_args, arg0)) =3D=3D NULL) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	else {=0A=
+		argv =3D tv;=0A=
+	}=0A=
+	s =3D arg_string;=0A=
+	/* parse the argument string one character at a time,=0A=
+	 * repsecting quotes and other special characters */=0A=
+	while (s !=3D NULL && *s !=3D '\0') {=0A=
+		switch (*s) {=0A=
+		case '\\': {=0A=
+			if (*(s + 1) =3D=3D '\0') {=0A=
+				if ((targ =3D append(arg, '\\')) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+			}=0A=
+			else {=0A=
+				if ((targ =3D append(arg, *(s + 1))) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+				s++;=0A=
+			}=0A=
+			break;=0A=
+		}=0A=
+		case '\'': {=0A=
+			if (in_dquote) {=0A=
+				if ((targ =3D append(arg, *s)) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+			}=0A=
+			else if (in_quote) {=0A=
+				in_quote =3D 0;=0A=
+			}=0A=
+			else {=0A=
+				in_quote =3D 1;=0A=
+				if ((targ =3D append(arg, '\0')) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+			}=0A=
+			break;=0A=
+		}=0A=
+		case '\"': {=0A=
+			if (in_quote) {=0A=
+				if ((targ =3D append(arg, *s)) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+			}=0A=
+			else if (in_dquote) {=0A=
+				in_dquote =3D 0;=0A=
+			}=0A=
+			else {=0A=
+				in_dquote =3D 1;=0A=
+				if ((targ =3D append(arg, '\0')) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+			}=0A=
+			break;=0A=
+		}=0A=
+		case '$': {=0A=
+			switch (*(s + 1)) {=0A=
+			case '@': {=0A=
+				if ((targ =3D append_str(arg, new_name)) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+				s++;=0A=
+				break;=0A=
+			}=0A=
+			case '<': {=0A=
+				if ((targ =3D append_str(arg, old_name)) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+				s++;=0A=
+				break;=0A=
+			}=0A=
+			default: {=0A=
+				if ((targ =3D append (arg, *s)) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+			}=0A=
+			}=0A=
+			break;=0A=
+		}=0A=
+		default: {=0A=
+			if (isspace(*s) && !in_quote && !in_dquote) {=0A=
+				if (arg !=3D NULL) {=0A=
+					if ((tv =3D append_arg(argv, &num_args, arg)) =3D=3D NULL) {=0A=
+						goto cleanup;=0A=
+					}=0A=
+					else {=0A=
+						argv =3D tv;=0A=
+					}=0A=
+					free(arg);=0A=
+					arg =3D NULL;=0A=
+				}=0A=
+			}=0A=
+			else {=0A=
+				if ((targ =3D append(arg, *s)) =3D=3D NULL) {=0A=
+					goto cleanup;=0A=
+				}=0A=
+				else {=0A=
+					arg =3D targ;=0A=
+				}=0A=
+			}=0A=
+		}=0A=
+		}=0A=
+		s++;=0A=
+	}=0A=
+	if (arg !=3D NULL) {=0A=
+		if ((tv =3D append_arg(argv, &num_args, arg)) =3D=3D NULL) {=0A=
+			goto cleanup;=0A=
+		}=0A=
+		else {=0A=
+			argv =3D tv;=0A=
+		}=0A=
+		free(arg);=0A=
+		arg =3D NULL;=0A=
+	}=0A=
+	/* explicitly add a NULL at the end */=0A=
+	if ((tv =3D append_arg(argv, &num_args, NULL)) !=3D NULL) {=0A=
+		return tv;=0A=
+	}=0A=
+ cleanup:=0A=
+	free_argv(argv);=0A=
+	free(arg);=0A=
+	return NULL;=0A=
+}=0A=
+=0A=
+/* Take the arguments given in v->args and expand any $ macros within.=0A=
+ * Split the arguments into different strings (argv).  Next fork and=0A=
+ * execute the process.	 BE SURE THAT ALL FILE DESCRIPTORS ARE SET TO=0A=
+ * CLOSE-ON-EXEC.  Take the return value of the child process and=0A=
+ * return it, -1 on error.=0A=
+ */=0A=
+static int semanage_exec_prog(semanage_handle_t *sh,=0A=
+		       external_prog_t *e, const char *new_name, const char =
*old_name) {=0A=
+	char **argv;=0A=
+	pid_t forkval;=0A=
+=0A=
+	if ((argv =3D split_args(e->path, e->args, new_name, old_name)) =3D=3D =
NULL) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		return -1;=0A=
+	}=0A=
+	=0A=
+	/* no need to use pthread_atfork() -- child will not be using=0A=
+	 * any mutexes. */=0A=
+	if ((forkval =3D fork()) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while forking process.");=0A=
+		return -1;=0A=
+	}=0A=
+	else if (forkval =3D=3D 0) {=0A=
+		/* child process.  file descriptors will be closed=0A=
+		 * because they were set as close-on-exec. */=0A=
+		execve(e->path, argv, NULL);=0A=
+		exit(EXIT_FAILURE);		/* if execve() failed */=0A=
+	}=0A=
+	else {=0A=
+		/* parent process.  wait for child to finish */=0A=
+		int status =3D 0;=0A=
+		free_argv(argv);=0A=
+		if (waitpid(forkval, &status, 0) =3D=3D -1 || !WIFEXITED(status)) {=0A=
+			semanage_write_error(sh, "Child process %s did not exit cleanly.", =
e->path);=0A=
+			return -1;=0A=
+		}=0A=
+		return WEXITSTATUS(status);=0A=
+	}=0A=
+	assert(0);=0A=
+	return 0;	 /* never reached, but here to satisfy lint */=0A=
+}=0A=
+=0A=
+/* Actually load the contents of the current active directory into the=0A=
+ * kernel.  Return 0 on success, -3 on error. */=0A=
+static int semanage_install_active(semanage_handle_t *sh) {=0A=
+	char running_policy[PATH_MAX];=0A=
+	const char *active_kernel =3D =
semanage_path(SEMANAGE_ACTIVE,SEMANAGE_KERNEL);=0A=
+	const char *active_fc =3D semanage_path(SEMANAGE_ACTIVE, SEMANAGE_FC);=0A=
+	const char *running_fc =3D selinux_file_context_path();=0A=
+	int retval =3D -3, r;=0A=
+	snprintf(running_policy, PATH_MAX, "%s.%d",=0A=
+		 selinux_binary_policy_path(), security_policyvers());=0A=
+	if (semanage_copy_file(active_kernel, running_policy) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not copy %s to %s.", active_kernel, =
running_policy);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (semanage_copy_file(active_fc, running_fc) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not copy %s to %s.", active_fc, =
running_fc);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if ((r =3D semanage_exec_prog(sh, sh->conf->load_policy, =
running_policy, "")) !=3D 0) {=0A=
+		semanage_write_error(sh, "load_policy returned error code %d.", r);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	=0A=
+	if ((r =3D semanage_exec_prog(sh, sh->conf->setfiles, running_policy, =
running_fc)) !=3D 0) {=0A=
+		semanage_write_error(sh, "setfiles returned error code %d.", r);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	retval =3D 0;=0A=
+ cleanup:=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Takes the kernel policy in a sandbox, move it to the active=0A=
+ * directory, copy it to the binary policy path, then load it.	Upon=0A=
+ * error move the active directory back to the sandbox.	 This function=0A=
+ * should be placed within a mutex lock to ensure that it runs=0A=
+ * atomically.	Returns 0 on success, -1 on error.=0A=
+ */=0A=
+int semanage_install_sandbox(semanage_handle_t *sh) {=0A=
+	char running_policy[PATH_MAX];=0A=
+	int retval =3D -1, new_commit_number;=0A=
+=0A=
+	if (sh->conf->load_policy =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "No load_policy program specified in =
configuration file.");=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (sh->conf->setfiles =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "No setfiles program specified in =
configuration file.");=0A=
+		goto cleanup;=0A=
+	}=0A=
+=0A=
+	snprintf(running_policy, PATH_MAX, "%s.%d",=0A=
+		 selinux_binary_policy_path(), security_policyvers());=0A=
+=0A=
+	if ((new_commit_number =3D semanage_commit_sandbox(sh)) < 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (semanage_install_active(sh) !=3D 0) {=0A=
+		const char *active =3D semanage_path(SEMANAGE_ACTIVE, =
SEMANAGE_TOPLEVEL);=0A=
+		const char *backup =3D semanage_path(SEMANAGE_PREVIOUS, =
SEMANAGE_TOPLEVEL);=0A=
+		const char *sandbox =3D semanage_path(SEMANAGE_TMP, =
SEMANAGE_TOPLEVEL);=0A=
+		/* note that if an error occurs during the next three=0A=
+		 * function then the store will be left in an=0A=
+		 * inconsistent state */=0A=
+		rename(active, sandbox);=0A=
+		rename(backup, active);=0A=
+		semanage_install_active(sh);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	retval =3D new_commit_number;=0A=
+=0A=
+ cleanup:=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+=0A=
+=0A=
+/********************* functions that manipulate lock =
*********************/=0A=
+=0A=
+static int semanage_get_lock(semanage_handle_t *sh,=0A=
+			     const char *lock_name, const char *lock_file) {=0A=
+	int fd;=0A=
+	struct timeval origtime, curtime;=0A=
+	int got_lock =3D 0;=0A=
+=0A=
+	if ((fd =3D open(lock_file, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR)) =
=3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not open direct %s at %s.", =
lock_name, lock_file);=0A=
+		return -1;=0A=
+	}=0A=
+	if (sh->timeout =3D=3D 0) {=0A=
+		/* return immediately */=0A=
+		origtime.tv_sec =3D 0;=0A=
+	}=0A=
+	else {=0A=
+		origtime.tv_sec =3D sh->timeout;=0A=
+	}=0A=
+	origtime.tv_usec =3D 0;=0A=
+	do {=0A=
+		curtime.tv_sec =3D 1;=0A=
+		curtime.tv_usec =3D 0;=0A=
+		if (lockf(fd, F_TLOCK, 0) =3D=3D 0) {=0A=
+			got_lock =3D 1;=0A=
+			break;=0A=
+		}=0A=
+		else if (errno !=3D EAGAIN) {=0A=
+			semanage_write_error(sh, "Error obtaining direct %s at %s.", =
lock_name, lock_file);=0A=
+			close(fd);=0A=
+			return -1;=0A=
+		}=0A=
+		if (origtime.tv_sec > 0 || sh->timeout =3D=3D -1) {=0A=
+			if (select(0, NULL, NULL, NULL, &curtime) =3D=3D -1) {=0A=
+				if (errno =3D=3D EINTR) {=0A=
+					continue;=0A=
+				}=0A=
+				semanage_write_error(sh, "Error while waiting to get direct %s at =
%s.", lock_name, lock_file);=0A=
+				close(fd);=0A=
+				return -1;=0A=
+			}=0A=
+			origtime.tv_sec--;=0A=
+		}=0A=
+	} while (origtime.tv_sec > 0 || sh->timeout =3D=3D -1);=0A=
+	if (!got_lock) {=0A=
+		semanage_write_error(sh, "Could not get direct %s at %s.", lock_name, =
lock_file);=0A=
+		close(fd);=0A=
+		return -1;=0A=
+	}=0A=
+	return fd;=0A=
+}=0A=
+=0A=
+=0A=
+/* Locking for the module store for transactions.  This is very basic=0A=
+ * locking of the module store and doesn't do anything if the module=0A=
+ * store is being manipulated with a program not using this library=0A=
+ * (but the policy should prevent that).  Returns 0 on success, -1 if=0A=
+ * it could not obtain a lock.=0A=
+ */=0A=
+int semanage_get_trans_lock(semanage_handle_t *sh) {=0A=
+	const char *lock_file =3D semanage_files[SEMANAGE_TRANS_LOCK];=0A=
+=0A=
+	sh->conn.module.translock_file_fd =3D=0A=
+	    semanage_get_lock(sh, "transaction lock", lock_file);=0A=
+	if (sh->conn.module.translock_file_fd >=3D 0) {=0A=
+		return 0;=0A=
+	}=0A=
+	else {=0A=
+		return -1;=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Locking for the module store for store reading; this also includes=0A=
+ * the file containing the commit number.  This is very basic locking=0A=
+ * of the module store and doesn't do anything if the module store is=0A=
+ * being manipulated with a program not using this library (but the=0A=
+ * policy should prevent that).	 Returns 0 on success, -1 if it could=0A=
+ * not obtain a lock.=0A=
+ */=0A=
+int semanage_get_read_lock(semanage_handle_t *sh) {=0A=
+	const char *lock_file =3D semanage_files[SEMANAGE_READ_LOCK];=0A=
+=0A=
+	sh->conn.module.readlock_file_fd =3D=0A=
+	    semanage_get_lock(sh, "read lock", lock_file);=0A=
+	if (sh->conn.module.readlock_file_fd >=3D 0) {=0A=
+		return 0;=0A=
+	}=0A=
+	else {=0A=
+		return -1;=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Releases the transaction lock.  Does nothing if there was not one =
already=0A=
+ * there. */=0A=
+void semanage_release_trans_lock(semanage_handle_t *sh) {=0A=
+	if (sh->conn.module.translock_file_fd >=3D 0) {=0A=
+		lockf(sh->conn.module.translock_file_fd, F_ULOCK, 0);=0A=
+		close(sh->conn.module.translock_file_fd);=0A=
+		sh->conn.module.translock_file_fd =3D -1;=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Releases the read lock.  Does nothing if there was not one already=0A=
+ * there. */=0A=
+void semanage_release_read_lock(semanage_handle_t *sh) {=0A=
+	if (sh->conn.module.readlock_file_fd >=3D 0) {=0A=
+		lockf(sh->conn.module.readlock_file_fd, F_ULOCK, 0);=0A=
+		close(sh->conn.module.readlock_file_fd);=0A=
+		sh->conn.module.readlock_file_fd =3D -1;=0A=
+	}=0A=
+}=0A=
+=0A=
+/* Read the current commit number from the commit number file which=0A=
+ * the handle is pointing, resetting the file pointer afterwards.=0A=
+ * Return it (a non-negative number), or -1 on error. */=0A=
+int semanage_get_commit_number(semanage_handle_t *sh) {=0A=
+	char buf[32];=0A=
+	int fd, commit_number;=0A=
+	ssize_t amount_read;=0A=
+	const char *commit_filename;=0A=
+	memset(buf, 0, sizeof(buf));=0A=
+=0A=
+	if (sh->is_in_transaction) {=0A=
+		commit_filename =3D semanage_path(SEMANAGE_TMP, =
SEMANAGE_COMMIT_NUM_FILE);=0A=
+	} else {=0A=
+		commit_filename =3D semanage_path(SEMANAGE_ACTIVE, =
SEMANAGE_COMMIT_NUM_FILE);=0A=
+	}=0A=
+	=0A=
+	if ((fd =3D open(commit_filename, O_RDONLY)) =3D=3D -1) {=0A=
+		if (errno =3D=3D ENOENT) {=0A=
+			/* the commit number file does not exist yet,=0A=
+			 * so assume that the number is 0 */=0A=
+			return 0;=0A=
+		}=0A=
+		else {=0A=
+			semanage_write_error(sh, "Could not open commit number file %s.", =
commit_filename);=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	amount_read =3D read(fd, buf, sizeof(buf));=0A=
+	if (amount_read =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while reading commit number from =
%s.", commit_filename);=0A=
+		commit_number =3D -1;=0A=
+	}=0A=
+	else if (sscanf(buf, "%d", &commit_number) !=3D 1) {=0A=
+		/* if nothing was read, assume that the commit number is 0 */=0A=
+		commit_number =3D 0;=0A=
+	}=0A=
+	else if (commit_number < 0) {=0A=
+		/* read file ought never have negative values */=0A=
+		semanage_write_error(sh, "Commit number file %s is corrupted; it =
should only contain a non-negative integer.", commit_filename);=0A=
+		commit_number =3D -1;=0A=
+	}=0A=
+=0A=
+	close(fd);=0A=
+	return commit_number;=0A=
+}=0A=
+=0A=
+/* HIGHER LEVEL COMMIT FUNCTIONS */=0A=
+=0A=
+/* Loads a module (or a base) from a fully-qualified 'filename' into a=0A=
+ * newly allocated sepol_module_package_t structure and returns it in=0A=
+ * '*package'.	Caller is responsible for destroying it afterwards via=0A=
+ * sepol_module_package_destroy().  Returns 0 on success, -1 on error.=0A=
+ */=0A=
+static int semanage_load_module(semanage_handle_t *sh, const char =
*filename, sepol_module_package_t **package) {=0A=
+	int retval =3D 0;=0A=
+	struct policy_file pf;=0A=
+=0A=
+	if ((*package =3D (sepol_module_package_t*) malloc(sizeof(**package))) =
=3D=3D NULL) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		return -1;=0A=
+	}=0A=
+	if (sepol_module_package_init(*package) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		sepol_module_package_destroy(*package);=0A=
+		*package =3D NULL;=0A=
+		return -1;=0A=
+	}=0A=
+=0A=
+	if ((pf.fp =3D fopen(filename, "rb")) =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "Could not open module file %s for =
reading.", filename);=0A=
+		sepol_module_package_destroy(*package);=0A=
+		*package =3D NULL;=0A=
+		return -1;=0A=
+	}=0A=
+	pf.type =3D PF_USE_STDIO;=0A=
+	if (sepol_module_package_read(*package, &pf, 0) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while reading from module file %s.", =
filename);=0A=
+		fclose(pf.fp);=0A=
+		sepol_module_package_destroy(*package);=0A=
+		*package =3D NULL;=0A=
+		return -1;=0A=
+	}=0A=
+	fclose(pf.fp);=0A=
+	if ((*package)->policy->policy_type =3D=3D POLICY_MOD) {=0A=
+		if (policydb_index_classes((*package)->policy) ||=0A=
+		    policydb_index_others((*package)->policy, 0)) {=0A=
+			semanage_write_error(sh, "Out of memory!");=0A=
+			sepol_module_package_destroy(*package);=0A=
+			*package =3D NULL;=0A=
+			return -1;=0A=
+		}=0A=
+	}=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Links all of the modules within the sandbox into the base module.=0A=
+ * '*base' will point to the module package that contains everything=0A=
+ * linked together (caller must call sepol_module_package_destroy() on=0A=
+ * it afterwards).  '*mods' will be a list of module packages and=0A=
+ * '*num_modules' will be the number of elements within '*mods'=0A=
+ * (caller must destroy each element as well as the pointer itself.)=0A=
+ * Both '*base' and '*mods' will be set to NULL upon entering this=0A=
+ * function.  Returns 0 on success, -1 on error.=0A=
+ */=0A=
+int semanage_link_sandbox(semanage_handle_t *sh,=0A=
+			  sepol_module_package_t **base) {=0A=
+	const char *base_filename =3D NULL;=0A=
+	char **module_filenames =3D NULL;=0A=
+	int retval =3D -1, i;=0A=
+	int num_modules =3D 0;=0A=
+	sepol_module_package_t **mods =3D NULL;=0A=
+	*base =3D NULL;=0A=
+=0A=
+	/* first make sure that base module is readable */=0A=
+	if ((base_filename =3D semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) =
=3D=3D NULL) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (access(base_filename, R_OK) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not access sandbox base file %s.", =
base_filename);=0A=
+		goto cleanup;=0A=
+	}=0A=
+=0A=
+	/* get list of modules and load them */=0A=
+	if (semanage_get_modules_names(sh, &module_filenames, &num_modules) =
=3D=3D -1 ||=0A=
+	    semanage_load_module(sh, base_filename, base) =3D=3D -1) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (num_modules =3D=3D 0) {=0A=
+		/* no modules, so skip over the rest of this function */=0A=
+		retval =3D 0;=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if ((mods =3D calloc(num_modules, sizeof(*mods))) =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		num_modules  =3D 0;=0A=
+		goto cleanup;=0A=
+	}=0A=
+	for (i =3D 0; i < num_modules; i++) {=0A=
+		if (semanage_load_module(sh, module_filenames[i], mods + i) =3D=3D =
-1) {=0A=
+			goto cleanup;=0A=
+		}=0A=
+	}=0A=
+=0A=
+	if (sepol_link_packages(*base, mods, num_modules, 0, sh->err_buf,=0A=
+				SEMANAGE_ERRBUFSZ) !=3D 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	retval =3D 0;=0A=
+=0A=
+ cleanup:=0A=
+	for (i =3D 0; module_filenames !=3D NULL && i < num_modules; i++) {=0A=
+		free(module_filenames[i]);=0A=
+	}=0A=
+	free(module_filenames);=0A=
+	for (i =3D 0; mods !=3D NULL && i < num_modules; i++) {=0A=
+		sepol_module_package_destroy(mods[i]);=0A=
+	}=0A=
+	free(mods);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Expands the policy contained within *base and write the final=0A=
+ * policy to the sandbox's kernel policy.  Returns 0 on success, -1 on=0A=
+ * error.=0A=
+ */=0A=
+int semanage_expand_sandbox(semanage_handle_t *sh, =
sepol_module_package_t *base) {=0A=
+	policydb_t out;=0A=
+	int retval =3D -1;=0A=
+	const char *kernel_filename =3D NULL;=0A=
+	sidtab_t sidtab;=0A=
+	struct policy_file pf;=0A=
+	FILE *outfile =3D NULL;=0A=
+=0A=
+	memset(&out, 0, sizeof(out));=0A=
+=0A=
+	/* activate the global branch before expansion */=0A=
+	base->policy->global->branch_list->enabled =3D 1;=0A=
+	base->policy->global->enabled =3D base->policy->global->branch_list;=0A=
+	if (expand_module(base->policy, &out, 0,=0A=
+			  sh->err_buf, SEMANAGE_ERRBUFSZ) =3D=3D -1) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (policydb_load_isids(&out, &sidtab) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while loading initial SIDs.");=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (policydb_index_others(&out, 0) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (sepol_set_policyvers(POLICY_KERN, sh->conf->policyvers)) {=0A=
+		semanage_write_error(sh, "Unknown/Invalid policy version %d.", =
sh->conf->policyvers);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if ((kernel_filename =3D semanage_path(SEMANAGE_TMP, SEMANAGE_KERNEL)) =
=3D=3D NULL) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if ((outfile =3D fopen(kernel_filename, "wb")) =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "Could not open kernel policy %s for =
writing.", kernel_filename);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	pf.type =3D PF_USE_STDIO;=0A=
+	pf.fp =3D outfile;=0A=
+	if (policydb_write(&out, &pf) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while writing kernel policy to %s.", =
kernel_filename);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	retval =3D 0;=0A=
+=0A=
+ cleanup:=0A=
+	if (outfile !=3D NULL) {=0A=
+		fclose(outfile);=0A=
+	}=0A=
+	policydb_destroy(&out);=0A=
+	sepol_sidtab_destroy(&sidtab);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Execute the module verification programs for each source module.=0A=
+ * Returns 0 if every verifier returned success, -1 on error.=0A=
+ */=0A=
+int semanage_verify_modules(semanage_handle_t *sh,=0A=
+			    char **module_filenames, int num_modules) {=0A=
+	int i, retval;=0A=
+	semanage_conf_t *conf =3D sh->conf;=0A=
+	if (conf->mod_prog =3D=3D NULL) {=0A=
+		return 0;=0A=
+	}=0A=
+	for (i =3D 0; i < num_modules; i++) {=0A=
+		char *module =3D module_filenames[i];=0A=
+		external_prog_t *e;=0A=
+		for (e =3D conf->mod_prog; e !=3D NULL; e =3D e->next) {=0A=
+			if ((retval =3D semanage_exec_prog(sh, e, module, "$<")) !=3D 0) {=0A=
+				return -1;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Execute the linker verification programs for the linked (but not=0A=
+ * expanded) base.  Returns 0 if every verifier returned success, -1=0A=
+ * on error.=0A=
+ */=0A=
+int semanage_verify_linked(semanage_handle_t *sh) {=0A=
+	external_prog_t *e;=0A=
+	semanage_conf_t *conf =3D sh->conf;=0A=
+	const char *linked_filename =3D semanage_path(SEMANAGE_TMP, =
SEMANAGE_LINKED);=0A=
+	int retval =3D -1;=0A=
+	if (conf->linked_prog =3D=3D NULL) {=0A=
+		return 0;=0A=
+	}=0A=
+	for (e =3D conf->linked_prog; e !=3D NULL; e =3D e->next) {=0A=
+		if (semanage_exec_prog(sh, e, linked_filename, "$<") !=3D 0) {=0A=
+			goto cleanup;=0A=
+		}=0A=
+	}=0A=
+	retval =3D 0;=0A=
+ cleanup:=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Execute each of the kernel verification programs.  Returns 0 if=0A=
+ * every verifier returned success, -1 on error.=0A=
+ */=0A=
+int semanage_verify_kernel(semanage_handle_t *sh) {=0A=
+	int retval =3D -1;=0A=
+	const char *kernel_filename =3D semanage_path(SEMANAGE_TMP, =
SEMANAGE_KERNEL);=0A=
+	semanage_conf_t *conf =3D sh->conf;=0A=
+	external_prog_t *e;=0A=
+	if (conf->kernel_prog =3D=3D NULL) {=0A=
+		return 0;=0A=
+	}=0A=
+	for (e =3D conf->kernel_prog; e !=3D NULL; e =3D e->next) {=0A=
+		if (semanage_exec_prog(sh, e, kernel_filename, "$<") !=3D 0) {=0A=
+			goto cleanup;=0A=
+		}=0A=
+	}=0A=
+	retval =3D 0;=0A=
+ cleanup:=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+hidden_def(semanage_link_sandbox)=0A=
+hidden_def(semanage_expand_sandbox)=0A=
+hidden_def(semanage_install_sandbox)=0A=
+hidden_def(semanage_verify_modules)=0A=
+hidden_def(semanage_verify_linked)=0A=
+hidden_def(semanage_verify_kernel)=0A=
+=0A=
+=0A=
+hidden_def(semanage_create_store)=0A=
+hidden_def(semanage_conf_path)=0A=
+hidden_def(semanage_remove_directory)=0A=
+hidden_def(semanage_make_sandbox)=0A=
+hidden_def(semanage_get_modules_names)=0A=
+hidden_def(semanage_get_trans_lock)=0A=
+hidden_def(semanage_get_read_lock)=0A=
+hidden_def(semanage_release_trans_lock)=0A=
+hidden_def(semanage_release_read_lock)=0A=
+hidden_def(semanage_get_commit_number)=0A=
+hidden_def(semanage_check_init)=0A=

------=_NextPart_000_0037_01C5C340.8F255940--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
