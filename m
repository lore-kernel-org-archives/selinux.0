Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCqKNs021597
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:52:20 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCkupk003799
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:46:56 GMT
Message-Id: <200509271247.j8RCl4Ys026045@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 5/17
Date: Tue, 27 Sep 2005 08:47:04 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_001C_01C5C340.08B06B70"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01C5C340.08B06B70
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds direct_api.c. This is an implementation of the public
libsemanage api for local files. It is not complete, but should handle
modules. It has been tested with the semodule program.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_001C_01C5C340.08B06B70
Content-Type: application/octet-stream;
	name="libsemanage_src_direct_api.c.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_src_direct_api.c.diff"

diff -purN -x .svn libsemanage/src/direct_api.c =
libsemanage/src/direct_api.c=0A=
--- libsemanage/src/direct_api.c	1969-12-31 19:00:00.000000000 -0500=0A=
+++ libsemanage/src/direct_api.c	2005-09-26 12:21:22.000000000 -0400=0A=
@@ -0,0 +1,484 @@=0A=
+/* Author: Jason Tang	  <jtang@tresys.com>=0A=
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
+#include "semanage_private.h"=0A=
+#include "direct_api.h"=0A=
+#include "semanage_store.h"=0A=
+=0A=
+#include <sepol/module.h>=0A=
+=0A=
+#include <assert.h>=0A=
+#include <fcntl.h>=0A=
+#include <stdio.h>=0A=
+#include <unistd.h>=0A=
+#include <sys/stat.h>=0A=
+#include <sys/types.h>=0A=
+=0A=
+static void semanage_direct_destroy(semanage_handle_t *sh);=0A=
+static int semanage_direct_disconnect(semanage_handle_t *sh);=0A=
+static int semanage_direct_begintrans(semanage_handle_t *sh);=0A=
+static int semanage_direct_commit(semanage_handle_t *sh);=0A=
+static int semanage_direct_install(semanage_handle_t *sh, char *data, =
size_t data_len);=0A=
+static int semanage_direct_upgrade(semanage_handle_t *sh,=0A=
+				   char *data, size_t data_len);=0A=
+static int semanage_direct_install_base(semanage_handle_t *sh,=0A=
+					char *base_data, size_t data_len);=0A=
+static int semanage_direct_remove(semanage_handle_t *sh,=0A=
+				  char *module_name);=0A=
+static int semanage_direct_list(semanage_handle_t *sh,=0A=
+				semanage_module_info_t **modinfo, int *num_modules);=0A=
+=0A=
+static struct semanage_func_table direct_funcs =3D {=0A=
+	.destroy =3D semanage_direct_destroy,=0A=
+	.disconnect =3D semanage_direct_disconnect,=0A=
+	.begin_trans =3D semanage_direct_begintrans,=0A=
+	.commit =3D semanage_direct_commit,=0A=
+	.install =3D semanage_direct_install,=0A=
+	.upgrade =3D semanage_direct_upgrade,=0A=
+	.install_base =3D semanage_direct_install_base,=0A=
+	.remove =3D semanage_direct_remove,=0A=
+	.list =3D semanage_direct_list=0A=
+};=0A=
+=0A=
+/* Check that the module store exists, creating it if necessary.=0A=
+ */=0A=
+int semanage_direct_connect(semanage_handle_t *sh) {=0A=
+	if (semanage_create_store(sh, 1) < 0) {=0A=
+		return -1;=0A=
+	}=0A=
+=0A=
+	sh->conn.module.translock_file_fd =3D -1;=0A=
+	sh->conn.module.readlock_file_fd =3D -1;=0A=
+=0A=
+	/* set up function pointers */=0A=
+	sh->funcs =3D &direct_funcs;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static void semanage_direct_destroy(semanage_handle_t *sh) {=0A=
+	/* do nothing */=0A=
+}=0A=
+=0A=
+static int semanage_direct_disconnect(semanage_handle_t *sh) {=0A=
+	/* destroy transaction */=0A=
+	if (sh->is_in_transaction) {=0A=
+		/* destroy sandbox */=0A=
+		if (semanage_remove_directory(semanage_path(SEMANAGE_TMP, =
SEMANAGE_TOPLEVEL)) < 0) {=0A=
+			semanage_write_error(sh, "Could not cleanly remove sandbox %s.", =
semanage_path(SEMANAGE_TMP, SEMANAGE_TOPLEVEL));=0A=
+			return -1;=0A=
+		}=0A=
+		semanage_release_trans_lock(sh);=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+static int semanage_direct_begintrans(semanage_handle_t *sh) {=0A=
+	if (semanage_get_trans_lock(sh) < 0) {=0A=
+		return -1;=0A=
+	}=0A=
+	if ((semanage_make_sandbox(sh)) < 0) {=0A=
+		return -1;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/********************* utility functions *********************/=0A=
+=0A=
+/* Takes a module stored in 'module_data' and parses its headers.=0A=
+ * Sets reference variables 'filename' to module's fully qualified=0A=
+ * path name into the sandbox, 'module_name' to module's name, and=0A=
+ * 'version' to module's version.  The caller is responsible for=0A=
+ * free()ing 'filename', 'module_name', and 'version'; they will be=0A=
+ * set to NULL upon entering this function.  Returns 0 on success, -1=0A=
+ * if out of memory, or -2 if data did not represent a module.=0A=
+ */=0A=
+static int parse_module_headers(semanage_handle_t *sh, char =
*module_data,=0A=
+				size_t data_len, char **module_name,=0A=
+				char **version, char **filename) {=0A=
+	struct policy_file pf;=0A=
+	int file_type;=0A=
+	const char *module_path;=0A=
+	*module_name =3D *version =3D *filename =3D NULL;=0A=
+	pf.type =3D PF_USE_MEMORY;=0A=
+	pf.data =3D module_data;=0A=
+	pf.len =3D data_len;=0A=
+	pf.fp =3D NULL;=0A=
+	if (module_data =3D=3D NULL ||=0A=
+	    data_len =3D=3D 0 ||=0A=
+	    sepol_module_package_info(&pf, &file_type, module_name,=0A=
+				      version) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not parse module data.");=0A=
+		return -2;=0A=
+	}=0A=
+	if (file_type !=3D POLICY_MOD) {=0A=
+		semanage_write_error(sh, "Data did not represent a module.");=0A=
+		return -2;=0A=
+	}=0A=
+	if ((module_path =3D semanage_path(SEMANAGE_TMP, SEMANAGE_MODULES)) =
=3D=3D NULL) {=0A=
+		return -1;=0A=
+	}=0A=
+	if (asprintf(filename, "%s/%s.pp", module_path, *module_name) =3D=3D =
-1) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		return -1;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Takes a base module stored in 'module_data' and parse its headers.=0A=
+ * Returns 0 on success, -1 if out of memory, or -2 if data did not=0A=
+ * represent a module.=0A=
+ */=0A=
+static int parse_base_headers(semanage_handle_t *sh,=0A=
+			      char *module_data, size_t data_len) {=0A=
+	struct policy_file pf;=0A=
+	char *module_name =3D NULL, *version =3D NULL;=0A=
+	int file_type;=0A=
+	pf.type =3D PF_USE_MEMORY;=0A=
+	pf.data =3D module_data;=0A=
+	pf.len =3D data_len;=0A=
+	pf.fp =3D NULL;=0A=
+	if (module_data =3D=3D NULL ||=0A=
+	    data_len =3D=3D 0 ||=0A=
+	    sepol_module_package_info(&pf, &file_type,=0A=
+				      &module_name, &version) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not parse base module data.");=0A=
+		return -2;=0A=
+	}=0A=
+	free(module_name);=0A=
+	free(version);=0A=
+	if (file_type !=3D POLICY_BASE) {=0A=
+		semanage_write_error(sh, "Data did not represent a module.");=0A=
+		return -2;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Writes a block of data to a file.  Returns 0 on success, -1 on=0A=
+ * error. */=0A=
+static int write_file(semanage_handle_t *sh,=0A=
+		      const char *filename, char *data, size_t num_bytes) {=0A=
+	int out;=0A=
+	if ((out =3D open(filename, O_WRONLY | O_CREAT, S_IRUSR | S_IWUSR)) =
=3D=3D -1) {=0A=
+		semanage_write_error(sh, "Could not open %s for writing.", filename);=0A=
+		return -1;=0A=
+	}=0A=
+	if (write(out, data, num_bytes) =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while writing to %s.", filename);=0A=
+		close(out);=0A=
+		return -1;=0A=
+	}=0A=
+	close(out);=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/* Writes a module (or a base) to the file given by a fully-qualified=0A=
+ * 'filename'.	Returns 0 on success, -1 if file could not be written.=0A=
+ */=0A=
+static int semanage_write_module(semanage_handle_t *sh,=0A=
+				 const char *filename, sepol_module_package_t *package,=0A=
+				 uint32_t policy_type) {=0A=
+	struct policy_file pf;=0A=
+	FILE *outfile;=0A=
+	int retval;=0A=
+	if (sepol_set_policyvers(policy_type, MOD_POLICYDB_VERSION_MAX) !=3D =
0) {=0A=
+		semanage_write_error(sh, "Unknown/Invalid policy version %d.", =
sh->conf->policyvers);=0A=
+		return -1;=0A=
+	}=0A=
+	if ((outfile =3D fopen(filename, "wb")) =3D=3D NULL) {=0A=
+		semanage_write_error(sh, "Could not open %s for writing.", filename);=0A=
+		return -1;=0A=
+	}=0A=
+	pf.type =3D PF_USE_STDIO;=0A=
+	pf.fp =3D outfile;=0A=
+	retval =3D sepol_module_package_write(package, &pf);=0A=
+	fclose(outfile);=0A=
+	if (retval =3D=3D -1) {=0A=
+		semanage_write_error(sh, "Error while writing module to %s.", =
filename);=0A=
+		return -1;=0A=
+	}=0A=
+	return 0;=0A=
+}=0A=
+=0A=
+/********************* direct API functions ********************/=0A=
+=0A=
+/* Commits all changes in sandbox to the actual kernel policy.=0A=
+ * Returns 0 on success, -1 on error.=0A=
+ */=0A=
+static int semanage_direct_commit(semanage_handle_t *sh) {=0A=
+	char **mod_filenames =3D NULL;=0A=
+	const char *linked_filename =3D NULL, *fc_filename =3D NULL;=0A=
+	sepol_module_package_t *base =3D NULL;=0A=
+	int retval =3D -1, num_modfiles =3D 0, i;=0A=
+=0A=
+	/* link all modules in the sandbox to the base module */=0A=
+	if (semanage_get_modules_names(sh, &mod_filenames, &num_modfiles) !=3D =
0 ||=0A=
+	    semanage_verify_modules(sh, mod_filenames, num_modfiles) =3D=3D -1 =
||=0A=
+	    semanage_link_sandbox(sh, &base) < 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+=0A=
+	/* write the linked base */=0A=
+	if ((linked_filename =3D semanage_path(SEMANAGE_TMP, SEMANAGE_LINKED)) =
=3D=3D NULL ||=0A=
+	    semanage_write_module(sh, linked_filename, base, POLICY_BASE) =
=3D=3D -1 ||=0A=
+	    semanage_verify_linked(sh) !=3D 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+=0A=
+	/* write the linked file contexts */=0A=
+	if ((fc_filename =3D semanage_path(SEMANAGE_TMP, SEMANAGE_FC)) =3D=3D =
NULL ||=0A=
+	    write_file(sh, fc_filename, base->file_contexts, =
base->file_contexts_len) =3D=3D -1) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+=0A=
+	/* expand and verify the resulting policy */=0A=
+	if (semanage_expand_sandbox(sh, base) < 0 ||=0A=
+	    semanage_verify_kernel(sh) !=3D 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+=0A=
+	retval =3D semanage_install_sandbox(sh);=0A=
+=0A=
+ cleanup:=0A=
+	for (i =3D 0; mod_filenames !=3D NULL && i < num_modfiles; i++) {=0A=
+		free(mod_filenames[i]);=0A=
+	}=0A=
+	free(mod_filenames);=0A=
+	sepol_module_package_destroy(base);=0A=
+	semanage_release_trans_lock(sh);=0A=
+=0A=
+	/* regardless if the commit was successful or not, remove the=0A=
+	   sandbox if it is still there */=0A=
+	semanage_remove_directory(semanage_path(SEMANAGE_TMP, =
SEMANAGE_TOPLEVEL));=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+=0A=
+/* Writes a module to the sandbox's module directory, overwriting any=0A=
+ * previous module stored within.  Note that module data are not=0A=
+ * free()d by this function; caller is responsible for deallocating it=0A=
+ * if necessary.  Returns 0 on success, -1 if out of memory, -2 if the=0A=
+ * data does not represent a valid module file, -3 if error while=0A=
+ * writing file. */=0A=
+static int semanage_direct_install(semanage_handle_t *sh,=0A=
+				   char *data, size_t data_len) {=0A=
+	=0A=
+	int retval;=0A=
+	char *module_name =3D NULL, *version =3D NULL, *filename =3D NULL;=0A=
+	if ((retval =3D parse_module_headers(sh, data, data_len,=0A=
+					   &module_name, &version, &filename)) !=3D 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (write_file(sh, filename, data, data_len) =3D=3D -1) {=0A=
+		retval =3D -3;=0A=
+	}=0A=
+	retval =3D 0;=0A=
+ cleanup:=0A=
+	free(version);=0A=
+	free(filename);=0A=
+	free(module_name);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Similar to semanage_direct_install(), except that it checks that=0A=
+ * there already exists a module with the same name and that the=0A=
+ * module is an older version then the one in 'data'.  Returns 0 on=0A=
+ * success, -1 if out of memory, -2 if the data does not represent a=0A=
+ * valid module file, -3 if error while writing file or reading=0A=
+ * modules directory, -4 if there does not exist an older module or if=0A=
+ * the previous module is same or newer than 'data'.=0A=
+ */=0A=
+static int semanage_direct_upgrade(semanage_handle_t *sh,=0A=
+				   char *data, size_t data_len) {=0A=
+	int i, retval, num_modules =3D 0;=0A=
+	char *module_name =3D NULL, *version =3D NULL, *filename =3D NULL;=0A=
+	semanage_module_info_t *modinfo =3D NULL;=0A=
+	if ((retval =3D parse_module_headers(sh, data, data_len,=0A=
+					   &module_name, &version, &filename)) !=3D 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (semanage_direct_list(sh, &modinfo, &num_modules) < 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	retval =3D -4;=0A=
+	for (i =3D 0; i < num_modules; i++) {=0A=
+		semanage_module_info_t *m =3D semanage_module_list_nth(modinfo, i);=0A=
+		if (strcmp(semanage_module_get_name(m), module_name) =3D=3D 0) {=0A=
+			if (strverscmp(version, semanage_module_get_version(m)) > 0) {=0A=
+				retval =3D 0;=0A=
+				break;=0A=
+			}=0A=
+			else {=0A=
+				semanage_write_error(sh, "Previous module %s is same or newer.", =
module_name);=0A=
+				retval =3D -4;=0A=
+				goto cleanup;=0A=
+			}=0A=
+		}=0A=
+	}=0A=
+	if (retval =3D=3D -4) {=0A=
+		semanage_write_error(sh, "There does not already exist a module named =
%s.", module_name);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (write_file(sh, filename, data, data_len) =3D=3D -1) {=0A=
+		retval =3D -3;=0A=
+	}=0A=
+ cleanup:=0A=
+	free(version);=0A=
+	free(filename);=0A=
+	free(module_name);=0A=
+	for (i =3D 0; modinfo !=3D NULL && i < num_modules; i++) {=0A=
+		semanage_module_info_t *m =3D semanage_module_list_nth(modinfo, i);=0A=
+		semanage_module_info_datum_destroy(m);=0A=
+	}=0A=
+	free(modinfo);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Writes a base module into a sandbox, overwriting any previous base=0A=
+ * module.  Note that 'module_data' is not free()d by this function;=0A=
+ * caller is responsible for deallocating it if necessary.  Returns 0=0A=
+ * on success, -1 if out of memory, -2 if the data does not represent=0A=
+ * a valid base module file, -3 if error while writing file.=0A=
+ */=0A=
+static int semanage_direct_install_base(semanage_handle_t *sh,=0A=
+					char *base_data, size_t data_len) {=0A=
+	int retval =3D -1;=0A=
+	const char *filename =3D NULL;=0A=
+	if ((retval =3D parse_base_headers(sh, base_data, data_len)) !=3D 0) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if ((filename =3D semanage_path(SEMANAGE_TMP, SEMANAGE_BASE)) =3D=3D =
NULL) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (write_file(sh, filename, base_data, data_len) =3D=3D -1) {=0A=
+		retval =3D -3;=0A=
+	}=0A=
+	retval =3D 0;=0A=
+ cleanup:=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+/* Removes a module from the sandbox.  Returns 0 on success, -1 if out=0A=
+ * of memory, -2 if module not found or could not be removed. */=0A=
+static int semanage_direct_remove(semanage_handle_t *sh,=0A=
+				  char *module_name) {=0A=
+	int i, retval =3D -1;=0A=
+	char **module_filenames =3D NULL;=0A=
+	int num_mod_files;=0A=
+	size_t name_len =3D strlen(module_name);=0A=
+	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) =
=3D=3D -1) {=0A=
+		return -1;=0A=
+	}=0A=
+	for (i =3D 0; i < num_mod_files; i++) {=0A=
+		char *base =3D strrchr(module_filenames[i], '/');=0A=
+		if (base =3D=3D NULL) {=0A=
+			semanage_write_error(sh, "Could not read module names.");=0A=
+			retval =3D -2;=0A=
+			goto cleanup;=0A=
+		}=0A=
+		base++;=0A=
+		if (memcmp(module_name, base, name_len) =3D=3D 0 &&=0A=
+		    strcmp(base + name_len, ".pp") =3D=3D 0) {=0A=
+			if (unlink(module_filenames[i]) =3D=3D -1) {=0A=
+				semanage_write_error(sh, "Could not remove module file %s.", =
module_filenames[i]);=0A=
+				retval =3D -2;=0A=
+			}=0A=
+			retval =3D 0;=0A=
+			goto cleanup;=0A=
+		}=0A=
+	}=0A=
+	semanage_write_error(sh, "Module %s was not found.", module_name);=0A=
+	retval =3D -2;				/* module not found */=0A=
+ cleanup:=0A=
+	for (i =3D 0; module_filenames !=3D NULL && i < num_mod_files; i++) {=0A=
+		free(module_filenames[i]);=0A=
+	}=0A=
+	free(module_filenames);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+=0A=
+/* Allocate an array of module_info structures for each readable=0A=
+ * module within the store.  Note that if the calling program has=0A=
+ * already begun a transaction then this function will get a list of=0A=
+ * modules within the sandbox.	The caller is responsible for calling=0A=
+ * semanage_module_info_datum_destroy() on each element of the array=0A=
+ * as well as free()ing the entire list.=0A=
+ */=0A=
+static int semanage_direct_list(semanage_handle_t *sh,=0A=
+				semanage_module_info_t **modinfo, int *num_modules) {=0A=
+	int i, retval =3D -1;=0A=
+	char **module_filenames =3D NULL;=0A=
+	int num_mod_files;=0A=
+	*modinfo =3D NULL;=0A=
+	*num_modules =3D 0;=0A=
+=0A=
+	if (semanage_get_read_lock(sh) < 0) {=0A=
+		return -1;=0A=
+	}=0A=
+	if (semanage_get_modules_names(sh, &module_filenames, &num_mod_files) =
=3D=3D -1) {=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if (num_mod_files =3D=3D 0) {=0A=
+		retval =3D semanage_get_commit_number(sh);=0A=
+		goto cleanup;=0A=
+	}=0A=
+	if ((*modinfo =3D calloc(num_mod_files, sizeof(**modinfo))) =3D=3D =
NULL) {=0A=
+		semanage_write_error(sh, "Out of memory!");=0A=
+		goto cleanup;=0A=
+	}=0A=
+	for (i =3D 0; i < num_mod_files; i++) {=0A=
+		char *name =3D NULL, *version =3D NULL;=0A=
+		struct policy_file pf;=0A=
+		int type;=0A=
+		if ((pf.fp =3D fopen(module_filenames[i], "rb")) =3D=3D NULL) {=0A=
+			/* could not open this module file, so don't=0A=
+			 * report it */=0A=
+			continue;=0A=
+		}=0A=
+		pf.type =3D PF_USE_STDIO;=0A=
+		if (sepol_module_package_info(&pf, &type, &name, &version)) {=0A=
+			fclose(pf.fp);=0A=
+			free(name);=0A=
+			free(version);=0A=
+			continue;=0A=
+		}=0A=
+		fclose(pf.fp);=0A=
+		if (type =3D=3D POLICY_MOD) {=0A=
+			(*modinfo)[*num_modules].name =3D name;=0A=
+			(*modinfo)[*num_modules].version =3D version;=0A=
+			(*num_modules)++;=0A=
+		}=0A=
+		else {=0A=
+			/* file was not a module, so don't report it */=0A=
+			free(name);=0A=
+			free(version);=0A=
+		}=0A=
+	}=0A=
+	retval =3D semanage_get_commit_number(sh);=0A=
+	=0A=
+ cleanup:=0A=
+	for (i =3D 0; module_filenames !=3D NULL && i < num_mod_files; i++) {=0A=
+		free(module_filenames[i]);=0A=
+	}=0A=
+	free(module_filenames);=0A=
+	semanage_release_read_lock(sh);=0A=
+	return retval;=0A=
+}=0A=
+=0A=
+hidden_def(semanage_direct_connect)=0A=
Binary files libsemanage/src/direct-api.o and =
libsemanage/src/direct-api.o differ=0A=

------=_NextPart_000_001C_01C5C340.08B06B70--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
